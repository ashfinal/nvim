local luasnip = require("luasnip")
local types = require("luasnip.util.types")

luasnip.config.setup({
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

vim.keymap.set({"i", "s"}, "<Tab>", function()
  if luasnip.expand_or_jumpable() then
    return luasnip.expand_or_jump()
  else
    return "<Tab>"
  end
end, { silent = true, expr = true })

vim.keymap.set({"i", "s"}, "<S-Tab>", function()
  if luasnip.jumpable(-1) then
    return luasnip.jump(-1)
  else
    return "<S-Tab>"
  end
end, { silent = true, expr = true })

vim.keymap.set({"i", "s"}, "<C-j>", function()
  if luasnip.choice_active() then
    return luasnip.next_choice()
  else
    return "<C-j>"
  end
end, { silent = true, expr = true })

vim.keymap.set({"i", "s"}, "<C-k>", function()
  if luasnip.choice_active() then
    return luasnip.prev_choice()
  else
    return "<C-k>"
  end
end, { silent = true, expr = true })
