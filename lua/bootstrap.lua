local paq_path = vim.fn.stdpath "data" .. "/site/pack/paqs/opt/paq-nvim"

if vim.fn.empty(vim.fn.glob(paq_path)) ~= 1 then
  vim.cmd "packadd paq-nvim"
end

local bootstrap = nil
local present, paq = pcall(require, "paq")

if not present then
  print "Cloning paq-nvim..."
  bootstrap = vim.fn.system {
    "git",
    "clone",
    "--depth=1",
    "https://github.com/savq/paq-nvim.git",
    paq_path,
  }

  vim.cmd "packadd paq-nvim"
  present, paq = pcall(require, "paq")

  if present then
    print "Paq-nvim cloned successfully."
  else
    error("Couldn't clone paq-nvim!")
  end
end

return { bootstrap = bootstrap, paq = paq }
