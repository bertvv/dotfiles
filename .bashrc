# .bashrc

# Source global definitions
if [ -r /etc/bashrc ]; then
    source /etc/bashrc
fi

# User specific aliases and functions

# Source extra init scripts in .bash.d/
for f in ~/.bash.d/*.sh; do
  [ -r "${f}" ] && source "${f}"
done


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

