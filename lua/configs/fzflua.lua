local map = require("utils").map

local default = {
  winopts = {
    preview = {
      scrollbar = "float",
    },
  },
}

require("fzf-lua").setup(default)

map("n", "<Leader>bb", [[<Cmd>lua require('fzf-lua').buffers()<CR>]])
map("n", "<Leader>ff", [[<Cmd>lua require('fzf-lua').files()<CR>]])
map("n", "<Leader>fo", [[<Cmd>lua require('fzf-lua').oldfiles()<CR>]])
map("n", "<Leader>fw", [[<Cmd>lua require('fzf-lua').live_grep_native()<CR>]])
map("n", "<Leader>fm", [[<Cmd>lua require('fzf-lua').git_commits()<CR>]])
map("n", "<Leader>?", [[<Cmd>lua require('fzf-lua').keymaps()<CR>]])
