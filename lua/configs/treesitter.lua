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
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "+",
      node_decremental = "-",
    },
    is_supported = function()
      local ct = vim.fn.getcmdwintype()
      if ct ~= "" then return false end
      return true
    end,
  },
}

require("nvim-treesitter.configs").setup(default)
