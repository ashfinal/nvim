vim.cmd([[
  augroup dirtyfile
    autocmd!
    autocmd BufReadPost,BufWritePost * lua require("utils").checkdirty()
  augroup END
]])
