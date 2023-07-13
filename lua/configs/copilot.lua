local default = {
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = false,
    debounce = 75,
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
}

require("copilot").setup(default)
