local bmap = require("utils").bmap

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
  bmap(bufnr, 'n', 'ge', '<Cmd>lua vim.diagnostic.open_float()<CR>')
  bmap(bufnr, 'n', 'gE', '<Cmd>lua vim.diagnostic.open_float({scope = "buffer"})<CR>')
  bmap(bufnr, 'n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>')
  bmap(bufnr, 'n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>')
  bmap(bufnr, 'n', 'gL', '<Cmd>lua vim.diagnostic.setloclist()<CR>')
  bmap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
  bmap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
  bmap(bufnr, 'n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  bmap(bufnr, 'n', 'gl', '<Cmd>lua vim.lsp.buf.implementation()<CR>')
  bmap(bufnr, 'n', 'gH', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
  bmap(bufnr, 'n', 'gs', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>')
  bmap(bufnr, 'n', 'gS', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  bmap(bufnr, 'n', 'gwa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  bmap(bufnr, 'n', 'gwr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  bmap(bufnr, 'n', 'gwl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  bmap(bufnr, 'n', 'gy', '<Cmd>lua vim.lsp.buf.type_definition()<CR>')
  bmap(bufnr, 'n', 'gm', '<Cmd>lua vim.lsp.buf.rename()<CR>')
  bmap(bufnr, 'n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
  bmap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>')

  if client.server_capabilities.document_range_formatting then
    vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
  elseif client.server_capabilities.document_formatting then
    bmap(bufnr, 'n', 'Q', '<Cmd>lua vim.lsp.buf.formatting()<CR>')
  end

  local present0 = pcall(require, "lsp_signature")
  if present0 then
    require("lsp_signature").on_attach(signature)
  end

  local present1 = pcall(require, "goto-preview")
  if present1 then
    bmap(bufnr, 'n', 'gd', '<Cmd>lua require("goto-preview").goto_preview_definition()<CR>')
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

local lspconfig_window = require("lspconfig.ui.windows")
local old_defaults = lspconfig_window.default_opts

function lspconfig_window.default_opts(opts)
  local win_opts = old_defaults(opts)
  win_opts.border = "rounded"
  return win_opts
end

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
  local present2 = pcall(require, "cmp_nvim_lsp")
  if present2 then
    local defcap = require('cmp_nvim_lsp').default_capabilities()
    conf = vim.tbl_deep_extend("force", conf, { capabilities = defcap })
  end
  require('lspconfig')[lsp].setup(conf)
end
