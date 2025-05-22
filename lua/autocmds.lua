local function reveal_invisible_chars()
  if vim.bo.modifiable then
    local search_pat = [[ \+$\|^ \+\_.\+\_^\t\+\|^\t\+\_.\+\_^ \+\|^\(\t\+ \| \+\t\)]]
    local match_result = vim.fn.search(search_pat, "nwc") > 0
    vim.wo.list = match_result
  end
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  pattern = "*",
  callback = reveal_invisible_chars,
  group = vim.api.nvim_create_augroup("reveal_invisible_chars", {}),
  desc = "Check for invisible characters and find inconsistency, reveal them if necessary",
})

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
