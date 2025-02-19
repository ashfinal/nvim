return {
  { "kyazdani42/nvim-web-devicons", lazy = true },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<LocalLeader>p", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<LocalLeader>q", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<LocalLeader>w", "<Cmd>BufferLinePick<CR>", desc = "Pick buffers" },
    },
    opts = function()
      local bufferline = require("bufferline")
      return {
        options = {
          style_preset = bufferline.style_preset.minimal,
          numbers = function(opts)
            return string.format("%s", opts.raise(opts.id))
          end,
          middle_mouse_command = "vertical sbuffer %d",
          right_mouse_command = function(bufnr)
            require("bufdelete").bufdelete(bufnr, true)
          end,
          close_icon = "󰅚",
          show_close_icon = false,
          custom_filter = function(buf_number)
            if vim.bo[buf_number].filetype ~= "qf" then
              return true
            end
          end,
          offsets = {
            {
              filetype = "NvimTree",
              separator = true,
            },
            {
              filetype = "undotree",
              separator = true,
            },
            {
              filetype = "DiffviewFiles",
              separator = true,
            },
          },
          sort_by = "directory",
          groups = {
            items = {
              bufferline.groups.builtin.pinned:with({
                icon = ""
              })
            }
          },
        }
      }
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)
      vim.keymap.set("n", "]b", "<Cmd>BufferLineCycleNext<CR>")
      vim.keymap.set("n", "[b", "<Cmd>BufferLineCyclePrev<CR>")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local function diff_source()
        local gitsigns = vim.b["gitsigns_status_dict"]
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
          }
        end
      end

      return {
        options = {
          globalstatus = true,
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "fileformat" },
          lualine_b = { { "b:gitsigns_head", icon = "" },  },
          lualine_c = {
            { "diff", source = diff_source },
            "diagnostics",
            { "filename", path = 3 },
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },

          },
          lualine_x = { "encoding" },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
      }
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      preview = {
        delay_syntax = 80,
        show_scroll_bar = false,
        should_preview_cb = function(bufnr)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            -- skip file size greater than 100k
            ret = false
          elseif bufname:match("^fugitive://") then
            -- skip fugitive buffer
            ret = false
          end
          return ret
        end
      },
      func_map = { split = "<C-s>", fzffilter = "" },
    },
  },
  {
    "ibhagwan/fzf-lua",
    enabled = not jit.os:find("Windows"),
    opts = {
      winopts = {
        preview = {
          scrollbar = false,
        },
      },
      keymap = {
        builtin = {
          -- neovim `:tmap` mappings for the fzf win
          ["<F1>"]        = "toggle-help",
          ["<F2>"]        = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"]        = "toggle-preview-wrap",
          ["<F4>"]        = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<F5>"]        = "toggle-preview-ccw",
          ["<F6>"]        = "toggle-preview-cw",
          ["<S-down>"]    = "preview-page-down",
          ["<S-up>"]      = "preview-page-up",
          ["<S-left>"]    = "preview-page-reset",
        },
        fzf = {
          -- fzf '--bind=' options
          ["alt-a"]      = "toggle-all",
          ["pgdn"]     = "page-down",
          ["pgup"]       = "page-up",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["f3"]         = "toggle-preview-wrap",
          ["f4"]         = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"]   = "preview-page-up",
        },
      },
      fzf_colors = {
        ["fg"]          = { "fg", "CursorLine" },
        ["bg"]          = { "bg", "Normal" },
        ["hl"]          = { "fg", "Comment" },
        ["fg+"]         = { "fg", "Normal" },
        ["bg+"]         = { "bg", "CursorLine" },
        ["hl+"]         = { "fg", "Statement" },
        ["info"]        = { "fg", "PreProc" },
        ["prompt"]      = { "fg", "Conditional" },
        ["pointer"]     = { "fg", "Exception" },
        ["marker"]      = { "fg", "Keyword" },
        ["spinner"]     = { "fg", "Label" },
        ["header"]      = { "fg", "Comment" },
        ["gutter"]      = { "bg", "Normal" },
      },
      lsp = {
        symbols = {
          symbol_icons = {
            File = "󰈙",
            Module = "",
            Namespace = "󰦮",
            Package = "",
            Class = "󰠱",
            Method = "󰊕",
            Property = "",
            Field = "",
            Constructor = "",
            Enum = "",
            Interface = "",
            Function = "󰊕",
            Variable = "󰀫",
            Constant = "󰏿",
            String = "",
            Number = "󰎠",
            Boolean = "󰨙",
            Array = "󱡠",
            Object = "",
            Key = "󰌋",
            Null = "󰟢",
            EnumMember = "",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰊄",
          },
        },
      },
    },
    cmd = "FzfLua",
    keys = {
      { "<Leader>fb", function() require("fzf-lua").buffers() end, desc = "Fuzzy find buffers" },
      { "<Leader>fl", function() require("fzf-lua").lines() end, desc = "Fuzzy find lines" },
      { "<Leader>ff", function() require("fzf-lua").files() end, desc = "Fuzzy find files" },
      { "<Leader>fF", function() require("fzf-lua").git_files() end, desc = "Fuzzy find git files" },
      { "<Leader>fo", function() require("fzf-lua").oldfiles() end, desc = "Fuzzy find oldfiles" },
      { "<Leader>ft", function() require("fzf-lua").grep_project() end, desc = "Fuzzy find text in project" },
      { "<Leader>fj", function() require("fzf-lua").jumps() end, desc = "Fuzzy find jumps" },
      { "<Leader>fm", function() require("fzf-lua").marks() end, desc = "Fuzzy find marks" },
      { "<Leader>fw", function() require("fzf-lua").grep_cword() end, desc = "Search word under cursor" },
      { "<Leader>fc", function() require("fzf-lua").git_bcommits() end, desc = "Fuzzy find git bcommits" },
      { "<Leader>fC", function() require("fzf-lua").git_commits() end, desc = "Fuzzy find git commits" },
      { "<Leader>fs", function() require("fzf-lua").lsp_document_symbols() end, desc = "Fuzzy find lsp document symbols" },
      { "<Leader>fS", function() require("fzf-lua").lsp_workspace_symbols() end, desc = "Fuzzy find lsp workspace symbols" },
      { "<Leader>/", function() require("fzf-lua").keymaps() end, desc = "Fuzzy find keymaps" },
    },
  },
  {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeOpen", "NvimTreeToggle" },
    keys = {
      { "<Leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
    },
    opts = function()
      local function on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.del("n", "<BS>", { buffer = bufnr })
        vim.keymap.del("n", "g?", { buffer = bufnr })
        vim.keymap.del("n", "<C-x>", { buffer = bufnr })
        vim.keymap.del("n", "<C-k>", { buffer = bufnr })
        vim.keymap.set("n", "w", api.node.navigate.parent_close, opts("Close Directory"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "i", api.node.show_info_popup, opts("Info"))
      end

      return {
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        renderer = {
          highlight_opened_files = "all",
          icons = {
            git_placement = "after",
            show = {
              file = true,
            },
          },
        },
        actions = {
          file_popup = {
            open_win_config = {
              border = "single",
            },
          },
        },
        on_attach = on_attach,
      }
    end,
  },
  {
    "numToStr/FTerm.nvim",
    keys = {
      { "<A-i>", "<Cmd>lua require('FTerm').toggle()<CR>", desc = "Toggle FTerm" },
    },
    opts = {
      border = "double",
      hl = "Normal",
      blend = 0,
      dimensions  = {
        height = 0.9,
        width = 0.9,
      },
    },
    config = function(_, opts)
      require("FTerm").setup(opts)
      vim.keymap.set("t", "<A-i>", "<C-\\><C-n><Cmd>lua require('FTerm').toggle()<CR>")
    end
  },
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    opts = {
      context = 0,
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = { width = 0.8, },
      plugins = { twilight = { enabled = false } },
    },
  },
}
