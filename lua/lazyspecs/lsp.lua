return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "b0o/SchemaStore.nvim" },
      { 'saghen/blink.cmp' },
    },
    opts = function()
      return {
        -- global capabilities
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        servers = {
          jsonls = {
            -- lazy-load schemastore when needed
            before_init = function(_, new_config)
              new_config.settings.json.schemas = new_config.settings.json.schemas or {}
              vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = {
              json = {
                format = {
                  enable = true,
                },
                validate = { enable = true },
              },
            },
          },
          cssls = {},
          html = {},
          sourcekit = {
          },
          clangd = {
            root_markers = {
              "compile_commands.json",
              "compile_flags.txt",
              "configure.ac", -- AutoTools
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja",
              ".git",
            },
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
              -- rust-analyzer language server configuration
              ["rust-analyzer"] = {
                cargo = {
                  features = "all",
                },
                check = {
                  command = "clippy",
                },
                procMacro = {
                  enable = true,
                  ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                  },
                },
                files = {
                  excludeDirs = {
                    ".direnv",
                    ".git",
                    ".github",
                    ".gitlab",
                    "bin",
                    "node_modules",
                    "target",
                    "venv",
                    ".venv",
                  },
                },
              },
            },
          },
          pyright = {},
          tombi = {},
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
            before_init = function(_, new_config)
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
                format = {
                  enable = true,
                },
                validate = true,
                schemaStore = {
                  -- Must disable built-in schemaStore support to use
                  -- schemas from SchemaStore.nvim plugin
                  enable = false,
                  -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                  url = "",
                },
              },
            },
          },
          emmet_language_server = {},
          tailwindcss = {
          },
          ts_ls = {},
          svelte = {},
          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
          gopls = {
            settings = {
              gopls = {
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
                  nilness = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              },
            },
          },
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
        virtual_lines = false,
        signs = false,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
        float = {
          border = "single",
        },
      })

      require("lspconfig.ui.windows").default_options.border = "single"

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
          if client:supports_method(method) then
            return true
          end
          return false
        end
        if supports("publishDiagnostics") then
          map("n", "gs", vim.diagnostic.setqflist, "Add diagnostics to quickfix")
          map("n", "[d", function() vim.diagnostic.jump({ count=-1, float=true }) end, "Go to previous diagnostic")
          map("n", "]d", function() vim.diagnostic.jump({ count=1, float=true }) end, "Go to next diagnostic")
        end
        if supports("declaration") then map("n", "grD", vim.lsp.buf.declaration, "Go to declaration") end
        if supports("definition") then map("n", "grd", vim.lsp.buf.definition, "Go to definition") end
        if supports("typeDefinition") then map("n", "grt", vim.lsp.buf.type_definition, "Go to type definition") end
        if supports("callHierarchy/incomingCalls") then map("n", "grI", vim.lsp.buf.incoming_calls, "IncomingCalls") end
        if supports("callHierarchy/outgoingCalls") then map("n", "grO", vim.lsp.buf.outgoing_calls, "OutgoingCalls") end
        if supports("rangeFormatting") then vim.api.nvim_set_option_value("formatexpr",
            "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})", { buf = buffer }) end
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("n", "<Leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buffer })
          end, "Toggle Inlay Hints")
        end
      end)

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require('blink.cmp').get_lsp_capabilities({}, false) or {},
        opts.capabilities or {}
      )
      vim.lsp.config("*", { capabilities = capabilities })

      local servers = opts.servers
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
            vim.lsp.config(server, server_opts)
            vim.lsp.enable(server)
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
        css = { "prettier" },
        go = { "goimports", "gofmt" },
        html = { "prettier" },
        javascript = { "deno_fmt" },
        lua = { "stylua" },
        markdown = { "deno_fmt" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        scss = { "prettier" },
        svelte = { "prettier" },
        swift = { "swift_format" },
        toml = { "taplo" },
        typescript = { "deno_fmt" },
        yaml = { "yamlfmt" },
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
  {
    "folke/trouble.nvim",
    opts = {
      icons = {
        kinds = {
          Array = "󱡠 ",
          Boolean = "󰨙 ",
          Class = "󰠱 ",
          Constant = "󰏿 ",
          Constructor = " ",
          Enum = " ",
          EnumMember = " ",
          Event = " ",
          Field = " ",
          File = "󰈙 ",
          Function = "󰊕 ",
          Interface = " ",
          Key = "󰌋 ",
          Method = "󰊕 ",
          Module = " ",
          Namespace = "󰦮 ",
          Null = "󰟢 ",
          Number = "󰎠 ",
          Object = " ",
          Operator = "󰆕 ",
          Package = " ",
          Property = " ",
          String = " ",
          Struct = "󰙅 ",
          TypeParameter = "󰊄 ",
          Variable = "󰀫 ",
        },
      },
    },
    cmd = "Trouble",
    keys = {
      {
        "<Leader>tx",
        "<Cmd>Trouble diagnostics toggle<CR>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<Leader>tX",
        "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<Leader>ts",
        "<Cmd>Trouble symbols toggle focus=false<CR>",
        desc = "Symbols (Trouble)",
      },
      {
        "<Leader>ti",
        "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>",
        desc = "LSP Definitions / references / implementations (Trouble)",
      },
      {
        "<Leader>tl",
        "<Cmd>Trouble loclist toggle<CR>",
        desc = "Location List (Trouble)",
      },
      {
        "<Leader>tq",
        "<Cmd>Trouble qflist toggle<CR>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
