local bmap = require("utils").bmap

local signature = {
  bind = true,
  doc_lines = 0,
  hint_enable = false, -- virtual hint enable
  hint_prefix = "༓ ",  -- Panda for parameter
  hint_scheme = "Comment",
  floating_window = true,
  hi_parameter = "PmenuSel",
  handler_opts = {
    border = "rounded",
  }
}

local on_attach = function(client, bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  bmap(bufnr, 'n', 'ge', '<Cmd>lua vim.diagnostic.open_float()<CR>')
  bmap(bufnr, 'n', 'gE', '<Cmd>lua vim.diagnostic.open_float({scope = "buffer"})<CR>')
  bmap(bufnr, 'n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>')
  bmap(bufnr, 'n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>')
  bmap(bufnr, 'n', 'gQ', '<Cmd>lua vim.diagnostic.setloclist()<CR>')
  bmap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
  bmap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
  bmap(bufnr, 'n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  bmap(bufnr, 'n', 'gl', '<Cmd>lua vim.lsp.buf.implementation()<CR>')
  bmap(bufnr, 'n', 'gH', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
  bmap(bufnr, 'n', 'gs', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>')
  bmap(bufnr, 'n', 'gS', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  bmap(bufnr, 'n', 'gc', '<Cmd>lua vim.lsp.buf.incoming_calls()<CR>')
  bmap(bufnr, 'n', 'go', '<Cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
  bmap(bufnr, 'n', 'gwa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  bmap(bufnr, 'n', 'gwr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  bmap(bufnr, 'n', 'gwl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  bmap(bufnr, 'n', 'gy', '<Cmd>lua vim.lsp.buf.type_definition()<CR>')
  bmap(bufnr, 'n', 'gm', '<Cmd>lua vim.lsp.buf.rename()<CR>')
  bmap(bufnr, 'n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
  bmap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>')
  bmap(bufnr, 'n', 'gq', '<Cmd>lua vim.lsp.buf.formatting()<CR>')

  require("lsp_signature").on_attach(signature)
  bmap(bufnr, 'n', 'gd', '<Cmd>lua require("goto-preview").goto_preview_definition()<CR>')
  bmap(bufnr, 'n', 'gl', '<Cmd>lua require("goto-preview").goto_preview_implementation()<CR>')
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
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local default = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
}

local path = vim.fn.stdpath "config" .. "/lua/configs/lsp_servers/"
local files = vim.fn.readdir(path, function(name)
  if string.match(name, ".+%.lua$") then
    return true
  end
  return false
end)
local servers = vim.tbl_map(function(file) return string.sub(file, 1, -5) end, files)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for _, lsp in pairs(servers) do
  local conf = require(string.format("configs.lsp_servers.%s", lsp))
  conf = vim.tbl_deep_extend("force", default, conf)
  require('lspconfig')[lsp].setup(conf)
end
