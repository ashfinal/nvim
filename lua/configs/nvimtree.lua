local map = require("utils").map

vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_create_in_closed_folder = 1
vim.g.nvim_tree_icons = {
  default = '',
}

local default = {
  disable_netrw = true,
  hijack_netrw = true,
  ignore_ft_on_setup = { "dashboard" },
  auto_reload_on_write = true,
  hijack_cursor = true,
  update_cwd = true,
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
    allow_resize = true,
    side = "left",
    width = 30,
    hide_root_folder = false,
    signcolumn = "yes"
  },
}

require'nvim-tree'.setup(default)

map("n", "<Leader>e", "<Cmd>lua require('nvim-tree').toggle()<CR>")
