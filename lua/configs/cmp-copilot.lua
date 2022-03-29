if vim.g.paq_bootstrap then
  local present1 = pcall(require, "cmp")
  local present2 = vim.fn.exists(":Copilot") == 2

  if not present1 or not present2 then
    vim.notify("Please rerun cmp-copilot hook or just restart nvim.", vim.log.levels.WARN)
    package.loaded['configs.cmp-copilot'] = nil
    return
  end
end

if package.loaded['cmp_copilot'] == nil then
  require('cmp').register_source('copilot', require('cmp_copilot').new())
end
