# Make vim the default editor
export EDITOR="vim"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups:ignorespace
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Shell settings
shopt -s histappend   # append to history, don't overwrite
shopt -s checkwinsize # update window size after each command
shopt -s nocaseglob   # case insensitive globbing
shopt -s cdspell      # autocorrect typos in path names when using 'cd'
shopt -s autocd       # entering a directory as command will cd into it
shopt -s cmdhist      # enter multi-line commands as one entry
shopt -s globstar     # allow use of ** in file globbing

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Set umask to a safer value
umask 077
