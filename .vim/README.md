.vim
====

To get things working, first create a link from ~/.vim/vimrc to ~/.vimrc (a symlink also works):

    ln ~/.vim/vimrc ~/.vimrc

Install plugins by creating Git submodules under ~/.vim/bundle, e.g.:

    git submodule add -f git://github.com/tpope/vim-sensible.git .vim/bundle/vim-sensible


