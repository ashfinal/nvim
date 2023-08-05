return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("utils").has("nvim-cmp")
        end,
      },
    },
    init = function()
      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
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

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
      )
    end,
    opts = {
      capabilities = {},
      servers = {
        jsonls = {},
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    config = function(_, opts)
      require("lspconfig.ui.windows").default_options.border = "rounded"

      if require("utils").has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      require("utils").on_attach(function(_, buffer)
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map("n", "gs", vim.diagnostic.setqflist, "Show diagnostics")
        map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "gl", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
        map("n", "gwr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
        map("n", "gwl", function() return print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List workspace folders")
        map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
        map("n", "gm", vim.lsp.buf.rename, "Rename")
        map("n", "ga", vim.lsp.buf.code_action, "Code action")
        map("n", "gr", vim.lsp.buf.references, "References")
      end)

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available thourgh mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mlsp_servers = {}
      if have_mason then
        all_mlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mlsp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
      ensure_installed = {
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")

      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      require("utils").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = {
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
  },
  {
    "ray-x/lsp_signature.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
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
    },
    config = function(_, opts)
      require("utils").on_attach(function()
        require("lsp_signature").on_attach(opts)
      end)
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
}
