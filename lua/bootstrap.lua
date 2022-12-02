local path = vim.fn.stdpath("data") .. "/site/pack/deps/opt/dep"

if vim.fn.empty(vim.fn.glob(path)) ~= 1 then
  vim.cmd("packadd dep")
end

local bootstrap = nil
local present, dep = pcall(require, "dep")

if not present then
  print "Cloning package manager-dep..."
  bootstrap = vim.fn.system {
    "git",
    "clone",
    "--depth=1",
    "https://github.com/chiyadev/dep.git",
    path,
  }

  vim.cmd("packadd dep")
  present, dep = pcall(require, "dep")

  if present then
    print "Dep cloned successfully."
  else
    error("Couldn't clone dep!")
  end
end

if bootstrap then vim.g.dep_bootstrap = true end

return dep
