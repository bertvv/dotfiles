return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      auto_restore = true,
      auto_restore_last_session = true,
      auto_save = true,
      enabled = true,
      log_level = "info",
      suppressed_dirs = { "~/", "~/Downloads", "/tmp" },
      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = true,
        theme_conf = { border = "rounded" },
        previewer = false,
      },
      vim.keymap.set("n", "<leader>ls", require("auto-session.session-lens").search_session, {
        noremap = true,
      }),
    })
  end
}
