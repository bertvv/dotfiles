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

