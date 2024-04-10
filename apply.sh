#! /usr/bin/env bash
#
# Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
#/ Usage: SCRIPTNAME [OPTIONS]...
#/
#/ Install the dotfiles on the current host using GNU Stow. The files are kept
#/ in separate directories with paths relative to the home directory where they
#/ should be installed. You can pick which directories to install by
#/ enumerating
#/
#/ OPTIONS
#/   -h, --help
#/                Print this help message
#/   -n, --no
#/                Print what would be installed without actually executing
#/


#{{{ Bash settings
# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset
# don't hide errors within pipes
set -o pipefail
#}}}
#{{{ Variables
IFS=$'\t\n'   # Split on newlines and tabs (but not on spaces)
script_name=$(basename "${0}")
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Debug info ('on' to enable)
readonly debug='on'

# File containing the directories to install on this host
stow_dirs="$(hostname).dirs"

# If `yes`, run stow with the --no option
noop=no

readonly script_name script_dir stow_dirs
#}}}

main() {
  process_args "${@}"

  if ! which stow &> /dev/null; then
    error "Command 'stow' not found, install it first!"
    exit 1
  fi

  if [ ! -f "${stow_dirs}" ]; then
    error "I have no rules for this host."
    error "Create file '${stow_dirs}' with a list of directories to install"
    exit 1
  fi

  while read -r dir; do
    [ "${dir}" = '' ] && break
    log "Installing dir: ${dir}"
    if [ "${noop}" = 'yes' ]; then
      stow --target="${HOME}" --verbose=2 --no "${dir}"
    else
      stow --target="${HOME}" --verbose=2 "${dir}"
    fi
  done < "$(hostname).dirs"
}

#{{{ Helper functions

# Usage: process_args "${@}"
process_args() {
  for arg in "${@}"; do
    case "${arg}" in
      -h|--help)
        usage
        exit 0
        ;;
      -n|--no)
        noop=yes
        ;;
      -*)
        error "Unknow option: ${arg}"
        usage
        exit 2
        ;;
      *)
        error "This script does not take arguments"
        usage
        exit 2
        ;;
    esac
  done
}

# Print usage message on stdout by parsing start of script comments
# The comment should start with #/ followed by either a newline or a space
usage() {
  grep '^#/' "${script_dir}/${script_name}" | sed 's/^#\/\($\| \)//'
}

# Usage: log [ARG]...
#
# Prints all arguments on the standard output stream
log() {
  printf 'ℹ️  \e[0;34m%s\e[0m\n' "${*}"
}

# Usage: debug [ARG]...
#
# Prints all arguments on the standard output stream,
# if debug output is enabled
debug() {
  [ "${debug}" != 'on' ] || printf '🪲 \e[0;36mi%s\e[0m\n' "${*}"
}

# Usage: error [ARG]...
#
# Prints all arguments on the standard error stream
error() {
  printf '🔥 \e[0;31m%s\e[0m\n' "${*}" 1>&2
}

#}}}

main "${@}"

