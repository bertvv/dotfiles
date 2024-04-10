#! /usr/bin/env bash
#
# Bash functions
#

# Usage: fail [ARG]...
#
# Prints all arguments on the standard error stream, in red
_fail() {
  printf '\e[0;31m!!! %s\e[0m\n' "${*}" 1>&2
}

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
mkdir -p "$@" && cd "$@" || return 1
}

# Search in the history for the commands that are used the most
# Credits: https://coderwall.com/p/o5qijw
topcmd() {
  history \
    | awk '{a[$4]++}END{for(i in a){print a[i] " " i}}' \
    | sort -rn \
    | head
}

# Print a list of manually installed packages
# credits: https://unix.stackexchange.com/a/639245
listinstalled() {
  dnf repoquery --userinstalled \
    | sed 's/-[0-9].*//'
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

