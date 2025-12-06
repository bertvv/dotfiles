-- keybinds.lua

-- set space bar as the leader key

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- <leader><leader> - source the current file

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
  print("current file sourced")
end, { desc = "Source current file" })

-- move through buffers

vim.keymap.set("n", "<leader>n", ":bnext<cr>", { desc = "Open next buffer" })
vim.keymap.set("n", "<leader>p", ":bp<cr>", { desc = "Open previous buffer" })
vim.keymap.set("n", "<leader>x", ":bdelete<cr>", { desc = "Close current buffer" })

-- split buffer

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split buffer vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split buffer horizontally" })


-- yank to clipboard

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })

-- format file

vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format buffer" })

-- cycle through diagnostics

vim.keymap.set("n", "<leader>dn", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Jump to next diagnostic issue" })
vim.keymap.set("n", "<leader>dp", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Jump to previous diagnostic issue" })
vim.keymap.set("n", "<leader>dl", function()
  vim.diagnostic.setloclist()
end, { desc = "List diagnostic issues" })
