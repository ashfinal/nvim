local present, dep = pcall(require, "bootstrap")

if not present then
  return false
end

local plugins = {
  {
    "andymass/vim-matchup",
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.g.matchup_delim_noskips = 2
    end,
  },
  {
    "kyazdani42/nvim-web-devicons",
    function()
      require("configs.devicons")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    function()
      require("configs.bufferline")
    end,
    requires = { "kyazdani42/nvim-web-devicons" }
  },
  {
    "famiu/bufdelete.nvim",
    function()
      vim.keymap.set("n", "<Leader>x", function() return require("bufdelete").bufdelete(0, true) end, { silent = true, desc = "Delete buffers without losing window layout" })
    end,
  },
  {
    "RRethy/nvim-base16",
    function()
      require("base16-colorscheme").setup("onedark")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    function()
      require("configs.lualine")
    end,
    requires = { "kyazdani42/nvim-web-devicons","SmiteshP/nvim-navic" }
  },
  {
    "ibhagwan/fzf-lua",
    function()
      require("configs.fzflua")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    function()
      require("configs.gitsigns")
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    requires = { "L3MON4D3/LuaSnip" }
  },
  {
    "L3MON4D3/LuaSnip",
    function()
      require("configs.luasnip")
    end,
  },
  {
    "github/copilot.vim",
    function()
      vim.keymap.set("i", "<C-.>", "copilot#Accept('<CR>')", { silent = true, expr = true, script = true })
    end,
    setup = function()
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    function()
      require("configs.nvim-cmp")
    end,
    deps = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lsp" },
  },
  {
    "neovim/nvim-lspconfig",
    function()
      require("configs.lspconfig")
    end,
    requires = { "ray-x/lsp_signature.nvim", "b0o/schemastore.nvim", "SmiteshP/nvim-navic" },
    deps = { "j-hui/fidget.nvim" },
  },
  {
    "j-hui/fidget.nvim",
    function()
      require("fidget").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    function()
      require("configs.treesitter")
    end,
    deps = { "windwp/nvim-ts-autotag", "windwp/nvim-autopairs", "JoosepAlviste/nvim-ts-context-commentstring" },
  },
  {
    "SmiteshP/nvim-navic",
    function()
      require("configs.nvim-navic")
    end,
    requires = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "Wansmer/treesj",
    function()
      require("configs.treesj")
    end,
    requires = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    function()
      require("configs.blankline")
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    function()
      require("configs.colorizer")
      vim.cmd("ColorizerReloadAllBuffers")
    end,
  },
  {
    "windwp/nvim-autopairs",
    function()
      require("configs.autopairs")
    end,
  },
  {
    "numToStr/Comment.nvim",
    function()
      require("configs.comment")
    end,
    requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
  },
  {
    "kyazdani42/nvim-tree.lua",
    function()
      require("configs.nvimtree")
    end,
    requires = { "kyazdani42/nvim-web-devicons" },
  },
  {
    "kevinhwang91/nvim-bqf",
    function()
      require("configs.nvim-bqf")
    end,
  },
  {
    "chentoast/marks.nvim",
    function()
      require("configs.marks")
    end,
  },
  {
    "folke/twilight.nvim",
    function()
      require("configs.twilight")
    end,
  },
  {
    "folke/zen-mode.nvim",
    function()
      require("configs.zenmode")
    end,
  },
  {
    "numToStr/FTerm.nvim",
    function()
      require("configs.fterm")
    end,
  },
  {
    "kylechui/nvim-surround",
    function()
      require("nvim-surround").setup()
    end,
  },
  {
    "mbbill/undotree",
    function()
      vim.g.undotree_SetFocusWhenToggle = true
      vim.keymap.set("n", "<Leader>u", "<Cmd>UndotreeToggle<CR>")
    end,
  },
  {
    "junegunn/vim-easy-align",
    function()
      vim.keymap.set({"x", "n"}, "gz", "<Plug>(EasyAlign)")
    end,
  },
  {
    "t9md/vim-textmanip",
    function()
      vim.keymap.set("x", "<C-j>", "<Plug>(textmanip-move-down)")
      vim.keymap.set("x", "<C-k>", "<Plug>(textmanip-move-up)")
      vim.keymap.set("x", "<C-h>", "<Plug>(textmanip-move-left)")
      vim.keymap.set("x", "<C-l>", "<Plug>(textmanip-move-right)")
    end,
  },
  {
    "lambdalisue/suda.vim",
  },
}

dep(plugins)

if vim.g.dep_bootstrap then dep:sync() end
