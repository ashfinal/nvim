local default = {
  options = {
    always_show_bufferline = true,
    numbers = function(opts)
      return string.format('%s', opts.raise(opts.id))
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

vim.keymap.set("n", "]b", "<Cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "[b", "<Cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<Leader>w", "<Cmd>BufferLinePick<CR>")
vim.keymap.set("n", "<M-1>", "<Cmd>BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n", "<M-2>", "<Cmd>BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n", "<M-3>", "<Cmd>BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n", "<M-4>", "<Cmd>BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n", "<M-5>", "<Cmd>BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n", "<M-6>", "<Cmd>BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n", "<M-7>", "<Cmd>BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n", "<M-8>", "<Cmd>BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n", "<M-9>", "<Cmd>BufferLineGoToBuffer 9<CR>")
