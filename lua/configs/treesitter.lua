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
  },
}

require("nvim-treesitter.configs").setup(default)

vim.api.nvim_create_augroup("cmdwin_treesitter", { clear = true })
vim.api.nvim_create_autocmd("CmdwinEnter", {
  pattern = "*",
  command = "TSBufDisable incremental_selection",
  group = "cmdwin_treesitter",
  desc = "Disable treesitter's incremental selection in Command-line window",
})
