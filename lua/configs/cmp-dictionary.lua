if vim.g.paq_bootstrap then
  local present = pcall(require, "cmp")

  if not present then
    vim.notify("Please rerun cmp-dictionary hook or just restart nvim.", vim.log.levels.WARN)
    package.loaded['configs.cmp-dictionary'] = nil
    return
  end
end

if package.loaded['cmp_dictionary'] == nil then
  require("cmp").register_source("dictionary", require("cmp_dictionary").new())
end

require("cmp_dictionary").setup({
  dic = {
    -- ["*"] = { "/usr/share/dict/words" },
    ["markdown,rst,tex,gitcommit"] = { "/usr/share/dict/words" },
    -- filename = {
    --   ["xmake.lua"] = { "path/to/xmake.dic", "path/to/lua.dic" },
    -- },
    -- filepath = {
    --   ["%.tmux.*%.conf"] = "path/to/tmux.dic"
    -- },
  },
  exact = 2,
  first_case_insensitive = false,
  document = true,
  document_command = "wn %s -over",
  async = false,
  capacity = 5,
  debug = false,
})

require("cmp_dictionary").update()

vim.cmd([[
  augroup dict_switch
    autocmd!
    autocmd BufEnter * lua require("cmp_dictionary").update()
  augroup END
]])
