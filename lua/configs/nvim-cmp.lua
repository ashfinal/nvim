local cmp = require("cmp")
local luasnip = require("luasnip")

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
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
  TypeParameter = "",
  Copilot = "",
}

vim.opt.completeopt = "menuone,noselect"

local function bufIsBig()
  local max_filesize = 200 * 1024 -- 200 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.fn.expand("%:p"))
  if ok and stats and stats.size > max_filesize then
    return true
  else
    return false
  end
end

local default = {
  enabled = function()
    if vim.tbl_contains({ "TelescopePrompt" }, vim.o.ft) then
      return false
    end
    if bufIsBig() then return false end
    return true
  end,

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
        copilot = "[Copilot]",
      })[entry.source.name]
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
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "c" }),
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
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
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
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

cmp.setup(default)

cmp.setup.cmdline({ "/", "?" }, {
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  })
})
