# Bash aliases

# Shortcuts for often used commands, a.o. based on top commands in Bash
# history (see functions.sh, topcmd function)
# Credit https://coderwall.com/p/o5qijw

# Git
alias a='git add'
alias c='git commit -m'
alias d='git diff'
alias g='git'
alias h='git log --pretty="format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar" --date=short --graph --all'
alias p='git push && git push --tags'
alias gp='git pull --rebase'
alias pr='git pull --rebase'
alias pt='git push -u origin --tags'
alias s='git status'
# Git author stats
alias gs='git ls-tree -r -z --name-only HEAD | xargs -0 -n1 git blame --line-porcelain | grep  "^author "|sort|uniq -c|sort -nr'

# Vagrant
alias v='vagrant'
alias vD='vagrant destroy --force'
alias vd='vagrant destroy'
alias vdu='vagrant destroy --force && vagrant up'
alias vh='vagrant halt'
alias vp='vagrant provision'
alias vr='vagrant reload'
alias vS='vagrant ssh'
alias vs='vagrant status'
alias vu='vagrant up'

# Ansible
alias ansible='ansible-3' # use Ansible based on Python 3

# Docker Docker Docker Docker Docker Docker Docker Docker
# "docker status"
alias ds='echo -e "${Yellow}Images${Reset}"; docker images; echo -e "${Yellow}Containers${Reset}"; docker ps --all'
# "docker cleanup": Clean up volumes with status ‘exited’ and ‘dangling’ images
alias dC='docker rm --volumes $(docker ps --all --quiet --filter="status=exited") > /dev/null 2>&1; docker rmi $(docker images --filter="dangling=true" --quiet) > /dev/null 2>&1'
# Stop all running containers and clean up
alias dCC='docker stop $(docker ps --quiet) > /dev/null 2>&1; docker rm --volumes $(docker ps --all --quiet --filter="status=exited") > /dev/null 2>&1; docker rmi $(docker images --filter="dangling=true" --quiet) > /dev/null 2>&1'
# "docker ssh": Open a shell console into the latest created Docker container
alias dS='docker exec --interactive --tty $(docker ps --latest --quiet) env TERM=xterm /bin/bash'
# "docker halt"
alias dh='docker stop'
alias dip='docker inspect  --format="{{ .NetworkSettings.IPAddress }}" $(docker ps --latest --quiet)'

# DNF
alias i='sudo dnf install -y'
alias y='sudo dnf'
alias yl='dnf list'
alias ys='dnf search'
alias yu='sudo dnf update'

# Directory listing and file system
# Use rational units/formats in file size & date output
alias df='df --si'
alias du='du --total --si'
alias l='ls -l --si --time-style=long-iso --color'
alias ls='ls -h --si --time-style=long-iso --color'
alias la='ls -la --si --time-style=long-iso --color'
alias ll='ls -l  --si --time-style=long-iso --color'
alias lh='ls -lh  --si --time-style=long-iso --color'
alias tree='tree -AC'
alias Z='ls -l -Z --si --color'

# Protect root against shooting himself in the foot
if [ "$(id -ru)" -eq "0" ]; then
    alias rm='rm --interactive=once'
    alias cp='cp --interactive=once'
    alias mv='mv --interactive=once'
else
  alias cp='cp -r'
fi

# Find stuff
alias ff='find . -type f -name '
alias fd='find . -type d -name '

alias sudo='sudo '

# Notification after long commands, e.g. sleep 10; alert
alias alert='tput bel; notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "Done: $(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Print CPU temperature
alias temp='cat /sys/bus/acpi/drivers/thermal/LNXTHERM\:00/thermal_zone/temp'

# Put the Fedora menu bar on the correct display, i.e. the laptop screen,
# not an external monitor
# credits: http://forums.fedoraforum.org/showpost.php?p=1462702&postcount=4
alias fixbar='xrandr --output LVDS-0 --primary'

# If Gvim/vim-X11 is installed, use it to enable X11 clipboard support
# otherwise, if vim-enhanced is installed, use that
if [ -x "/usr/bin/gvim" ]; then
    alias vi='gvim -v'
elif [ -x "/usr/bin/vim" ]; then
    alias vi='vim'
fi

# Let ip produce coloured output
alias ip='ip --color'

# Create a crypted password for use in a Linux shadow file
# Python library ’passlib’ should be installed
alias cryptpw='python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())" | sed "s/rounds=[0-9]*.//"'

# Source: Luciano Quercia
# https://dev.to/djviolin/what-are-your-unix-pipeline-commands-that-saved-you-from-lot-of-codingtime-7ok/comments/185j
# Usage examples:
#   some_command | ctrlc
#   ctrlv | some_other_command
#   ctrlv >> some_file
alias ctrlc='xclip -selection clipboard -i'
alias ctrlv='xclip -selection clipboard -o'

