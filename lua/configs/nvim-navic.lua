if vim.g.paq_bootstrap then
  local present = pcall(require, "nvim-treesitter")

  if not present then
    vim.notify("Please rerun nvim-navic hook or just restart nvim.", vim.log.levels.WARN)
    package.loaded['configs.nvim-navic'] = nil
    return
  end
end

local default = {
  icons = {
    File = " ",
    Module = " ",
    Namespace = " ",
    Package = " ",
    Class = " ",
    Method = " ",
    Property = " ",
    Field = " ",
    Constructor = " ",
    Enum = " ",
    Interface = " ",
    Function = " ",
    Variable = " ",
    Constant = " ",
    String = " ",
    Number = " ",
    Boolean = " ",
    Array = " ",
    Object = " ",
    Key = " ",
    Null = " ",
    EnumMember = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },
  highlight = false,
  separator = " > ",
  depth_limit = 0,
  depth_limit_indicator = "..",
  safe_output = true,
}

require("nvim-navic").setup(default)
