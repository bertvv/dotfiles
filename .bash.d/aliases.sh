# Bash aliases

# Shortcuts based on top commands in Bash history
# (see functions.sh, topcmd function)
# Credit https://coderwall.com/p/o5qijw
alias a='git add'
alias c='git commit -m'
alias d='git diff'
alias g='git'
alias h='git log --pretty="format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar" --date=short'
alias i='sudo yum install -y'
alias l='ls -l --si --time-style=long-iso'
alias p='git push'
alias pt='git push -u origin --tags'
alias s='git status'
alias t='todo'
alias th='todo ls @hogent'
alias v='vagrant'
alias y='sudo yum'
alias Z='ls -Z'

# Use rational units/formats in file size & date output
alias la='ls -la --si --time-style=long-iso'
alias ll='ls -l  --si --time-style=long-iso'
alias df='df --si'
alias du='du --total --si'

alias tree='tree -C'
alias gl='git log --pretty="format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar" --date=short'

# Protect root against shooting himself in the foot
if [ $(id -ru) -eq 0 ]; then
    alias rm='rm --interactive=once'
    alias cp='cp --interactive=once'
    alias mv='mv --interactive=once'
fi

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
if [[ -x "/usr/bin/gvim" ]]; then
    alias vi='gvim -v'
elif [[ -x "/usr/bin/vim" ]]; then
    alias vi='vim'
fi

# Puppet-lint with sane options
alias puppet-lint='puppet-lint --log-format "%{path}:%{linenumber}: %{KIND}: %{message}"'
