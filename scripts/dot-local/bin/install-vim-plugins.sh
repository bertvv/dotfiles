#! /usr/bin/env bash
#
# Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Installs Vim plugins specified in file ${plugins} from Github

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
YELLOW='\e[0;33m'
RED='\e[0;31m'
RESET='\e[0m'

# Vim configuration dir
readonly vim_home="${HOME}/.vim"

# Directory where plugins are installed
readonly plugin_dir="${vim_home}/pack/${HOSTNAME%%.*}/start"

# The file containing all Vim plugins that have to be installed
readonly plugins="${vim_home}/pack/plugins"
#}}}

main() {
  for plugin in $(get_plugin_urls); do
    process "${plugin}"
  done
}

#{{{ Helper functions

# Prints out the plugin url
get_plugin_urls() {
  if [ ! -f "${plugins}" ]; then
    die "File listing plugins (${plugins}) not found.
Create it and enter the Github repo urls of plugins to be installed"
  fi
  cat "${plugins}"
}

process() {
  local url="${1}"
  local repo_name="${url##*/}"
  local plugin_name="${repo_name%.git}"
  local target_dir="${plugin_dir}/${plugin_name}"

  if [ -d  "${target_dir}" ]; then
    log "Plugin ${plugin_name} seems already installed. Updating instead"
    update_git_repo "${target_dir}"
  else
    log "Installing ${plugin_name}"
    clone_git_repo "${url}" "${target_dir}"
  fi
}

# Usage: update_git_repo REPO_DIR
update_git_repo() {
  local repo_dir="${1}"

  pushd "${repo_dir}" > /dev/null 2>&1
  git pull origin master
  popd > /dev/null 2>&1
}

# Usage: clone_git_repo URL WORKING_DIRECTORY
clone_git_repo() {
  local repo_url="${1}"
  local working_directory="${2}"

  git clone "${repo_url}" "${working_directory}"
}

# Usage: log MESSAGE
#
# Prints a message to stdout
log() {
  printf "${YELLOW}%s${RESET}\n" "${*}"
}

# Usage: die MESSAGE
#
# Prints a message to stderr and exits with a nonzero exit status
die() {
  printf "${RED}Error: %s${RESET}\n" "${*}" 1>&2
  exit 1
}

#}}}

main "${@}"

