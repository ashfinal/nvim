local function check_invisible_chars()
  if vim.bo.modifiable then
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
end

vim.api.nvim_create_augroup("show_invisible_chars", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  pattern = "*",
  callback = check_invisible_chars,
  group = "show_invisible_chars",
  desc = "Check for invisible characters and find inconsistency, show them if needed",
})

local function try_stopping_lspserver(args)
  vim.lsp.for_each_buffer_client(args['buf'], function(_, client_id, bufnr)
    local bufs = vim.lsp.get_buffers_by_client_id(client_id)
    vim.lsp.buf_detach_client(bufnr, client_id)
    if vim.tbl_count(bufs) == 1 and bufs[1] == bufnr then
      vim.lsp.stop_client(client_id)
    end
  end)
end

vim.api.nvim_create_augroup("autostop_lspserver", { clear = true })
vim.api.nvim_create_autocmd({ "BufWipeout", "BufDelete" }, {
  pattern = "*",
  callback = try_stopping_lspserver,
  group = "autostop_lspserver",
  desc = "Detach LSP client when buffer is deleted and stop server if no buffers are attached",
})

vim.api.nvim_create_augroup("cmdwin_treesitter", { clear = true })
vim.api.nvim_create_autocmd("CmdwinEnter", {
  pattern = "*",
  command = "TSBufDisable incremental_selection",
  group = "cmdwin_treesitter",
  desc = "Disable treesitter's incremental selection in Command-line window",
})
