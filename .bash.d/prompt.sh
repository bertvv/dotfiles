# Bash prompt with Powerline-shell

# Installation (YMMV)
# 1/ Install Powerline-shell [1]
#    $ cd ~/opt/
#    $ git clone https://github.com/milkbikis/powerline-shell
#    $ cd powerline-shell
#    $ ./install.py
# 2/ Install the font (follow "fontconfig" instructions at [2])
#    $ cd ~/.fonts/
#    $ wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
#    $ fc-cache -vf ~/.fonts
#    $ mkdir ~/.fonts.conf.d/ && cd ~/.fonts.conf.d/
#    $ wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
# 3/ Restart shell
#
# [1] https://github.com/milkbikis/powerline-shell
# [2] https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation

#  Powerline-shell is assumed to be installed in $powerline_shell_home
powerline_shell_home=~/opt/powerline-shell


function _update_ps1() {
  export PS1="$(${powerline_shell_home}/powerline-shell.py $? 2> /dev/null)"
}

export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
