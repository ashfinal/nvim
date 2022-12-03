local signature = {
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

local on_attach = function(client, bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "ge", function() return vim.diagnostic.open_float() end, { silent = true, buffer = bufnr, desc = "Show diagnostics" })
  vim.keymap.set("n", "gE", function() return vim.diagnostic.open_float({ scope = "buffer" }) end, { silent = true, buffer = bufnr, desc = "Show buffer diagnostics" })
  vim.keymap.set("n", "[d", function() return vim.diagnostic.goto_prev() end, { silent = true, buffer = bufnr, desc = "Go to previous diagnostic" })
  vim.keymap.set("n", "]d", function() return vim.diagnostic.goto_next() end, { silent = true, buffer = bufnr, desc = "Go to next diagnostic" })
  vim.keymap.set("n", "gL", function() return vim.diagnostic.setloclist() end, { silent = true, buffer = bufnr, desc = "Set location list" })
  vim.keymap.set("n", "gD", function() return vim.lsp.buf.declaration() end, { silent = true, buffer = bufnr, desc = "Go to declaration" })
  vim.keymap.set("n", "gd", function() return vim.lsp.buf.definition() end, { silent = true, buffer = bufnr, desc = "Go to definition" })
  vim.keymap.set("n", "gh", function() return vim.lsp.buf.hover() end, { silent = true, buffer = bufnr, desc = "Hover" })
  vim.keymap.set("n", "gl", function() return vim.lsp.buf.implementation() end, { silent = true, buffer = bufnr, desc = "Go to implementation" })
  vim.keymap.set("n", "gH", function() return vim.lsp.buf.signature_help() end, { silent = true, buffer = bufnr, desc = "Signature help" })
  vim.keymap.set("n", "gs", function() return vim.lsp.buf.document_symbol() end, { silent = true, buffer = bufnr, desc = "Document symbol" })
  vim.keymap.set("n", "gS", function() return vim.lsp.buf.workspace_symbol() end, { silent = true, buffer = bufnr, desc = "Workspace symbol" })
  vim.keymap.set("n", "gwa", function() return vim.lsp.buf.add_workspace_folder() end, { silent = true, buffer = bufnr, desc = "Add workspace folder" })
  vim.keymap.set("n", "gwr", function() return vim.lsp.buf.remove_workspace_folder() end, { silent = true, buffer = bufnr, desc = "Remove workspace folder" })
  vim.keymap.set("n", "gwl", function() return print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { silent = true, buffer = bufnr, desc = "List workspace folders" })
  vim.keymap.set("n", "gy", function() return vim.lsp.buf.type_definition() end, { silent = true, buffer = bufnr, desc = "Go to type definition" })
  vim.keymap.set("n", "gm", function() return vim.lsp.buf.rename() end, { silent = true, buffer = bufnr, desc = "Rename" })
  vim.keymap.set("n", "ga", function() return vim.lsp.buf.code_action() end, { silent = true, buffer = bufnr, desc = "Code action" })
  vim.keymap.set("n", "gr", function() return vim.lsp.buf.references() end, { silent = true, buffer = bufnr, desc = "References" })

  if client.server_capabilities.document_range_formatting then
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  elseif client.server_capabilities.document_formatting then
    vim.keymap.set("n", "Q", function() return vim.lsp.buf.formatting() end, { silent = true, buffer = bufnr, desc = "Format buffer" })
  end

  require("lsp_signature").on_attach(signature)

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
  float = {
    border = "rounded",
  },
})

require("lspconfig.ui.windows").default_options.border = "rounded"

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded"
  })

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded"
  })

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local cmp_lsp = require("cmp_nvim_lsp").default_capabilities()
local extend_cap = vim.tbl_deep_extend("keep", capabilities, cmp_lsp)

local default = {
  on_attach = on_attach,
  capabilities = extend_cap,
}

local path = vim.fn.stdpath("config") .. "/lua/configs/lsp_servers/"
local files = vim.fn.readdir(path, function(name)
  if string.match(name, ".+%.lua$") then
    return true
  end
  return false
end)
local servers = vim.tbl_map(function(file) return string.sub(file, 1, -5) end, files)

-- Call setup() on each server
for _, lsp in pairs(servers) do
  local conf = require(string.format("configs.lsp_servers.%s", lsp))
  conf = vim.tbl_deep_extend("force", default, conf)
  require('lspconfig')[lsp].setup(conf)
end
