-- treesitter.lua - parser and syntax coloring

return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "bash", "bibtex", "c", "cpp", "csv", "dockerfile",
        "git_config", "gitattributes", "gitcommit", "gitignore", "go",
        "html", "ini", "java", "jinja", "jinja_inline", "jq", "json",
        "latex", "lua", "make", "markdown", "markdown_inline", "mermaid",
        "python", "regex", "ruby", "rust", "ssh_config", "tsv", "yaml",
        "zig"
      },
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
    })
  end
}
