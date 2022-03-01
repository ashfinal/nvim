if vim.g.paq_bootstrap then
  local present = pcall(require, "lspconfig")

  if not present then
    vim.notify("Please rerun gotopreview hook or just restart nvim.", vim.log.levels.WARN)
    package.loaded['configs.gotopreview'] = nil
    return
  end
end

local default = {
  width = 120,
  height = 15,
  border = {"╭", "─" ,"╮", "│", "╯", "─", "╰", "│"},
  default_mappings = false,
  debug = false,
  opacity = nil,
  resizing_mappings = false,
  post_open_hook = nil,
  focus_on_open = true,
  dismiss_on_move = false,
  force_close = true,
  bufhidden = "wipe",
}

require("goto-preview").setup(default)
