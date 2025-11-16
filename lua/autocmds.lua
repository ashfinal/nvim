vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function() vim.hl.on_yank({ on_visual = false }) end,
  group = vim.api.nvim_create_augroup("highlight_yanked_text", {}),
  desc = "Briefly highlight yanked text",
})

-- disable hover highlights
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "LspReferenceTarget", {})
  end,
})
