#! /bin/bash
# Bash prompt withi Promptastic

# Installation (YMMV)
# 1/ Install Promptastic [1]
#    $ cd ~/opt/
#    $ git clone t clone https://github.com/nimiq/promptastic.git
# 
# 2/ Install the font (follow "fontconfig" instructions at [2])
#    $ cd ~/.fonts/
#    $ wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
#    $ fc-cache -vf ~/.fonts
#    $ mkdir ~/.fonts.conf.d/ && cd ~/.fonts.conf.d/
#    $ wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
# 3/ Restart shell
#
# [2] https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation

#  Promptastic is assumed to be installed in $promptastic_home
promptastic_home=~/opt/promptastic


function _update_ps1() {
  PS1="$(${promptastic_home}/promptastic.py $?)"
  export PS1
}

if [ -f "${promptastic_home}/promptastic.py" ]; then
  export PROMPT_COMMAND="history -a;_update_ps1"
fi
