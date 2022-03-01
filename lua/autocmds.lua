vim.cmd([[
  augroup colors_fix
    autocmd!
    autocmd ColorScheme * hi! link VertSplit StatusLine
  augroup END

  augroup dirtyfile
    autocmd!
    autocmd BufReadPost,BufWritePost * lua require("utils").checkdirty()
  augroup END
]])
