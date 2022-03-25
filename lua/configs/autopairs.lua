local default = {
  disable_filetype = { "TelescopePrompt" },
  disable_in_macro = true,
  disable_in_visualblock = true,
  enable_check_bracket_line = false,
  check_ts = true,
  map_cr = false,
  map_bs = false,
}

require('nvim-autopairs').setup(default)
