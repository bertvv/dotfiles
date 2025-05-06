-- init.lua - main nvim configuration file

-- disable netrw file explorer (we're using nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- load options and plugins
require('config/options')
require('config/keybinds')
require('config/lazy')
require('config/cycle-colors')
