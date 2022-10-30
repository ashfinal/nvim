local default = {
  filetypes = {
    "vim",
    "html",
    "css",
    "sass",
    "javascript",
    "typescript",
  },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = true, -- "Name" codes like Blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    tailwind = true,  -- Enable tailwind colors
    sass = { enable = true, parsers = { css }, }, -- Enable sass colors
    mode = "virtualtext", -- Set the display mode.
  }
}

require("colorizer").setup(default)
