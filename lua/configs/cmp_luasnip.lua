if vim.g.paq_bootstrap then
  local present1 = pcall(require, "cmp")
  local present2 = pcall(require, "luasnip")

  if not present1 or not present2 then
    vim.notify("Please rerun cmp_luasnip hook or just restart nvim.", vim.log.levels.WARN)
    package.loaded['configs.cmp_luasnip'] = nil
    return
  end
end

if package.loaded['cmp_luasnip'] == nil then
  require('cmp').register_source('luasnip', require('cmp_luasnip').new())
end
