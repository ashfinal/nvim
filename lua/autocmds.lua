vim.cmd([[
  augroup dirtyfile
    autocmd!
    autocmd BufReadPost,BufWritePost * lua require("utils").checkdirty()
  augroup END
]])

local function try_stopping_lspserver()
  local cbuf = tonumber(vim.fn.expand("<abuf>"))
  vim.lsp.for_each_buffer_client(cbuf, function(_, client_id, bufnr)
    local bufs = vim.lsp.get_buffers_by_client_id(client_id)
    vim.lsp.buf_detach_client(bufnr, client_id)
    if vim.tbl_count(bufs) == 1 and bufs[1] == bufnr then
      vim.lsp.stop_client(client_id)
    end
  end)
end

vim.api.nvim_create_augroup("autostop_lspserver", { clear = true })
vim.api.nvim_create_autocmd({"BufWipeout", "BufDelete"}, {
  pattern = "*",
  callback = try_stopping_lspserver,
  group = "autostop_lspserver",
  desc = "Detach LSP client when buffer is deleted and stop server if no buffers are attached",
})
