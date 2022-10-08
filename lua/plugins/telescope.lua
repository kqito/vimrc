local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

vim.keymap.set('n', 'sp', builtin.find_files)
vim.keymap.set('n', 'ss', builtin.grep_string)
vim.keymap.set('n', 'sg', builtin.live_grep)
vim.keymap.set('n', 'sb', builtin.buffers)
vim.keymap.set('n', 'sh', builtin.help_tags)
vim.keymap.set('n', 'sy', builtin.oldfiles)
vim.keymap.set('n', 'sw', builtin.lsp_workspace_symbols)
vim.keymap.set('n', 'so', builtin.lsp_document_symbols)
vim.keymap.set('n', 'se', builtin.diagnostics)

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-e>"] = actions.file_tab,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  },
  color_devicons = true,
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
