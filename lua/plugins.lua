local present, paq = pcall(require, "bootstrap")

if not present then
  return false
end

local map = require("utils").map

local plugins = {
  { "savq/paq-nvim", opt = true },
  { "nathom/filetype.nvim" },
  { "andymass/vim-matchup" },
  {
    "kyazdani42/nvim-web-devicons",
    opt = true,
    run = function()
      require("configs.devicons")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opt = true,
    run = function()
      require("configs.bufferline")
    end,
  },
  {
    "famiu/bufdelete.nvim",
    opt = true,
    run = function()
      map("n", "<Leader>x", "<Cmd>lua require('bufdelete').bufdelete(0, true)<CR>")
    end,
  },
  {
    "RRethy/nvim-base16",
    opt = true,
    run = function()
      require("configs.base16")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opt = true,
    run = function()
      require("configs.lualine")
    end,
  },
  {
    "nvim-lua/plenary.nvim",
    opt = true,
    run = function()
      vim.cmd "packadd plenary.nvim"
    end,
  },
  {
    "ibhagwan/fzf-lua",
    opt = true,
    run = function()
      require("configs.fzflua")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opt = true,
    run = function()
      require("configs.gitsigns")
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    opt = true,
    run = function()
      vim.cmd "packadd friendly-snippets"
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    opt = true,
    run = function()
      require("configs.luasnip")
    end,
  },
  {
    "github/copilot.vim",
    opt = true,
    run = function()
      vim.g.copilot_no_tab_map = true
      map("i", "<C-l>", "copilot#Accept()", { expr = true, script = true })
      map("i", "<C-h", "<Plug>(copilot-dismiss)", { noremap = false, silent = false })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opt = true,
    run = function()
      require("configs.nvim-cmp")
    end,
  },
  {
    "hrsh7th/cmp-buffer",
    opt = true,
    run = function()
      require("configs.cmp-buffer")
    end,
  },
  {
    "hrsh7th/cmp-path",
    opt = true,
    run = function()
      require("configs.cmp-path")
    end,
  },
  {
    "hrsh7th/cmp-cmdline",
    opt = true,
    run = function()
      require("configs.cmp-cmdline")
    end,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    opt = true,
    run = function()
      require("configs.cmp_luasnip")
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    opt = true,
    run = function()
      require("cmp_nvim_lsp").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opt = true,
    run = function()
      require("configs.lspconfig")
    end,
  },
  {
    "rmagatti/goto-preview",
    opt = true,
    run = function()
      require("configs.gotopreview")
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    opt = true,
    run = function()
      vim.cmd "packadd lsp_signature.nvim"
    end,
  },
  {
    "j-hui/fidget.nvim",
    opt = true,
    run = function()
      require("fidget").setup{}
    end,
  },
  {
    "b0o/schemastore.nvim",
    opt = true,
    run = function()
      vim.cmd "packadd schemastore.nvim"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opt = true,
    run = function()
      require("configs.treesitter")
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    opt = true,
    run = function()
      vim.cmd "packadd nvim-ts-autotag"
    end,
  },
  {
    "SmiteshP/nvim-gps",
    opt = true,
    run = function()
      require("configs.nvim-gps")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opt = true,
    run = function()
      require("configs.blankline")
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    opt = true,
    run = function()
      require("configs.colorizer")
      vim.cmd "ColorizerReloadAllBuffers"
    end,
  },
  {
    "windwp/nvim-autopairs",
    opt = true,
    run = function()
      require("configs.autopairs")
    end,
  },
  {
    "numToStr/Comment.nvim",
    opt = true,
    run = function()
      require('Comment').setup()
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    opt = true,
    run = function()
      require("configs.nvimtree")
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    opt = true,
    run = function()
      require("configs.nvim-bqf")
    end,
  },
  {
    "chentau/marks.nvim",
    opt = true,
    run = function()
      require("configs.marks")
    end,
  },
  {
    "tversteeg/registers.nvim",
    opt = true,
    run = function()
      require("configs.registers")
    end,
  },
  {
    "folke/twilight.nvim",
    opt = true,
    run = function()
      require("configs.twilight")
    end,
  },
  {
    "folke/zen-mode.nvim",
    opt = true,
    run = function()
      require("configs.zenmode")
    end,
  },
  {
    "numToStr/FTerm.nvim",
    opt = true,
    run = function()
      require("configs.fterm")
    end,
  },
  {
    "machakann/vim-sandwich",
    opt = true,
    run = function()
      vim.cmd "packadd vim-sandwich"
    end,
  },
  {
    "mbbill/undotree",
    opt = true,
    run = function()
      vim.g.undotree_SetFocusWhenToggle = true
      map("n", "<Leader>u", "<Cmd>UndotreeToggle<CR>")
    end,
  },
  {
    "junegunn/vim-easy-align",
    opt = true,
    run = function()
      map("x", "gz", "<Plug>(EasyAlign)", { noremap = false, silent = false })
      map("n", "gz", "<Plug>(EasyAlign)", { noremap = false, silent = false })
    end,
  },
  {
    "t9md/vim-textmanip",
    opt = true,
    run = function()
      map("x", "<C-j>", "<Plug>(textmanip-move-down)", { noremap = false, silent = false })
      map("x", "<C-k>", "<Plug>(textmanip-move-up)", { noremap = false, silent = false })
      map("x", "<C-h>", "<Plug>(textmanip-move-left)", { noremap = false, silent = false })
      map("x", "<C-l>", "<Plug>(textmanip-move-right)", { noremap = false, silent = false })
    end,
  },
  {
    "lambdalisue/suda.vim",
    opt = true,
    run = function()
      vim.cmd "packadd suda.vim"
    end,
  },
}

paq(plugins)

if vim.g.paq_bootstrap then paq:sync() end
