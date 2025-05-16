return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSInstallInfo", "TSUpdate", "TSUpdateSync" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        require('ts_context_commentstring').setup({ enable_autocmd = false, })
        local get_option = vim.filetype.get_option
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.filetype.get_option = function(filetype, option)
          return option == "commentstring"
              and require("ts_context_commentstring.internal").calculate_commentstring()
              or get_option(filetype, option)
        end
      end,
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
      { "<Leader>M", "<Cmd>TSJToggle<CR>", desc = "TreeSJ toggle" },
      { "<Leader>J", "<Cmd>TSJJoin<CR>", desc = "TreeSJ join" },
      { "<Leader>S", "<Cmd>TSJSplit<CR>", desc = "TreeSJ split" },
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
  {
    "aaronik/treewalker.nvim",
    keys = {
      { "<C-k>", "<Cmd>Treewalker Up<CR>", mode = { "n", "x" }, desc = "Moves up to the previous neighbor node" },
      { "<C-j>", "<Cmd>Treewalker Down<CR>", mode = { "n", "x" }, desc = "Moves down to the next neighbor node" },
      { "<C-h>", "<Cmd>Treewalker Left<CR>", mode = { "n", "x" }, desc = "Moves to the first ancestor node that's on a different line from the current node" },
      { "<C-l>", "<Cmd>Treewalker Right<CR>", mode = { "n", "x" }, desc = "Moves to the next node down that's indented further than the current node" },
      { "<C-S-k>", "<Cmd>Treewalker SwapUp<CR>", desc = "Swaps the highest node on the line upwards" },
      { "<C-S-j>", "<Cmd>Treewalker SwapDown<CR>", desc = "Swaps the biggest node on the line downward" },
      { "<C-S-h>", "<Cmd>Treewalker SwapLeft<CR>", desc = "Swap the node under the cursor with its previous neighbor" },
      { "<C-S-l>", "<Cmd>Treewalker SwapRight<CR>", desc = "Swap the node under the cursor with its next neighbor" },
    },
    opts = {
      highlight = true,
      highlight_duration = 250,
      highlight_group = 'CursorLine',
    },
    config = function(_, opts)
      require("treewalker").setup(opts)
    end,
  },
}
