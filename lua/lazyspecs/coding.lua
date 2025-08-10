return {
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
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
  },
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "1.*",
    dependencies = { "L3MON4D3/LuaSnip", "folke/lazydev.nvim" },
    opts= {
      completion = {
        menu = {
          border = "none",
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
          },
        },
        list = {
          selection = { preselect = false, auto_insert = false, },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
      keymap = {
        preset = "default",
        ["<C-Space>"] = { "show", "hide" },
        ["<Space>"] = { "show_documentation", "hide_documentation", "fallback" },
        ["<C-e>"] = { "fallback" },
        ["<C-c>"] = { "cancel", "fallback" },
        ["<C-k>"] = { "fallback" },
        ["<C-y>"] = { "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.get_selected_item() then
              return cmp.accept()
            elseif cmp.snippet_active() then
              return cmp.snippet_forward()
            elseif cmp.is_menu_visible() then
                 return cmp.select_and_accept()
            end
          end,
          "fallback_to_mappings",
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "lazydev" },
        providers = {
          lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },
      cmdline = {
        completion = {
          menu = {
            auto_show = false,
          }
        },
        keymap = {
          preset = "cmdline",
          ["<C-Space>"] = {},
          ["<C-e>"] = { "cancel", "fallback" },
        },
      },
      snippets = { preset = "luasnip" },
      signature = { enabled = true },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      panel = { enabled = false, },
      suggestion = {
        enabled = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
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
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      preview_config = { border = "single", },
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
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
