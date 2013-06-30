# Bash prompt
# Credits:
#  Colors: https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#  Prompt with Git status: https://github.com/gf3/dotfiles/

# Load color definitions from this directory
. ${HOME}/.bash.d/colors.sh

# Git status
function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}

function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Root?
if [[ ${UID} -eq 0 ]]; then
    UserColor=${BIRed}
else
    UserColor=${BIGreen}
fi


# Set the prompt:
export PS1="\[${UserColor}\]\u\[${White}\]@\[${Yellow}\]\h\[${White}\]:\[${BIBlue}\]\w\[${White}\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \")[\[${BIPurple}\]\$(parse_git_branch)\[${White}\]]\n\$ \[${Reset}\]"
export PS2="\[${Yellow}\]→ \[${Reset}\]"
