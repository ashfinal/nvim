local default = {
  bind = true,
  doc_lines = 0,
  hint_enable = false,
  hint_prefix = " ",
  hint_scheme = "Comment",
  floating_window = true,
  hi_parameter = "PmenuSel",
  handler_opts = {
    border = "rounded",
  }
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspSignatureConf", {}),
  callback = function()
    require("lsp_signature").on_attach(default)
  end,
  desc = "Setup lsp_signature on attach",
})
