# Bash aliases

# Use rational units/formats in file size & date output
alias la='ls -la --si --time-style=long-iso'
alias ll='ls -l  --si --time-style=long-iso'
alias df='df --si'
alias du='du --total --si'

# Protect root against shooting himself in the foot
if [ $(id -ru) -eq 0 ]; then
    alias rm='rm --interactive=once'
    alias cp='cp --interactive=once'
    alias mv='mv --interactive=once'
fi

# Notification after long commands, e.g. sleep 10; alert
alias alert='tput bel; notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "Done: $(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Git stuff
alias push='git push -u origin --all' # push to Github

# Print CPU temperature
alias temp='cat /sys/bus/acpi/drivers/thermal/LNXTHERM\:00/thermal_zone/temp'

# Put the Fedora menu bar on the correct display, i.e. the laptop screen,
# not an external monitor
# credits: http://forums.fedoraforum.org/showpost.php?p=1462702&postcount=4
alias fixbar='xrandr --output LVDS-0 --primary'
