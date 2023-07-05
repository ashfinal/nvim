local default = {
  disable_netrw = true,
  hijack_netrw = true,
  auto_reload_on_write = true,
  hijack_cursor = true,
  update_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  filters = {
    dotfiles = false,
    custom = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    side = "left",
    width = 30,
    hide_root_folder = false,
    signcolumn = "yes"
  },
  renderer = {
    highlight_opened_files = "all",
    icons = {
      git_placement = "after",
      show = {
        file = true,
      },
    },
  },
  actions = {
    file_popup = {
      open_win_config = {
        border = "single",
      },
    },
  },
}

require("nvim-tree").setup(default)

vim.keymap.set("n", "<Leader>e", function() return require('nvim-tree.api').tree.toggle() end, { desc = "Toggle file explorer" })
