local util = require("lspconfig.util")

return {
  root_dir = util.root_pattern(".luarc.json", ".git"),
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {"vim"},
      },
      workspace = {
        maxPreload = 1000,
        preloadFileSize = 150,
      },
    },
  }
}
