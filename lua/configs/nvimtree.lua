local map = require("utils").map

local default = {
  create_in_closed_folder = true,
  disable_netrw = true,
  hijack_netrw = true,
  ignore_ft_on_setup = { "dashboard" },
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
  },
}

require'nvim-tree'.setup(default)

map("n", "<Leader>e", "<Cmd>lua require('nvim-tree').toggle()<CR>")
