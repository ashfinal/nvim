local opt = vim.opt
local g = vim.g

opt.title = true
opt.titlestring = '%(%m%)%(%{expand(\"%:~\")}%)'
opt.mouse = "a"
opt.cmdheight = 1
opt.pumheight = 10
opt.number = true
opt.relativenumber = true
opt.virtualedit = "block"
opt.showcmd = false
opt.showmode = false
opt.ruler = false
opt.autochdir = true
opt.signcolumn = "yes"
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true
opt.foldmethod = "indent"
opt.foldlevelstart = 99
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = -1
opt.ignorecase = true
opt.smartcase = true
opt.writebackup = false
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.splitright = true
opt.splitbelow = true
opt.fileencodings = { "ucs-bom", "utf-8", "default", "cp936", "big5", "latin1" }
opt.termguicolors = true
opt.cedit = ""
opt.synmaxcol = 300
opt.jumpoptions = "stack"
opt.shada = [['100,<50,s10,/500,@200,:500,h]]
opt.fillchars = { eob = " ", fold = " " }
opt.listchars = { tab = "<->", eol = "¬", trail = "⋅", extends = "»", precedes = "«" }

opt.clipboard:append("unnamedplus")
opt.shortmess:append("mrwIc")
opt.nrformats:append("unsigned")
opt.formatoptions:append("mBn")
opt.diffopt:append("vertical,indent-heuristic,algorithm:histogram")

g.mapleader = " "
g.maplocalleader = " "

g.html_dynamic_folds = 1
g.html_prevent_copy = "fntd"

local disabled_built_ins = {
  -- "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
