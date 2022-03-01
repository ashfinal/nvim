if vim.g.paq_bootstrap then
  local present = pcall(require, "plenary")

  if not present then
    vim.notify("Please rerun telescope hook or just restart nvim.", vim.log.levels.WARN)
    package.loaded['configs.telescope'] = nil
    return
  end
end

local map = require("utils").map
local action_layout = require("telescope.actions.layout")
local previewers = require("telescope.previewers")
local putils = require("telescope.previewers.utils")

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, vim.schedule_wrap(function(_, stat)
    if not stat then return end
    if stat.size > 100000 then
      putils.set_preview_message(bufnr, opts.winid, "Exceed the threshold of filesize > 100KB")
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end))
end

local default = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
    },
    selection_strategy = "follow",
    scroll_strategy = "limit",
    path_display = { "smart", "truncate" },
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
      },
    },
    file_ignore_patterns = { "node_modules", "%.?cache" },
    preview = {
      filesize_limit = 0.1,
      timeout = 500,
      hide_on_startup = false,
    },
    buffer_previewer_maker = new_maker,
    mappings = {
      n = { ["<M-p>"] = action_layout.toggle_preview },
      i = { ["<M-p>"] = action_layout.toggle_preview },
    },
  },
}

require("telescope").setup(default)

map("n", "<Leader>bb", [[<Cmd>lua require('telescope.builtin').buffers({ prompt_prefix=" > ", prompt_title=false, preview_title=false, results_title=false })<CR>]])
map("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files({ prompt_prefix=" > ", prompt_title=false, preview_title=false, results_title=false })<CR>]])
map("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles({ prompt_prefix=" > ", prompt_title=false, preview_title=false, results_title=false })<CR>]])
map("n", "<Leader>fw", [[<Cmd>lua require('telescope.builtin').live_grep({ prompt_prefix=" > ", prompt_title=false, preview_title=false, results_title=false })<CR>]])
map("n", "<Leader>fm", [[<Cmd>lua require('telescope.builtin').git_commits({ prompt_prefix=" > ", prompt_title=false, preview_title=false, results_title=false })<CR>]])
map("n", "<Leader>?", [[<Cmd>lua require('telescope.builtin').keymaps({ prompt_prefix=" > ", prompt_title=false, preview_title=false, results_title=false })<CR>]])
