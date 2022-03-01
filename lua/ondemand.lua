local function pkgs_exist(pkgs, dir)
  if type(pkgs) == "string" then
    pkgs = { pkgs }
  end
  local p = vim.fn.stdpath "data" .. "/site/pack/paqs/"
  for _, pkg in ipairs(pkgs) do
    local f = p .. dir .. "/" .. pkg
    if vim.fn.empty(vim.fn.glob(f)) == 1 then return false end
  end
  return true
end

if pkgs_exist("filetype.nvim", "start") then
  vim.g.did_load_filetypes = 1
end

if pkgs_exist("vim-matchup", "start") then
  vim.g.loaded_matchit = 1
  vim.g.matchup_matchparen_offscreen = { method = 'popup' }
  vim.g.matchup_delim_noskips = 2
end

if pkgs_exist("nvim-web-devicons", "opt") then
  vim.cmd([[
    augroup plugins_devicons
      autocmd!
      autocmd VimEnter * ++once packadd nvim-web-devicons
        \ | lua require("configs.devicons")
    augroup END
  ]])
end

if pkgs_exist("bufdelete.nvim", "opt") then
  vim.cmd([[
    augroup plugins_bufdelete
      autocmd!
      autocmd BufEnter * ++once packadd bufdelete.nvim
        \ | nnoremap <Leader>x <Cmd>lua require("bufdelete").bufdelete(0, true)<CR>
    augroup END
  ]])
end

if pkgs_exist("bufferline.nvim", "opt") then
  vim.cmd([[
    augroup plugins_bufferline
      autocmd!
      autocmd BufEnter * ++once packadd bufferline.nvim
        \ | lua require("configs.bufferline")
    augroup END
  ]])
end

if pkgs_exist("nvim-base16", "opt") then
  vim.cmd([[
    augroup plugins_base16
      autocmd!
      autocmd VimEnter * ++once packadd nvim-base16
        \ | lua require("configs.base16")
    augroup END
  ]])
end

if pkgs_exist("lualine.nvim", "opt") then
  vim.cmd([[
    augroup plugins_lualine
      autocmd!
      autocmd BufEnter * ++once packadd lualine.nvim
        \ | lua require("configs.lualine")
    augroup END
  ]])
end

if pkgs_exist({ "telescope.nvim", "plenary.nvim" }, "opt") then
  vim.cmd([[
    augroup plugins_telescope
      autocmd!
      autocmd VimEnter * ++once packadd plenary.nvim
        \ | packadd telescope.nvim
        \ | lua require("configs.telescope")
    augroup END
  ]])
end

if pkgs_exist({ "gitsigns.nvim", "plenary.nvim" }, "opt") then
  vim.cmd([[
    augroup plugins_gitsigns
      autocmd!
      autocmd VimEnter * ++once packadd plenary.nvim
        \ | packadd gitsigns.nvim
        \ | lua require("configs.gitsigns")
    augroup END
  ]])
end

if pkgs_exist({ "goto-preview", "nvim-lspconfig" }, "opt") then
  vim.cmd([[
    augroup plugins_gotopreview
      autocmd!
      autocmd BufReadPre * ++once packadd goto-preview
        \ | lua require("configs.gotopreview")
    augroup END
  ]])
end

if pkgs_exist({ "nvim-lspconfig", "nvim-cmp", "cmp-nvim-lsp", "lsp_signature.nvim" }, "opt") then
  vim.cmd([[
    augroup plugins_lspconfig
      autocmd!
      autocmd BufReadPre * ++once packadd nvim-cmp
        \ | packadd cmp-nvim-lsp
        \ | packadd lsp_signature.nvim
        \ | packadd nvim-lspconfig
        \ | lua require("cmp_nvim_lsp").setup()
        \ require("configs.lspconfig")
    augroup END
  ]])
end

if pkgs_exist({ "LuaSnip", "friendly-snippets" }, "opt") then
  vim.cmd([[
    augroup plugins_luasnip
      autocmd!
      autocmd InsertEnter * ++once packadd friendly-snippets
        \ | packadd LuaSnip
        \ | lua require("configs.luasnip")
    augroup END
  ]])
end

if pkgs_exist({ "nvim-cmp", "cmp-buffer", "cmp-path", "cmp-cmdline", "cmp_luasnip" }, "opt") then
  vim.cmd([[
    augroup plugins_cmp
      autocmd!
      autocmd InsertEnter * ++once packadd nvim-cmp
        \ | packadd cmp-buffer
        \ | packadd cmp-path
        \ | packadd cmp-cmdline
        \ | packadd cmp_luasnip
        \ | lua require("configs.nvim-cmp") require("configs.cmp-buffer")
        \ require("configs.cmp-path") require("configs.cmp-cmdline")
        \ require("configs.cmp_luasnip")
    augroup END
  ]])
end

if pkgs_exist("fidget.nvim", "opt") then
  vim.cmd([[
    augroup plugins_fidget
      autocmd!
      autocmd BufReadPre * ++once packadd fidget.nvim
        \ | lua require("fidget").setup{}
    augroup END
  ]])
end

if pkgs_exist({ "nvim-treesitter", "nvim-ts-autotag" }, "opt") then
  vim.cmd([[
    augroup plugins_treesitter
      autocmd!
      autocmd VimEnter * ++once packadd nvim-treesitter
        \ | packadd nvim-ts-autotag
        \ | lua require("configs.treesitter")
    augroup END
  ]])
end

if pkgs_exist("indent-blankline.nvim", "opt") then
  vim.cmd([[
    augroup plugins_blankline
      autocmd!
      autocmd VimEnter * ++once packadd indent-blankline.nvim
        \ | lua require("configs.blankline")
    augroup END
  ]])
end

if pkgs_exist("nvim-colorizer.lua", "opt") then
  vim.cmd([[
    augroup plugins_colorizer
      autocmd!
      autocmd BufReadPre * ++once packadd nvim-colorizer.lua
        \ | lua require("configs.colorizer")
    augroup END
  ]])
end

if pkgs_exist({ "nvim-autopairs", "nvim-cmp" }, "opt") then
  vim.cmd([[
    augroup plugins_autopairs
      autocmd!
      autocmd InsertEnter * ++once packadd nvim-autopairs
        \ | lua require("configs.autopairs")
    augroup END
  ]])
end

if pkgs_exist("Comment.nvim", "opt") then
  vim.cmd([[
    augroup plugins_comment
      autocmd!
      autocmd BufReadPost * ++once packadd Comment.nvim
        \ | lua require("Comment").setup()
    augroup END
  ]])
end

if pkgs_exist("nvim-tree.lua", "opt") then
  vim.g.nvim_tree_highlight_opened_files = 1
  vim.g.nvim_tree_respect_buf_cwd = 1
  vim.g.nvim_tree_create_in_closed_folder = 1
  vim.cmd([[
    augroup plugins_nvimtree
      autocmd!
      autocmd BufReadPost * ++once packadd nvim-tree.lua
        \ | lua require("configs.nvimtree")
    augroup END
  ]])
end

if pkgs_exist("nvim-bqf", "opt") then
  vim.cmd([[
    augroup plugins_bqf
      autocmd!
      autocmd BufReadPost * ++once packadd nvim-bqf
        \ | lua require("configs.nvim-bqf")
    augroup END
  ]])
end

if pkgs_exist("marks.nvim", "opt") then
  vim.cmd([[
    augroup plugins_marks
      autocmd!
      autocmd BufReadPost * ++once packadd marks.nvim
        \ | lua require("configs.marks")
    augroup END
  ]])
end

if pkgs_exist("registers.nvim", "opt") then
  vim.cmd([[
    augroup plugins_registers
      autocmd!
      autocmd BufReadPost * ++once packadd registers.nvim
        \ | lua require("configs.registers")
    augroup END
  ]])
end

if pkgs_exist({ "twilight.nvim", "zen-mode" }, "opt") then
  vim.cmd([[
    augroup plugins_zenmode
      autocmd!
      autocmd InsertLeave * ++once packadd twilight.nvim
        \ | packadd zen-mode.nvim
        \ | lua require("configs.twilight")
        \ require("configs.zenmode")
    augroup END
  ]])
end

if pkgs_exist("FTerm.nvim", "opt") then
  vim.cmd([[
    augroup plugins_fterm
      autocmd!
      autocmd InsertLeave * ++once packadd FTerm.nvim
        \ | lua require("configs.fterm")
    augroup END
  ]])
end

if pkgs_exist("vim-sandwich", "opt") then
  vim.cmd([[
    augroup plugins_sandwich
      autocmd!
      autocmd BufReadPost * ++once packadd vim-sandwich
    augroup END
  ]])
end

if pkgs_exist("undotree", "opt") then
  vim.cmd([[
    augroup plugins_undotree
      autocmd!
      autocmd BufReadPost * ++once packadd undotree
        \ | let g:undotree_SetFocusWhenToggle = 1
        \ | silent nnoremap <Leader>u <Cmd>UndotreeToggle<CR>
    augroup END
  ]])
end

if pkgs_exist("vim-easy-align", "opt") then
  vim.cmd([[
    augroup plugins_align
      autocmd!
      autocmd BufReadPost * ++once packadd vim-easy-align
        \ | silent xmap gz <Plug>(EasyAlign)
        \ | silent nmap gz <Plug>(EasyAlign)
    augroup END
  ]])
end

if pkgs_exist("vim-textmanip", "opt") then
  vim.cmd([[
    augroup plugins_align
      autocmd!
      autocmd BufReadPost * ++once packadd vim-textmanip
        \ | silent xmap <C-j> <Plug>(textmanip-move-down)
        \ | silent xmap <C-k> <Plug>(textmanip-move-up)
        \ | silent xmap <C-h> <Plug>(textmanip-move-left)
        \ | silent xmap <C-l> <Plug>(textmanip-move-right)
    augroup END
  ]])
end
