return {
  {
    "famiu/bufdelete.nvim",
    keys = {
      { "<LocalLeader>d", function() require("bufdelete").bufdelete() end, desc = "Delete buffer without losing window layout" },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "VeryLazy" },
    opts = {
      indent = { char = "│" },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
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
        buftypes = { "terminal", "prompt", "quickfix", "nofile" },
      },
    },
    config = function(_, opts)
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)
    end,
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
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
  },
}
