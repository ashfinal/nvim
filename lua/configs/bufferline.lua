local map = require("utils").map

local default = {
  options = {
    always_show_bufferline = true,
    numbers = function(opts)
      return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
    end,
    close_command = "bdelete! %d",
    right_mouse_command = function(bufnr)
      require('bufdelete').bufdelete(bufnr, true)
    end,
    left_mouse_command = "buffer %d",
    middle_mouse_command = "vertical sbuffer %d",
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    separator_style = "thin",
    enforce_regular_tabs = false,
    view = "multiwindow",
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 18,
    sort_by = "directory",
    diagnostics = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "",
        padding = 1,
        text_align = "left",
      },
      {
        filetype = "undotree",
        text = "",
        padding = 1,
      },
      {
        filetype = "DiffviewFiles",
        text = "",
        padding = 1,
      },
    },
  }
}

require("bufferline").setup(default)

map("n", "]b", "<Cmd>BufferLineCycleNext<CR>")
map("n", "[b", "<Cmd>BufferLineCyclePrev<CR>")
map("n", "<Leader>w", "<Cmd>BufferLinePick<CR>")
map("n", "<M-1>", "<Cmd>BufferLineGoToBuffer 1<CR>")
map("n", "<M-2>", "<Cmd>BufferLineGoToBuffer 2<CR>")
map("n", "<M-3>", "<Cmd>BufferLineGoToBuffer 3<CR>")
map("n", "<M-4>", "<Cmd>BufferLineGoToBuffer 4<CR>")
map("n", "<M-5>", "<Cmd>BufferLineGoToBuffer 5<CR>")
map("n", "<M-6>", "<Cmd>BufferLineGoToBuffer 6<CR>")
map("n", "<M-7>", "<Cmd>BufferLineGoToBuffer 7<CR>")
map("n", "<M-8>", "<Cmd>BufferLineGoToBuffer 8<CR>")
map("n", "<M-9>", "<Cmd>BufferLineGoToBuffer 9<CR>")
