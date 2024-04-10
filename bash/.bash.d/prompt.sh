#! /bin/bash
# Bash prompt withi Promptastic

# Installation (YMMV)
# 1/ Install Promptastic [1]
#    $ cd ~/.local/opt/
#    $ git clone https://github.com/nimiq/promptastic.git
#    $ git clone https://github.com/powerline/fonts.git --depth=1 powerline-fonts
# 2/ Install the font (follow "fontconfig" instructions at [2])
#    $ cd ~/.local/share/fonts/
#    $ wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
#    $ cd ~/.local/opt/powerline-fonts
#    $ ./install.sh
#    $ fc-cache -vf ~/.fonts
# 3/ Font config
#    $ mkdir -p ~/.config/fontconfig/conf.d/
#    $ wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
#    $ mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
# 4/ Restart shell (or log out/log in)
#
# [1] https://github.com/nimiq/promptastic
# [2] https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation
# [3] https://github.com/powerline/fonts

#  Promptastic is assumed to be installed in $promptastic_home
promptastic_home=~/.local/opt/promptastic


function _update_ps1() {
  PS1="$(${promptastic_home}/promptastic.py $?)"
  export PS1
}

if [ -f "${promptastic_home}/promptastic.py" ]; then
  export PROMPT_COMMAND="_update_ps1"
fi
