local user_lspconfig = function(ev)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "gs", vim.diagnostic.setqflist, { silent = true, buffer = ev.buf, desc = "Show diagnostics" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true, buffer = ev.buf, desc = "Go to previous diagnostic" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true, buffer = ev.buf, desc = "Go to next diagnostic" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = ev.buf, desc = "Go to declaration" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = ev.buf, desc = "Go to definition" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, buffer = ev.buf, desc = "Hover" })
  vim.keymap.set("n", "gl", vim.lsp.buf.implementation, { silent = true, buffer = ev.buf, desc = "Go to implementation" })
  vim.keymap.set("n", "gwa", vim.lsp.buf.add_workspace_folder, { silent = true, buffer = ev.buf, desc = "Add workspace folder" })
  vim.keymap.set("n", "gwr", vim.lsp.buf.remove_workspace_folder, { silent = true, buffer = ev.buf, desc = "Remove workspace folder" })
  vim.keymap.set("n", "gwl", function() return print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { silent = true, buffer = ev.buf, desc = "List workspace folders" })
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { silent = true, buffer = ev.buf, desc = "Go to type definition" })
  vim.keymap.set("n", "gm", vim.lsp.buf.rename, { silent = true, buffer = ev.buf, desc = "Rename" })
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { silent = true, buffer = ev.buf, desc = "Code action" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true, buffer = ev.buf, desc = "References" })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lspconfig_on_attach", {}),
  callback = user_lspconfig,
  desc = "User on_attach lspconfig(mainly buffer related mappings)",
})

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
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local default = {
  on_attach = on_attach,
  capabilities = capabilities,
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
