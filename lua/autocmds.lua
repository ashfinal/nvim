local function reveal_invisible_chars()
  if vim.bo.modifiable then
    local trailing_pat = [[ \+$]]
    local space_pat = [[^ \+]]
    local tab_pat = [[^\t\+]]
    local mixed_pat = [[^\(\t\+ \| \+\t\)]]
    local trailing_spaces = vim.fn.search(trailing_pat, "nwc")
    local space = vim.fn.search(space_pat, "nwc")
    local tab = vim.fn.search(tab_pat, "nwc")
    local mixed = vim.fn.search(mixed_pat, "nwc")
    local result = trailing_spaces > 0 or (space > 0 and tab > 0) or mixed > 0
    vim.wo.list = result
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
