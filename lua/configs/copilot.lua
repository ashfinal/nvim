local default = {
  panel = {
    enabled = false,
  },
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
}

require("copilot").setup(default)
