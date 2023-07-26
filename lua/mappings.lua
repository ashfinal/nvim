vim.keymap.set("", "j", "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", { expr = true })
vim.keymap.set("", "k", "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", { expr = true })
vim.keymap.set("n", "<BS>", "<Cmd>nohlsearch<CR>")
vim.keymap.set({"i", "c"}, "<C-a>", "<Home>")
vim.keymap.set({"i", "c"}, "<C-e>", "<End>")
vim.keymap.set({"i", "c"}, "<C-b>", "<Left>")
vim.keymap.set({"i", "c"}, "<C-f>", "<Right>")

vim.keymap.set("n", "<C-k>", "<Cmd>resize +2<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>resize -2<CR>")
vim.keymap.set("n", "<C-l>", "<Cmd>vertical resize +4<CR>")
vim.keymap.set("n", "<C-h>", "<Cmd>vertical resize -4<CR>")

vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("n", "Y", "yg$")

vim.keymap.set("n", "]b", "<Cmd>bn<CR>")
vim.keymap.set("n", "[b", "<Cmd>bp<CR>")

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

vim.cmd [[nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]']]
