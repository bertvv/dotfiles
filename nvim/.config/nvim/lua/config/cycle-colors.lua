-- Cycle through color schemes
--
-- Source: <https://www.reddit.com/r/vim/comments/w4iv6b/comment/juqgeg8/>

local colorschemes = vim.fn.getcompletion("", "color")
local colorschemes_idx = vim.fn.index(
    colorschemes,
    vim.api.nvim_cmd({ cmd = "colorscheme" }, { output = true })
)

local function change_colorscheme(forward)
    colorschemes_idx = (colorschemes_idx + forward) % #colorschemes

    local ok = pcall(function()
        vim.cmd("colorscheme " .. colorschemes[colorschemes_idx])
    end)

    if not ok then
        change_colorscheme(forward)
    end

    print(colorschemes[colorschemes_idx])
end

vim.keymap.set("n", "<C-h>", function()
    change_colorscheme(1)
end)

vim.keymap.set("n", "<C-l>", function()
    change_colorscheme(-1)
end)
