local function dirname()
  local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  return "📂 " .. dir_name .. " "
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

local navic = require("nvim-navic")

local default = {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = "",
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "fileformat" },
    lualine_b = { { "b:gitsigns_head", icon = "" }, { "diff", source = diff_source }, "diagnostics" },
    lualine_c = { "filename", { dirname },
      {
        function()
          return navic.get_location()
        end,
        cond = function()
          return navic.is_available()
        end
      }
    },
    lualine_x = { "encoding" },
    lualine_y = { "progress" },
    lualine_z = { "location" }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

require("lualine").setup(default)
