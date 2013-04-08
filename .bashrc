# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

# Source extra init scripts in .bash.d/
for f in $(ls ~/.bash.d/*.sh); do
    [ -r "${f}" ] && source "${f}"
done

