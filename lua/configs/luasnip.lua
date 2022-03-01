require("luasnip.loaders.from_vscode").load()
vim.api.nvim_set_keymap("i", "<C-]>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-]>", "<Plug>luasnip-next-choice", {})
