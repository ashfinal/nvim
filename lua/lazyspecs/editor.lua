return {
  {
    "famiu/bufdelete.nvim",
    keys = {
      { "<LocalLeader>d", function() require("bufdelete").bufdelete() end, desc = "Delete buffer without losing window layout" },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetype_exclude = {
        "help",
        "terminal",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        "lspinfo",
        "checkhealth",
        "TelescopePrompt",
        "TelescopeResults",
        "lsp-installer",
        "",
      },
      buftype_exclude = { "terminal", "prompt", "nofile" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetypes = {
        "asiicdoc",
        "css",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "plaintex",
        "python",
        "rst",
        "scss",
        "tex",
        "toml",
        "typescript",
        "vim",
        "xhtml",
        "xml",
        "yaml",
        "!diff",
      },
      buftypes = {
        "*",
        "!terminal",
        "!prompt",
        "!quickfix",
        "!popup",
        nofile = { mode = "background" },
      },
      user_default_options = {
        names = false,
        rgb_fn = true,
        hsl_fn = true,
        tailwind = true,
        sass = { enable = true, parsers = { "css" }, },
        mode = "virtualtext",
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_in_visualblock = true,
      map_cr = false,
      map_bs = false,
    },
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", nil, mode = { "n", "x" } },
      { "gb", nil, mode = { "n", "x" } },
    },
    opts = {
      ignore = "^$",
    },
    config = function(_, opts)
      if package.loaded.ts_context_commentstring then
        opts = vim.tbl_extend("force", opts, {
          pre_hook = require(
            "ts_context_commentstring.integrations.comment_nvim"
          ).create_pre_hook()
        })
      end
      require("Comment").setup(opts)
    end,
  },
  {
    "ashfinal/qfview.nvim",
    dev = true,
    event = "UIEnter",
    config = true,
  },
  {
    "chentoast/marks.nvim",
    event = "UIEnter",
    opts = {
      bookmark_0 = { sign = "⚑", virt_text = "Visit later" },
    },
  },
  {
    "kylechui/nvim-surround",
    event = "UIEnter",
    config = true,
  },
  {
    "mbbill/undotree",
    event = "UIEnter",
    init = function()
      vim.g.undotree_SetFocusWhenToggle = true
      vim.keymap.set("n", "<Leader>u", "<Cmd>UndotreeToggle<CR>", { desc = "Toggle undotree" })
    end,
  },
  {
    "junegunn/vim-easy-align",
    event = "UIEnter",
    init = function()
      vim.keymap.set({ "n", "x" }, "gz", "<Plug>(EasyAlign)", { desc = "EasyAlign" })
    end,
  },
  {
    "t9md/vim-textmanip",
    event = "UIEnter",
    init = function()
      vim.keymap.set("x", "<C-j>", "<Plug>(textmanip-move-down)")
      vim.keymap.set("x", "<C-k>", "<Plug>(textmanip-move-up)")
      vim.keymap.set("x", "<C-h>", "<Plug>(textmanip-move-left)")
      vim.keymap.set("x", "<C-l>", "<Plug>(textmanip-move-right)")
    end,
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
  },
}
