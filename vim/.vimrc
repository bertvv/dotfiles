" .vimrc
"
" Author:   Bert Van Vreckem <bert.vanvreckem@gmail.com>
"
" Lots of inspiration comes from https://raw.github.com/teranex/dotvim/

syntax on
filetype plugin indent on

" Editor behaviour settings {{{
set nocompatible                        " no compatibility with old-skool vi
set backspace=indent,eol,start          " define behavior of backspace key
set history=1000                        " keep more history (was 50 in Debian config)
set encoding=utf-8                      " by default set the encoding to
set fileformats=unix,dos,mac            " also read mac files correctly, just in case we are dealing with that
"set nowrap                              " no line wrapping
"set foldlevelstart=99                   " by default, open all folds
set foldmethod=marker                   " marker fold method by default
"set foldnestmax=1                       " don't fold too deeply
set mouse=a                             " enable mouse
set mousemodel=popup                    " produce pop up for right click
set clipboard=unnamedplus               " Use desktop clipboard (CtrlC, CtrlV) as default
set scrolloff=3                         " minimal number of screen lines to keep above and below the cursor.
set sidescrolloff=3                     " minimal number of screen columns to keep next to the cursor
set sidescroll=5                        " horizontally scroll 5 characters, instead of centering the cursor
set wildmenu                            " show command line completions
set wildmode=longest:full               " complete mode for wildmenu
set wildmode+=full                      " when pressing tab a second time, fully complete
if exists("&wildignorecase")
    set wildignorecase                  " ignore case when completing filenames
endif
set linebreak                           " only wrap after words, not inside words
set completeopt=menu,longest,preview    " options for insert mode completion
"set spell                               " enable spell check by default
set tabstop=2                           " number of spaces that a tab counts for
set shiftwidth=2                        " number of spaces to use for each step of indent
set softtabstop=2                       " number of spaces that a tab counts for while editing
set shiftround                          " round the indent to a multiple of shiftwidth
set expandtab                           " expand tabs to spaces
set autoindent                          " automatically indent a new line
set formatoptions+=r                    " automatic formatting: auto insert current comment leader after enter
set virtualedit=block,onemore           " allow cursor after end of line in visual block mode and allow cursor one char after line end
set fillchars=vert:\ ,fold:-            " fill vertical splitlines with spaces instead of the ugly |-char; Default - for folds
set diffopt+=iwhite                     " diff options: ignore whitespace
set incsearch                           " while searching, immediately show first match
set ignorecase                          " ignore case in (search) patterns
set smartcase                           " when the (search) pattern contains uppercase chars, don't ignore case
set hlsearch                            " highlight all the matches for the search (disable until next search with :noh)
set directory=~/.vimswaps,.,/tmp        " where to store the swap files
set noswapfile                          " disable swap files, most of the time they are just annoying
set nobackup                            " don't make a (permanent) backup when saving files
"set writebackup                         " make a (temporary) backup while saving files

if v:version > '702'
    if $VIM !~ 'vimtouch'               " check that we are not running on Android (VimTouch)
        set undofile                    " save undo history to an external file
    endif
    set undodir=~/.vimundo,.,/tmp       " where to save undo history files
    set cryptmethod=blowfish            " use stronger blowfish encryption algorithm
endif
set updatetime=500                      " wait this many milliseconds before firing the CursorHold autocmd (and write swap files)

set autoread                            " automatically reload the file when modified outside and not modified inside vim
set autowrite                           " write the modified file when switching to another file
set hidden                              " allow Vim to switch to another buffer while the current is not saved

set tags=tags;/                         " where to find the tags file: current directory and up

" options for sessions. These define what should be saved in a session
set sessionoptions=buffers,folds,resize,tabpages,winsize,winpos

" set the path, so we can easily open files with the gf command etc
set path+=./**;,,

let mapleader = ","                     " Set the <Leader> key to comma (instead of backslash)

" Shell scripts with /bin/sh are POSIX compliant shells instead of original
" Bourne
let g:is_posix = 1
" }}}

" GUI options {{{

set number                              " line numbers
set t_Co=256                            " force the terminal to use 256 colors
set showcmd                             " show the current command in the statusline
"set list                                " show special chars, such as tab and eol
"set listchars=tab:→\ ,eol:·,trail:☐,extends:❱,precedes:❰ " chars to show for list
set showbreak=↪

set laststatus=2                        " always show the statusline
set title                               " set the title
set ruler                               " show cursor position in left bottom corner
set splitbelow                          " open a new horizontal window below the current window instead of above
"set cursorline                          " highlight the current line
"set cursorcolumn                        " highlight the current column
set display+=lastline                   " display wrapped lines at bottom instead of @ symbols
if v:version > '702'
    set colorcolumn=80,120              " show a vertical line at these positions
    set relativenumber                  " use relative line numbering
    set number                          " and show line number on selected line
endif

" Highlight trailing whitespace and TAB characters
" source: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t\|\t/

" colour scheme
"  beamer: turn off these colour schemes, use white shell bg
set background=light
colorscheme default

" }}}

" Plugin settings {{{
"

"--- LaTeX Suite ---
let g:tex_flavor='latex'
let g:Tex_BibTeXFlavor='biber'
au FileType tex setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_CompileRule_pdf = 'pdflatex -shell-escape -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf = 'latexmk -pdf $*'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_GotoError=0  " don't move focus to the QuickFix buffer
let g:Tex_FoldedMisc = 'slide,<<<'
let g:Tex_FoldedSections = 'chapter,section,subsection,subsubsection,paragraph'
set grepprg=grep\ -nH\ $* " Enable F9 autocomplete of BibTEX items
" Fix problem with insertin é in LaTeX mode
imap <buffer> <leader>it <Plug>Tex_InsertItemOnThisLine

"--- Vim Markdown ---
let g:vim_markdown_folding_disabled=1

"--- Vimwiki ---
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.markdown'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown',
            \ '.markdown': 'markdown',
            \ '.mkd': 'markdown',
            \ '.wiki': 'media'}

"--- Airline
let g:airline_powerline_fonts = 1

"--- Ultisnip

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"

"--- Nerdtree
" autocmd vimenter * NERDTree   " Start NERDTree when starting Vim
map <C-n> :NERDTreeToggle<CR>

"  }}}

" Custom Functions {{{
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
" Source: http://vim.wikia.com/wiki/Map_Ctrl-S_to_save_current_or_new_files
command -nargs=0 -bar Update if &modified
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif

" }}}

" Custom shortcuts {{{

" F2 for converting Markdown to PDF and opening the resulting PDF
" Remark: the script is part of https://github.com/bertvv/scripts
nnoremap <F3> :!md2pdf %; gnome-open %:r.pdf<CR>
" F3-4 for :!make
nnoremap <F3> :!make<CR>
nnoremap <F4> :!make all<CR>

" Command aliases for common typing mistakes
ca Wq wq
ca W w
ca Q q

" Section jumps also apply to { } in other columns than the first one
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

" Close buffer without closing window
" https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window/
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" }}}

"" Load helptags
packloadall           " First, all plugins must be loaded
silent! helptags ALL

" vim: fdm=marker fdl=0
