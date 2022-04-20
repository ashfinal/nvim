local default = {
  padding = true,
  sticky = true,
  ignore = nil,
  toggler = {
    line = 'gcc',
    block = 'gbc',
  },
  opleader = {
    line = 'gc',
    block = 'gb',
  },
  extra = {
    above = 'gcO',
    below = 'gco',
    eol = 'gcA',
  },
  mappings = {
    basic = true,
    extra = true,
    extended = false,
  },
  pre_hook = nil,
  post_hook = nil,
}

local K = vim.keymap.set

K(
  'n',
  '<Plug>(comment_toggle_linewise_count)',
  '<CMD>lua require("Comment.api").call("toggle_linewise_count_op")<CR>g@$'
)
K(
  'n',
  '<Plug>(comment_toggle_blockwise_count)',
  '<CMD>lua require("Comment.api").call("toggle_blockwise_count_op")<CR>g@$'
)
K(
  'n',
  '<Plug>(comment_toggle_current_linewise)',
  '<CMD>lua require("Comment.api").call("toggle_current_linewise_op")<CR>g@$'
)
K(
  'n',
  '<Plug>(comment_toggle_current_blockwise)',
  '<CMD>lua require("Comment.api").call("toggle_current_blockwise_op")<CR>g@$'
)
K('n', '<Plug>(comment_toggle_linewise)', '<CMD>lua require("Comment.api").call("toggle_linewise_op")<CR>g@')
K('n', '<Plug>(comment_toggle_blockwise)', '<CMD>lua require("Comment.api").call("toggle_blockwise_op")<CR>g@')
K(
  'x',
  '<Plug>(comment_toggle_linewise_visual)',
  '<ESC><CMD>lua require("Comment.api").locked.toggle_linewise_op(vim.fn.visualmode())<CR>'
)
K(
  'x',
  '<Plug>(comment_toggle_blockwise_visual)',
  '<ESC><CMD>lua require("Comment.api").locked.toggle_blockwise_op(vim.fn.visualmode())<CR>'
)

require("Comment").setup(default)
