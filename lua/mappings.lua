local map = require("utils").map

map("", "<Space>", "<Nop>")
map("", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("n", "<BS>", "<Cmd>nohlsearch<CR>")
map("i", "<C-a>", "<Esc>^i")
map("i", "<C-e>", "<End>")
map("i", "<C-b>", "<Left>")
map("i", "<C-f>", "<Right>")

map("n", "<Tab>", "<Cmd>bn<CR>")
map("n", "<S-Tab>", "<Cmd>bp<CR>")
map("n", "<C-k>", "<Cmd>resize +2<CR>")
map("n", "<C-j>", "<Cmd>resize -2<CR>")
map("n", "<C-h>", "<Cmd>vertical resize +4<CR>")
map("n", "<C-l>", "<Cmd>vertical resize -4<CR>")

map("v", "p", '"_dP')
map("n", "Y", "yg$")

map("i", "jk", "<Esc>")
map("t", "jk", "<C-\\><C-n>")

vim.api.nvim_set_keymap("c", "<C-a>", "<Home>", {})
vim.api.nvim_set_keymap("c", "<C-e>", "<End>", {})
vim.api.nvim_set_keymap("c", "<C-b>", "<Left>", {})
vim.api.nvim_set_keymap("c", "<C-f>", "<Right>", {})
vim.api.nvim_set_keymap("c", "<C-f>", "<Right>", {})
vim.cmd [[nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]']]
