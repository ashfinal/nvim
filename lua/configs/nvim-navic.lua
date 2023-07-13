local default = {
  icons = {
    File = "󰈙 ",
    Module = " ",
    Namespace = "󰦮 ",
    Package = " ",
    Class = "ﴯ ",
    Method = " ",
    Property = "ﰠ ",
    Field = " ",
    Constructor = " ",
    Enum = " ",
    Interface = " ",
    Function = " ",
    Variable = "󰀫 ",
    Constant = "󰏿 ",
    String = " ",
    Number = "󰎠 ",
    Boolean = "󰨙 ",
    Array = "󱡠 ",
    Object = " ",
    Key = "󰌋 ",
    Null = "󰟢 ",
    EnumMember = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = "󰊄 ",
  },
  highlight = false,
  separator = " > ",
  depth_limit = 0,
  depth_limit_indicator = "..",
  safe_output = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_navic_conf_on_attach", {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end
  end,
  desc = "User lsp_navic conf on attach",
})

require("nvim-navic").setup(default)
