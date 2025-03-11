---@diagnostic disable: undefined-global

return {
  -- gruvbox-material
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme gruvbox-material")
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_better_performance = 1
    end,
  },

  -- {
  --   "morhetz/gruvbox",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd("colorscheme gruvbox")
  --     vim.o.background = "dark"
  --     vim.g.gruvbox_contrast_dark = 'hard'
  --   end,
  -- },

  -- {
  --   "sainnhe/everforest",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd("colorscheme everforest")
  --     vim.o.background = "dark"
  --     vim.g.everforest_background = 'hard'
  --   end,
  -- },

  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd("colorscheme tokyonight")
  --     vim.o.background = "dark"
  --   end,
  -- },

  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd("colorscheme kanagawa")
  --     vim.o.background = "dark"
  --   end,
  -- },
}
