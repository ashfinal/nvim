local present = pcall(require, "cmp")

if not present then
  vim.notify("Please rerun cmp-cmdline hook or just restart nvim.", vim.log.levels.WARN)
  package.loaded['configs.cmp-cmdline'] = nil
  return
end

if package.loaded['cmp_cmdline'] == nil then
  require('cmp').register_source('cmdline', require('cmp_cmdline').new())
end
