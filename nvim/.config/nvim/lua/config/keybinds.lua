-- keybinds.lua

-- set space bar as the leader key

vim.g.mapleader = " "

-- <leader>cd - open file mgr with <leader>cd

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

-- <leader><leader> - source the current file

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
    print("current file sourced")
end)
