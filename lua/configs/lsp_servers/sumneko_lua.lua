local util = require("lspconfig.util")

local nvim_rtp = vim.split(package.path, ';')
table.insert(nvim_rtp, 'lua/?.lua')
table.insert(nvim_rtp, 'lua/?/init.lua')

return {
  root_dir = util.root_pattern(".luarc.json", ".git"),
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = nvim_rtp,
      },
      diagnostics = {
        globals = {"vim"},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        maxPreload = 1000,
        preloadFileSize = 150,
      },
    },
  }
}
