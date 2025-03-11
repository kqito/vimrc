---@diagnostic disable: undefined-global

return {
  {
    "christoomey/vim-tmux-navigator",
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.keymap.set("n", "<C-t>h", ":TmuxNavigateLeft<cr>", { silent = true })
      vim.keymap.set("n", "<C-t>j", ":TmuxNavigateDown<cr>", { silent = true })
      vim.keymap.set("n", "<C-t>k", ":TmuxNavigateUp<cr>", { silent = true })
      vim.keymap.set("n", "<C-t>l", ":TmuxNavigateRight<cr>", { silent = true })
      vim.keymap.set("n", "<C-t>\\", ":TmuxNavigatePrevious<cr>", { silent = true })
    end
  },
}
