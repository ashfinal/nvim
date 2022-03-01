local present = pcall(require, "cmp")

if not present then
  vim.notify("Please rerun cmp-buffer hook or just restart nvim.", vim.log.levels.WARN)
  package.loaded['configs.cmp-buffer'] = nil
  return
end

if package.loaded['cmp_buffer'] == nil then
  require('cmp').register_source('buffer', require('cmp_buffer').new())
end
