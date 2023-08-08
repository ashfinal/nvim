local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  print("Cloning package manager: lazy.nvim...")
  local output = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  assert(vim.v.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "RRethy/nvim-base16",
      priority = 10000,
      version = false,
      config = function()
        vim.api.nvim_create_autocmd("ColorScheme", {
          callback = function()
            vim.api.nvim_set_hl(0, "Folded", { link = "NonText", default = false })
            vim.api.nvim_set_hl(0, "WinSeparator", { link = "NonText", default = false })
          end,
        })
        vim.cmd.colorscheme("base16-espresso")
      end,
    },
    { import = "lazyspecs" },
  },
  defaults = {
    version = false, -- always use the latest git commit
    dev = {
      path = "~/projects",
      patterns = { "ashfinal" },
      fallback = true,
    }
  },
  ui = { border = "rounded" },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "spellfile_plugin",
        "tarPlugin",
        "zipPlugin",
      }
    },
  },
})

