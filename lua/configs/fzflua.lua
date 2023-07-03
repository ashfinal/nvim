local default = {
  winopts = {
    preview = {
      scrollbar = false,
    },
  },
}

require("fzf-lua").setup(default)

vim.keymap.set("n", "<Leader>bb", function() return require("fzf-lua").buffers() end, { silent = true, desc = "Fuzzy find buffers" })
vim.keymap.set("n", "<Leader>fl", function() return require("fzf-lua").lines() end, { silent = true, desc = "Fuzzy find lines" })
vim.keymap.set("n", "<Leader>ff", function() return require("fzf-lua").files() end, { silent = true, desc = "Fuzzy find files" })
vim.keymap.set("n", "<Leader>fo", function() return require("fzf-lua").oldfiles() end, { silent = true, desc = "Fuzzy find oldfiles" })
vim.keymap.set("n", "<Leader>ft", function() return require("fzf-lua").grep_project() end, { silent = true, desc = "Fuzzy find text in project" })
vim.keymap.set("n", "<Leader>jj", function() return require("fzf-lua").jumps() end, { silent = true, desc = "Fuzzy find jumps" })
vim.keymap.set("n", "<Leader>mm", function() return require("fzf-lua").marks() end, { silent = true, desc = "Fuzzy find marks" })
vim.keymap.set("n", "<Leader>fw", function() return require("fzf-lua").grep_cword() end, { silent = true, desc = "Search word under cursor" })
vim.keymap.set("n", "<Leader>fm", function() return require("fzf-lua").git_commits() end, { silent = true, desc = "Fuzzy find git commits" })
vim.keymap.set("n", "<Leader>bm", function() return require("fzf-lua").git_bcommits() end, { silent = true, desc = "Fuzzy find git bcommits" })
vim.keymap.set("n", "<Leader>go", function() return require("fzf-lua").lsp_document_symbols() end, { silent = true, desc = "Fuzzy find lsp document symbols" })
vim.keymap.set("n", "<Leader>gt", function() return require("fzf-lua").lsp_workspace_symbols() end, { silent = true, desc = "Fuzzy find lsp workspace symbols" })
vim.keymap.set("n", "<Leader>/", function() return require("fzf-lua").keymaps() end, { silent = true, desc = "Fuzzy find keymaps" })
