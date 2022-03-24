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
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    show_buffer_icons = true, -- disable filetype icons for buffers
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
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
    --   -- remove extension from markdown files for example
    --   if buf.name:match('%.md') then
    --     return vim.fn.fnamemodify(buf.name, ':t:r')
    --   end
    -- end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    sort_by = "directory",
    diagnostics = false,
    -- diagnostics_update_in_insert = false,
    -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
    --   return "("..count..")"
    -- end,

    offsets = {
      {
        filetype = "NvimTree",
        text = function()
          return vim.fn.getcwd()
        end,
        padding = 1,
        text_align = "left",
      },
    },

    -- NOTE: this will be called a lot so don't do any heavy processing here
    -- custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      -- if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
      --   return true
      -- end
      -- filter out by buffer name
      -- if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
      --   return true
      -- end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      -- if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
      --   return true
      -- end
      -- filter out by it's index number in list (don't show first buffer)
      -- if buf_numbers[1] ~= buf_number then
      --   return true
      -- end
    -- end,
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
