return {
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    event = "InsertEnter",
    opts = function()
      local types = require("luasnip.util.types")
      return {
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "∙", "Conditional" } }
            }
          },
          [types.insertNode] = {
            active = {
              virt_text = { { "∙", "String" } }
            }
          }
        },
      }
    end,
    config = function(_, opts)
      local luasnip = require("luasnip")
      luasnip.setup(opts)

      vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*",
        callback = function()
          if ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
              and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
              and not luasnip.session.jump_active
          then
            luasnip.unlink_current()
          end
        end
      })

      vim.keymap.set({"i", "s"}, "<C-j>", function()
        if luasnip.choice_active() then
          return luasnip.next_choice()
        else
          return "<C-j>"
        end
      end, { silent = true, expr = true })

      vim.keymap.set({"i", "s"}, "<C-k>", function()
        if luasnip.choice_active() then
          return luasnip.prev_choice()
        else
          return "<C-k>"
        end
      end, { silent = true, expr = true })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "zbirenbaum/copilot-cmp",
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local kind_icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "󰀫",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "󰊄",
        Copilot = "",
      }

      local function bufIsBig()
        local max_filesize = 500 * 1024 -- 500 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.fn.expand("%:p"))
        if ok and stats and stats.size > max_filesize then
          return true
        else
          return false
        end
      end

      return {
        enabled = function()
          if vim.api.nvim_get_mode().mode == 'c' then return true end
          if vim.tbl_contains({ "TelescopePrompt" }, vim.o.ft) then return false end
          if bufIsBig() then return false end
          return true
        end,

        completion = {
          completeopt = "menuone,noselect",
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
              buffer = "[]",
              luasnip = "[]",
              nvim_lsp = "[]",
              copilot = "[]",
            })[entry.source.name]
            vim_item.abbr = string.gsub(vim_item.abbr, "%(.+%)", "")
            return vim_item
          end
        },

        window = {
          completion = cmp.config.window.bordered({
            border = "none",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "solid",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu",
          }),
        },

        mapping = {
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item( { behavior = cmp.SelectBehavior.Select } )
            else
              fallback()
            end
          end, { "i", "c" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item( { behavior = cmp.SelectBehavior.Select } )
            else
              fallback()
            end
          end, { "i", "c" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ select = false })
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
          }),
        },

        sources = cmp.config.sources({
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          {
            name = "buffer",
            option = {
              keyword_length = 2,
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },
        })
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline({ "/", "?" }, {
        sources = {
          { name = "buffer" }
        }
      })
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        })
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      panel = { enabled = false, },
      suggestion = {
        enabled = false,
        debounce = 75,
      },
      filetypes = {
        csv = false,
        qf = false,
        ["."] = false,
        ["*"] = true,
      },
    },
  },
  {
    "nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require("copilot_cmp")
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          require("utils").on_attach(function(client)
            if client.name == "copilot" then
              copilot_cmp._on_insert_enter({})
            end
          end)
        end,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      preview_config = { border = "rounded", },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, silent = true, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<Leader>hs", "<Cmd>Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<Leader>hr", "<Cmd>Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<Leader>hS", gs.stage_buffer, "Stage Buffer")
        map("n", "<Leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<Leader>hR", gs.reset_buffer, "Reset Buffer")
        map("n", "<Leader>hp", gs.preview_hunk, "Preview Hunk")
        map("n", "<Leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<Leader>hd", gs.diffthis, "Diff This")
        map("n", "<Leader>hD", function() gs.diffthis("~") end, "Diff This ~")
        map("n", "<Leader>tb", gs.toggle_current_line_blame, "Toggle blame")
        map("n", "<Leader>td", gs.toggle_deleted, "Toggle deleted")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
}
