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

local default = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '',
    section_separators = {left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'fileformat'},
    lualine_b = {{'b:gitsigns_head', icon = ''}, {'diff', source = diff_source}, 'diagnostics'},
    lualine_c = {'filename', { dirname }},
    lualine_x = {'encoding'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

local present, gps = pcall(require, "nvim-gps")
if present then
  default["sections"]["lualine_c"][3] = { gps.get_location, cond = gps.is_available }
end

require("lualine").setup(default)
