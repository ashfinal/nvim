local default = {
  border = "double",
  hl = "Normal",
  blend = 0,
  dimensions  = {
    height = 0.9,
    width = 0.9,
  },
}

require("FTerm").setup(default)

vim.keymap.set("n", "<A-i>", "<Cmd>lua require('FTerm').toggle()<CR>")
vim.keymap.set("t", "<A-i>", "<C-\\><C-n><Cmd>lua require('FTerm').toggle()<CR>")
