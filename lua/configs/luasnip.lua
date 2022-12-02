local types = require("luasnip.util.types")

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

vim.keymap.set("i", "<Tab>", "v:lua.luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { expr = true })
vim.keymap.set("i", "<S-Tab>", "v:lua.luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'", { expr = true })
vim.keymap.set({"i", "s"}, "<C-j>", "v:lua.luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-j>'", { expr = true })
vim.keymap.set({"i", "s"}, "<C-k>", "v:lua.luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-k>'", { expr = true })
