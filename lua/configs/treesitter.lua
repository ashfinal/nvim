local default = {
  ensure_installed = {
    "c",
    "cpp",
    "css",
    "go",
    "html",
    "javascript",
    "latex",
    "lua",
    "python",
    "rst",
    "rust",
    "scss",
    "toml",
    "typescript",
    "vim",
    "yaml",
  },
  autotag = {
    enable = true,
  },
  matchup = {
    enable = true,
    disable_virtual_text = false,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "+",
      scope_incremental = "<CR>",
      node_decremental = "-",
    },
  },
}

require'nvim-treesitter.configs'.setup(default)
