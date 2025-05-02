-- colors.lua - configure color theme

local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
end

return {
    {
        'rebelot/kanagawa.nvim',
        config = function()
            vim.cmd.colorscheme "kanagawa"

            enable_transparency()
        end
    },
}

-- return {
--  {
--    "folke/tokyonight.nvim",
--    config = function()
--      vim.cmd.colorscheme "tokyonight"
--      vim.cmd('hi Directory guibg=NONE')
--      vim.cmd('hi SignColumn guibg=NONE')
--      enable_transparency()
--    end
--  },
-- }
