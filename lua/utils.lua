local M = {}

M.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  options = vim.tbl_extend("force", options, opts or {})
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.bmap = function(bufnr, mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  options = vim.tbl_extend("force", options, opts or {})
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

return M
