local default = {
  filetype_exclude = {
    "help",
    "terminal",
    "alpha",
    "packer",
    "lspinfo",
    "checkhealth",
    "TelescopePrompt",
    "TelescopeResults",
    "lsp-installer",
    "",
  },
  buftype_exclude = { "terminal", "nofile" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
}

require("indent_blankline").setup(default)
vim.cmd("hi! link WinSeparator IndentBlanklineContextChar")
