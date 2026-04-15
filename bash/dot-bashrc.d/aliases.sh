# Bash aliases

# Shortcuts for often used commands, a.o. based on top commands in Bash
# history (see functions.sh, topcmd function)
# Credit https://coderwall.com/p/o5qijw

alias notes='code ~/Documents/Notes/'
alias r='ranger'
alias o='xdg-open'
alias n='nvim'
alias N='nvim .'
alias ns='nvim ~/.config/nvim/'
alias act='source .venv/bin/activate'

# Git
# Git author stats
alias a='git add'
alias c='git commit -m'
alias d='git diff'
alias g='git'
alias gca='git commit --amend'
alias gp='git pull --rebase --autostash'
alias gpd='for dir in ./*/; do echo "=== ${dir} ==="; cd "${dir}"; git pull --rebase --autostash; cd ..; done'
alias gpr='git pull --rebase --autostash'
alias gr='git restore .'
alias gs='git ls-tree -r -z --name-only HEAD | xargs -0 -n1 git blame --line-porcelain | grep  "^author "|sort|uniq -c|sort -nr'
alias h='git log --pretty="format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar" --date=short --graph'
alias p='git pull --rebase && git push && git push --tags'
alias pr='git pull --rebase --autostash'
alias pt='git push -u origin --tags'
alias s='git status'

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

# Docker Docker Docker Docker Docker Docker Docker Docker
# "docker status"
alias ds='echo -e "${Yellow}Images${Reset}"; podman images; echo -e "${Yellow}Containers${Reset}"; podman ps --all'
# "docker cleanup": Clean up volumes with status ‘exited’ and ‘dangling’ images
alias dC='podman rm --volumes $(podman ps --all --quiet --filter="status=exited") > /dev/null 2>&1; podman rmi $(podman images --filter="dangling=true" --quiet) > /dev/null 2>&1'
# Stop all running containers and clean up
alias dCC='podman stop $(podman ps --quiet) > /dev/null 2>&1; podman rm --volumes $(podman ps --all --quiet --filter="status=exited") > /dev/null 2>&1; podman rmi $(podman images --filter="dangling=true" --quiet) > /dev/null 2>&1'
# "docker ssh": Open a shell console into the latest created Docker container
alias dS='podman exec --interactive --tty $(podman ps --latest --quiet) env TERM=xterm /bin/bash'
# "docker halt"
alias dh='podman stop'
alias dip='podman inspect  --format="{{ .NetworkSettings.IPAddress }}" $(podman ps --latest --quiet)'

# Directory listing and file system
# Use rational units/formats in file size & date output
alias df='df --si'
alias du='du --total --si'
alias l='eza --long --time-style=long-iso --color --icons --git'
alias Z='eza --long --time-style=long-iso --color --icons --git --context'
alias lt='eza --long --time-style=long-iso --color --icons --git --sort=modified --reverse'
alias tree='tree -AC'
alias diff='diff --color --unified'

# Avoid mistakes when copying or (re)moving files.
alias rm='rm --interactive=once' # Ask once if the user is sure
alias cp='cp --recursive --interactive'
alias mv='mv --interactive'
alias cd='z'  # Uze zOxide for cd

# Find stuff
alias ff='find . -type f -name '

alias bc='bc --mathlib' # Start bc with support for rational numbers
alias sudo='sudo '

# Notification after long commands, e.g. sleep 10; alert
alias alert='tput bel; notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "Done: $(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Source: Luciano Quercia
# https://dev.to/djviolin/what-are-your-unix-pipeline-commands-that-saved-you-from-lot-of-codingtime-7ok/comments/185j
# Usage examples:
#   some_command | ctrlc
#   ctrlv | some_other_command
#   ctrlv >> some_file
alias ctrlc='xclip -selection clipboard -i'
alias ctrlv='xclip -selection clipboard -o'

# SSH without adding the target host to ~/.ssh/known_hosts
alias sshh='ssh -o UserKnownHostsFile=/dev/null '

alias ping='ping -c 4 '
