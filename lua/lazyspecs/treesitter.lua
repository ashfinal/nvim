return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSInstallInfo", "TSUpdate", "TSUpdateSync" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      ensure_installed = {
        "c",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
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
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "gM", "<Cmd>TSJToggle<CR>", desc = "TreeSJ toggle" },
      { "gJ", "<Cmd>TSJJoin<CR>", desc = "TreeSJ join" },
      { "gS", "<Cmd>TSJSplit<CR>", desc = "TreeSJ split" },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local rainbow = require("rainbow-delimiters")
      return {
        strategy = {
          [""] = function(bufnr)
            local line_count = vim.api.nvim_buf_line_count(bufnr)
            if line_count > 10000 then
              return nil
            elseif line_count > 1000 then
              return rainbow.strategy["global"]
            end
            return rainbow.strategy["local"]
          end,
        }
      }
    end,
    config = function(_, opts)
      require("rainbow-delimiters.setup").setup(opts)
    end,
  },
}
