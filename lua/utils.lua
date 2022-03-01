local M = {}

M.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts or {})
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.bmap = function(bufnr, mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts or {})
  end
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

M.checkdirty = function()
  local trailing_pat = [[\s\+$]]
  local space_pat = [[^\s\+]]
  local tab_pat = [[^\t\+]]
  local mixed_pat = [[^\(\t\+\s\|\s\+\t\)]]
  local trailing_spaces = vim.fn.search(trailing_pat, "nwc")
  local space = vim.fn.search(space_pat, "nwc")
  local tab = vim.fn.search(tab_pat, "nwc")
  local mixed = vim.fn.search(mixed_pat, "nwc")
  local result = trailing_spaces > 0 or (space > 0 and tab > 0) or mixed > 0
  if result then vim.wo.list = true else vim.wo.list = false end
end

return M
