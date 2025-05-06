return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      log_level = "info",
      enabled = true,
      auto_restore_last_session = true,
      auto_session_enabled = true,
      auto_save = true,
      auto_restore = true,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/tmp" },
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
