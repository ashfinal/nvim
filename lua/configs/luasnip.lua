local map = require("utils").map

require("luasnip.loaders.from_vscode").load()
map("i", "<C-j>", "<Plug>luasnip-next-choice", { noremap = false, silent = false })
map("s", "<C-j>", "<Plug>luasnip-next-choice", { noremap = false, silent = false })
map("i", "<C-k>", "<Plug>luasnip-prev-choice", { noremap = false, silent = false })
map("s", "<C-k>", "<Plug>luasnip-prev-choice", { noremap = false, silent = false })
