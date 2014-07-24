# Bash prompt with Powerline-shell

#  Powerline-shell is assumed to be installed in $powerline_shell_home
powerline_shell_home=~/opt/powerline-shell


function _update_ps1() {
  export PS1="$(${powerline_shell_home}/powerline-shell.py $? 2> /dev/null)"
}

export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
