#! /usr/bin/env bash
#
# Bash functions
#

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
# Credits: https://github.com/mathiasbynens/dotfiles/

getcertnames() {
if [ -z "${1}" ]; then
    echo "ERROR: No domain specified."
    return 1
fi

local domain="${1}"
echo "Testing ${domain}…"
echo # newline

local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
    | openssl s_client -connect "${domain}:443" 2>&1);

if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText=$(echo "${tmp}" \
        | openssl x509 -text -certopt "no_header, no_serial, no_version, \
        no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux");
    echo "Common Name:"
    echo # newline
    echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//";
    echo # newline
    echo "Subject Alternative Name(s):"
    echo # newline
    echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
        | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
    return 0
else
    echo "ERROR: Certificate not found.";
    return 1
fi

}

# Create a new directory and enter it
# Credits: https://github.com/mathiasbynens/dotfiles/
mkd() {
mkdir -p "$@" && cd "$@"
}

# Search in the history for the commands that are used the most
# Credits: https://coderwall.com/p/o5qijw
topcmd() {
history | awk '{a[$4]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

# Validate the syntax of an ERB template
# Source: Turnbull & McCune (2011). Pro Puppet. Apress. (p. 51)
validate_erb() {
erb -x -T '-' "${1}" | ruby -c
}

# Print a list of manually installed packages
# credits: http://forums.fedoraforum.org/showpost.php?p=1606568&postcount=12
listinstalled() {
  yumdb search command_line "*install*" \
    | grep command_line \
    | sed 's/.*install//' \
    | tr ' ' '\n' \
    | sort --unique
}

# Find files with the specified pattern (case insensitive) in the name
# Credits: @purlpleidea, Quick Devops Hacks, talk at Infrastructure.Next
#  2015 Ghent
ifind ()
{
  if [ "$#" = "0" ]; then
    echo "Usage: ifind PATTERN [DIR]..." 1>&2
    return 1
  fi
  pattern="$1";
  shift;
  if [ "$#" = "0" ]; then
    set ".";
  fi;
  for dir in "$@"; do
    find "${dir}" -iname "*${pattern}*";
    shift;
  done
}

# Function that finds patterns in files within a directory structure
# Consider `ack` instead...
function igrep {
  if [ "$#" = "0" ]; then
    echo "Usage: igrep PATTERN [DIR]..." 1>&2
    return 1
  fi
  pattern="$1";
  shift;
  if [ "$#" = "0" ]; then
    set ".";
  fi;
  for dir in "$@"; do
    find "${dir}" -type f -exec grep -inH "${pattern}" {} \;
    shift;
  done
}

# vagrant screen
# Credits: https://ttboj.wordpress.com/2014/01/02/vagrant-clustered-ssh-and-screen/
function vscreen {
    [ "$1" = '' ] || [ "$2" != '' ] && echo "Usage: vscreen <vm-name> - vagrant screen" 1>&2 && return 1
    wd=$(pwd)        # save wd, then find the Vagrant project
    while [ "$(pwd)" != '/' ] && [ ! -e "$(pwd)/Vagrantfile" ] && [ ! -d "$(pwd)/.vagrant/" ]; do
        #echo "pwd is `pwd`"
        cd ..
    done
    pwd=${pwd}
    cd "${wd}"
    if [ ! -e "${pwd}/Vagrantfile" ] || [ ! -d "${pwd}/.vagrant/" ]; then
        echo 'Vagrant project not found!' 1>&2 && return 2
    fi

    d="${pwd}/.ssh"
    f="${d}/$1.config"
    h="$1"
    # hostname extraction from user@host pattern
    p=$(expr index "$1" '@')
    if [ "${p}" -gt 0 ]; then
        let "l = ${#h} - ${p}"
        h=${h:$p:$l}
    fi

    # if mtime of $f is > than 5 minutes (5 * 60 seconds), re-generate...
    if [ $(date -d "now - $(stat -c '%Y' "${f}" 2> /dev/null) seconds" +%s) -gt 300 ]; then
        mkdir -p "${d}"
        # we cache the lookup because this command is slow...
        vagrant ssh-config "${h}" > "${f}" || rm "${f}"
    fi
    [ -e "${f}" ] && ssh -t -F "${f}" "$1" 'screen -xRR'
}

# vagrant cssh
# Credits: https://ttboj.wordpress.com/2014/01/02/vagrant-clustered-ssh-and-screen/
# Example:  vcssh srv00{1..4} -l root
function vcssh {
[ "$1" = '' ] && echo "Usage: vcssh [options] [user@]<vm1>[ [user@]vm2[ [user@]vmN...]] - vagrant cssh" 1>&2 && return 1
wd=`pwd`        # save wd, then find the Vagrant project
while [ "`pwd`" != '/' ] && [ ! -e "`pwd`/Vagrantfile" ] && [ ! -d "`pwd`/.vagrant/" ]; do
  #echo "pwd is `pwd`"
  cd ..
done
pwd=`pwd`
cd $wd
if [ ! -e "$pwd/Vagrantfile" ] || [ ! -d "$pwd/.vagrant/" ]; then
  echo 'Vagrant project not found!' 1>&2 && return 2
fi

d="$pwd/.ssh"
cssh="$d/cssh"
cmd=''
cat='cat '
screen=''
options=''

multi='f'
special=''
for i in "$@"; do   # loop through the list of hosts and arguments!
  #echo $i

  if [ "$special" = 'debug' ]; then   # optional arg value...
    special=''
    if [ "$1" -ge 0 -o "$1" -le 4 ]; then
      cmd="$cmd $i"
      continue
    fi
  fi

  if [ "$multi" = 'y' ]; then # get the value of the argument
    multi='n'
    cmd="$cmd '$i'"
    continue
  fi

  if [ "${i:0:1}" = '-' ]; then   # does argument start with: - ?

    # build a --screen option
    if [ "$i" = '--screen' ]; then
      screen=' -o RequestTTY=yes'
      cmd="$cmd --action 'screen -xRR'"
      continue
    fi

    if [ "$i" = '--debug' ]; then
      special='debug'
      cmd="$cmd $i"
      continue
    fi

    if [ "$i" = '--options' ]; then
      options=" $i"
      continue
    fi

    # NOTE: commented-out options are probably not useful...
    # match for key => value argument pairs
    if [ "$i" = '--action' -o "$i" = '-a' ] || \
      [ "$i" = '--autoclose' -o "$i" = '-A' ] || \
      #[ "$i" = '--cluster-file' -o "$i" = '-c' ] || \
      #[ "$i" = '--config-file' -o "$i" = '-C' ] || \
      #[ "$i" = '--evaluate' -o "$i" = '-e' ] || \
      [ "$i" = '--font' -o "$i" = '-f' ] || \
      #[ "$i" = '--master' -o "$i" = '-M' ] || \
      #[ "$i" = '--port' -o "$i" = '-p' ] || \
      #[ "$i" = '--tag-file' -o "$i" = '-c' ] || \
      [ "$i" = '--term-args' -o "$i" = '-t' ] || \
      [ "$i" = '--title' -o "$i" = '-T' ] || \
      [ "$i" = '--username' -o "$i" = '-l' ] ; then
        multi='y'   # loop around to get second part
        cmd="$cmd $i"
        continue
    else            # match single argument flags...
      cmd="$cmd $i"
      continue
    fi
  fi

  f="$d/$i.config"
  h="$i"
  # hostname extraction from user@host pattern
  p=`expr index "$i" '@'`
  if [ $p -gt 0 ]; then
    let "l = ${#h} - $p"
    h=${h:$p:$l}
  fi

  # if mtime of $f is > than 5 minutes (5 * 60 seconds), re-generate...
  if [ `date -d "now - $(stat -c '%Y' "$f" 2> /dev/null) seconds" +%s` -gt 300 ]; then
    mkdir -p "$d"
    # we cache the lookup because this command is slow...
    vagrant ssh-config "$h" > "$f" || rm "$f"
  fi

  if [ -e "$f" ]; then
    cmd="$cmd $i"
    cat="$cat $f"   # append config file to list
  fi
done

cat="$cat > $cssh"
#echo $cat
eval "$cat"         # generate combined config file

#echo $cmd && return 1
#[ -e "$cssh" ] && cssh --options "-F ${cssh}$options" $cmd
# running: bash -c glues together --action 'foo --bar' type commands...
[ -e "$cssh" ] && bash -c "cssh --options '-F ${cssh}${screen}$options' $cmd"
}

# Usage: fail [ARG]...
#
# Prints all arguments on the standard error stream, in red
_fail() {
  printf '\e[0;31m!!! %s\e[0m\n' "${*}" 1>&2
}

# Change to a directory in a Johnny Decimal directory tree.
# Source: <https://johnnydecimal.com/concepts/working-at-the-terminal/>
cd_johnny_decimal() {
  target_dir="${1}"

  case "${target_dir}" in
    '')
      \cd "${HOME}" || return
      ;;
    [0-9][0-9].[0-9][0-9]) # e.g. 17.30, 58.34, ...
      \cd "${HOME}"/Documents/*/*/"${1}"* || return
      ;;
    [0-9][0-9])   # e.g. 01, 28, ...
      \cd "${HOME}"/Documents/*/"${1}"* || return
      ;;
    *)
      \cd "${target_dir}" || return
      ;;
  esac
}
alias cd='cd_johnny_decimal'

# Usage: index [depth]
#
# Prints an overview of all Johnny Decimal directories.
#
# depth  how deep in the directory structure the overview must be
#        can be 1 (only areas), 2 (areas and categories, default) or 
#        3 (all JD folders).
index() {
  depth="${1:-2}"
  jd_root="${HOME}/Documents"
  pushd "${jd_root}" > /dev/null || return
  for area in */; do
    printf '\e[97;44m%s\e[0m\n' "${area%/}"
    if [ "${depth}" -ge '2' ]; then
      pushd "${area}" > /dev/null || return
      for category in [0-9][0-9]*/; do
        printf '   %s\n' "${category%/}"
        if [ "${depth}" -ge '3' ]; then
          pushd "${category}" > /dev/null || return
          for folder in [0-9][0-9].[0-9][0-9]*/; do
            printf '      \e[0;94m%s\e[0m\n' "${folder%/}"
          done
          popd > /dev/null || return
        fi
      done
      popd > /dev/null || return
    fi
  done
  popd > /dev/null || return
}

# Save the index in a text file in the appropriate place in the JD directory tree.
save_index() {
  index_file="${HOME}/Documents/00-09 Meta/00 Index/00.00 index/index.txt"
  index 3 | perl -pe 's/\e\[[\d;]*m//g;' >| "${index_file}"
}
