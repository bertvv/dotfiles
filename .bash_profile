# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

# Source extra init scripts in .bash.d/
for f in $(ls ~/.bash.d/*.sh); do
    [ -r "${f}" ] && source "${f}"
done
