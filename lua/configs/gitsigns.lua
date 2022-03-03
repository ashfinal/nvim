if vim.g.paq_bootstrap then
  local present = pcall(require, "plenary")

  if not present then
    vim.notify("Please rerun gitsigns hook or just restart nvim.", vim.log.levels.WARN)
    package.loaded['configs.gitsigns'] = nil
    return
  end
end

local bmap = require("utils").bmap

local default = {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'rounded',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    -- Navigation
    bmap(bufnr, 'n', ']c', "&diff ? ']c' : '<Cmd>Gitsigns next_hunk<CR>'", { expr = true })
    bmap(bufnr, 'n', '[c', "&diff ? '[c' : '<Cmd>Gitsigns prev_hunk<CR>'", { expr = true })
    -- Actions
    bmap(bufnr, 'n', '<Leader>hs', ':Gitsigns stage_hunk<CR>')
    bmap(bufnr, 'v', '<Leader>hs', ':Gitsigns stage_hunk<CR>')
    bmap(bufnr, 'n', '<Leader>hr', ':Gitsigns reset_hunk<CR>')
    bmap(bufnr, 'v', '<Leader>hr', ':Gitsigns reset_hunk<CR>')
    bmap(bufnr, 'n', '<Leader>hS', '<Cmd>Gitsigns stage_buffer<CR>')
    bmap(bufnr, 'n', '<Leader>hu', '<Cmd>Gitsigns undo_stage_hunk<CR>')
    bmap(bufnr, 'n', '<Leader>hR', '<Cmd>Gitsigns reset_buffer<CR>')
    bmap(bufnr, 'n', '<Leader>hp', '<Cmd>Gitsigns preview_hunk<CR>')
    bmap(bufnr, 'n', '<Leader>hb', '<Cmd>lua require("gitsigns").blame_line{ full = true }<CR>')
    bmap(bufnr, 'n', '<Leader>tb', '<Cmd>Gitsigns toggle_current_line_blame<CR>')
    bmap(bufnr, 'n', '<Leader>hd', '<Cmd>Gitsigns diffthis<CR>')
    bmap(bufnr, 'n', '<Leader>hD', '<Cmd>lua require("gitsigns").diffthis("~")<CR>')
    bmap(bufnr, 'n', '<Leader>td', '<Cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    bmap(bufnr, 'o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    bmap(bufnr, 'x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}

require("gitsigns").setup(default)
