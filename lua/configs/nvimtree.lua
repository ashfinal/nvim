local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.del("n", "<BS>", { buffer = bufnr })
  vim.keymap.del("n", "g?", { buffer = bufnr })
  vim.keymap.set("n", "w", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

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
  on_attach = on_attach,
}

require("nvim-tree").setup(default)

vim.keymap.set("n", "<Leader>e", function() return require("nvim-tree.api").tree.toggle() end, { desc = "Toggle file explorer" })
