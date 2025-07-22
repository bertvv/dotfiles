return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = '-xelatex',
    }
    vim.g.vimtex_compiler_latexmk = {
      out_dir = '../output',
      options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
        '-shell-escape'
      }
    }
  end
}
