if vim.g.paq_bootstrap then
  local present = pcall(require, "cmp")

  if not present then
    vim.notify("Please rerun cmp-path hook or just restart nvim.", vim.log.levels.WARN)
    package.loaded['configs.cmp-path'] = nil
    return
  end
end

if package.loaded['cmp_path'] == nil then
  require('cmp').register_source('path', require('cmp_path').new())
end
