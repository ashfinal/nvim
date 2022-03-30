local map = require("utils").map
local types = require("luasnip.util.types")

require("luasnip.loaders.from_vscode").load()

map("i", "<C-j>", "<Plug>luasnip-next-choice", { noremap = false, silent = false })
map("s", "<C-j>", "<Plug>luasnip-next-choice", { noremap = false, silent = false })
map("i", "<C-k>", "<Plug>luasnip-prev-choice", { noremap = false, silent = false })
map("s", "<C-k>", "<Plug>luasnip-prev-choice", { noremap = false, silent = false })

require("luasnip").config.setup({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = {{"●", "Conditional"}}
			}
		},
		[types.insertNode] = {
			active = {
				virt_text = {{"●", "String"}}
			}
		}
	},
})
