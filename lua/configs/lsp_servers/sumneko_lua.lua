local util = require("lspconfig.util")

return {
  root_dir = util.root_pattern(".luarc.json", ".git"),
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = {"vim"},
      },
      workspace = {
        maxPreload = 1000,
        preloadFileSize = 150,
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  }
}
