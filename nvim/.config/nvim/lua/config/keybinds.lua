-- keybinds.lua

-- set space bar as the leader key

vim.g.mapleader = " "

-- <leader><leader> - source the current file

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
    print("current file sourced")
end)

-- move through buffers

vim.keymap.set("n", "<leader>n", ":bn<cr>")
vim.keymap.set("n", "<leader>p", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bx<cr>")

-- yank to clipboard

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- format file

vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)

-- cycle through diagnostics

vim.keymap.set("n", "<leader>dn", function()
    vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "<leader>dp", function()
    vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "<leader>dl", function()
    vim.diagnostic.setloclist()
end)
vim.keymap.set("n", "<leader>df", function()
    vim.diagnostic.open_float()
end)
