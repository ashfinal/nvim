return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      { "b0o/SchemaStore.nvim" },
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("utils").has("nvim-cmp")
        end,
      },
    },
    opts = function()
      return {
        capabilities = {},
        servers = {
          jsonls = {
            -- lazy-load schemastore when needed
            on_new_config = function(new_config)
              new_config.settings.json.schemas = new_config.settings.json.schemas or {}
              vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = { json = { validate = true } },
          },
          cssls = {},
          html = {},
          ltex = { autostart = false },
          sourcekit = {
            filetypes = { "swift" },
            root_dir = require("lspconfig.util").root_pattern("Package.swift")
          },
          clangd = {
            root_dir = require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja",
              "compile_commands.json",
              "compile_flags.txt",
              ".clangd",
              ".clang-tidy",
              ".clang-format",
              ".git"
            ),
            capabilities = {
              offsetEncoding = { "utf-16" },
            },
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=llvm",
            },
            init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,
            },
          },
          rust_analyzer = {
            settings = {
              ["rust-analyzer"] = {
                cargo = {
                  allFeatures = true,
                  loadOutDirsFromCheck = true,
                  runBuildScripts = true,
                },
                -- Add clippy lints for Rust.
                checkOnSave = {
                  allFeatures = true,
                  command = "clippy",
                  extraArgs = { "--no-deps" },
                },
                procMacro = {
                  enable = true,
                  ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                  },
                },
              },
            },
          },
          pyright = {},
          taplo = {},
          yamlls = {
            -- Have to add this for yamlls to understand that we support line folding
            capabilities = {
              textDocument = {
                foldingRange = {
                  dynamicRegistration = false,
                  lineFoldingOnly = true,
                },
              },
            },
            -- lazy-load schemastore when needed
            on_new_config = function(new_config)
              new_config.settings.yaml.schemas = vim.tbl_deep_extend(
                "force",
                new_config.settings.yaml.schemas or {},
                require("schemastore").yaml.schemas()
              )
            end,
            settings = {
              redhat = { telemetry = { enabled = false } },
              yaml = {
                keyOrdering = false,
                validate = true,
                schemaStore = {
                  -- Must disable built-in schemaStore support to use schemas from SchemaStore.nvim plugin
                  enable = false,
                  -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                  url = "",
                },
              },
            },
          },
          emmet_language_server = {},
          tailwindcss = {
            root_dir = require("lspconfig.util").root_pattern("tailwindcss.config.js", "tailwindcss.config.ts", "postcss.config.js", "postcss.config.ts"),
          },
          tsserver = {},
          svelte = {},
          lua_ls = {
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
          gopls = {
            settings = {
              gopls = {
                gofumpt = true,
                codelenses = {
                  gc_details = false,
                  generate = true,
                  regenerate_cgo = true,
                  run_govulncheck = true,
                  test = true,
                  tidy = true,
                  upgrade_dependency = true,
                  vendor = true,
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
                analyses = {
                  fieldalignment = true,
                  nilness = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                semanticTokens = true,
              },
            },
          },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
    end,
    config = function(_, opts)
      local signs = { Error = "", Warn = "", Hint = "", Info = "" }

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

      require("lspconfig.ui.windows").default_options.border = "rounded"

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
      )

      if require("utils").has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      require("utils").on_attach(function(client, buffer)
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        local function supports(method)
          method = method:find("/") and method or "textDocument/" .. method
          if client.supports_method(method) then
            return true
          end
          return false
        end
        if supports("publishDiagnostics") then
          map("n", "gs", vim.diagnostic.setqflist, "Add diagnostics to quickfix")
          map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")
        end
        if supports("declaration") then map("n", "gD", vim.lsp.buf.declaration, "Go to declaration") end
        if supports("definition") then map("n", "gd", vim.lsp.buf.definition, "Go to definition") end
        if supports("hover") then map("n", "K", vim.lsp.buf.hover, "Hover") end
        if supports("implementation") then map("n", "gl", vim.lsp.buf.implementation, "Go to implementation") end
        map("n", "gwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
        map("n", "gwr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
        map("n", "gwl", function() return print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
          "List workspace folders")
        if supports("typeDefinition") then map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition") end
        if supports("rename") then map("n", "gm", vim.lsp.buf.rename, "Rename") end
        if supports("codeAction") then map({ "n", "x" }, "ga", vim.lsp.buf.code_action, "Code action") end
        if supports("references") then map("n", "gr", vim.lsp.buf.references, "References") end
        if supports("callHierarchy/incomingCalls") then map("n", "gc", vim.lsp.buf.incoming_calls, "IncomingCalls") end
        if supports("callHierarchy/outgoingCalls") then map("n", "go", vim.lsp.buf.outgoing_calls, "OutgoingCalls") end
        if supports("rangeFormatting") then vim.api.nvim_buf_set_option(buffer, "formatexpr",
            "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})") end
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

      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
            setup(server)
        end
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
        Class = "󰠱 ",
        Method = "󰊕 ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = "󰊕 ",
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
        Struct = "󰙅 ",
        Event = " ",
        Operator = "󰆕 ",
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
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      notification = {
        window = {
          winblend = 0,
        }
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        css = { { "prettierd", "prettier" } },
        go = { "goimports", { "gofumpt", "gofmt" } },
        html = { { "prettierd", "prettier" } },
        javascript = { { "deno_fmt", "prettierd", "prettier" } },
        lua = { "stylua" },
        markdown = { { "deno_fmt", "prettierd", "prettier" } },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        scss = { { "prettierd", "prettier" } },
        svelte = { { "prettierd", "prettier" } },
        swift = { "swiftformat", "swift_format" },
        toml = { "taplo" },
        typescript = { { "deno_fmt", "prettierd", "prettier" } },
        yaml = { { "yamlfmt", "prettierd", "prettier" } },
      },
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
    },
    config = function(_, opts)
      local conform = require("conform")
      conform.setup(opts)
      local function setup_formatexpr_from_conform()
        if vim.bo.formatexpr == "" and not vim.tbl_isempty(conform.list_formatters(0)) then
          vim.bo.formatexpr = "v:lua.require'conform'.formatexpr()"
        end
      end
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = "*",
        callback = setup_formatexpr_from_conform,
        group = vim.api.nvim_create_augroup("setup_formatexpr_from_conform", {}),
        desc = "Setup formatexpr from conform if empty",
      })
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })
    end,
  },
}
