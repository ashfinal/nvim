local default = {
  ignore = {},
  sign = {
    enabled = true,
    priority = 10,
  },
  float = {
    enabled = false,
    text = "💡",
    win_opts = {},
  },
  virtual_text = {
    enabled = false,
    text = "💡",
    hl_mode = "replace",
  },
  status_text = {
    enabled = false,
    text = "💡",
    text_unavailable = ""
  },
}

require("nvim-lightbulb").setup(default)
vim.cmd([[
  augroup lightbulb
    autocmd!
    autocmd CursorHold * lua require'nvim-lightbulb'.update_lightbulb()
  augroup END
]])
