if vim.g.paq_bootstrap then
  local present = pcall(require, "nvim-treesitter")

  if not present then
    vim.notify("Please rerun nvim-gps hook or just restart nvim.", vim.log.levels.WARN)
    package.loaded['configs.nvim-gps'] = nil
    return
  end
end

local default = {
  disable_icons = false,
  icons = {
    ["class-name"] = " ",      -- Classes and class-like objects
    ["function-name"] = " ",   -- Functions
    ["method-name"] = " ",     -- Methods (functions inside class-like objects)
    ["container-name"] = " ",  -- Containers (example: lua tables)
    ["tag-name"] = " ",        -- Tags (example: html tags)
  },
  separator = " > ",
  -- limit for amount of context shown
  depth = 0,
  -- indicator used when context hits depth limit
  depth_limit_indicator = "..",
}

require("nvim-gps").setup(default)
