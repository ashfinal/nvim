local map = require("utils").map

local default = {
  border = 'double',
  hl = 'Normal',
  blend = 0,
  dimensions  = {
    height = 0.9,
    width = 0.9,
  },
}

require("FTerm").setup(default)

map('n', '<A-i>', '<Cmd>lua require("FTerm").toggle()<CR>')
map('t', '<A-i>', '<C-\\><C-n><Cmd>lua require("FTerm").toggle()<CR>')
