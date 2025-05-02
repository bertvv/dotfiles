-- options.lua - nvim options

local set = vim.opt

-- lines and columns

set.colorcolumn = "80,120"
set.cursorline = true
set.number = true
set.relativenumber = true

-- scrolling behaviour
--   minimal number of screen lines/columns to show around cursor

set.scrolloff = 3
set.sidescrolloff = 3
set.sidescroll = 5

-- indentation and wrap

set.autoindent = true
set.expandtab = true
set.linebreak = true
set.shiftround = true
set.shiftwidth = 2
set.showbreak = "↪"
set.softtabstop = 2
set.tabstop = 2

-- saving, backup and undo files

set.autoread = true
set.autowrite = true
set.backup = false
set.hidden = true
set.swapfile = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true
set.updatetime = 50

-- search settings

set.incsearch = true
set.ignorecase = true
set.smartcase = true

-- backspace behaviour

set.backspace = "indent,eol,start"

-- use desktop clipboard

set.clipboard:append("unnamedplus")
