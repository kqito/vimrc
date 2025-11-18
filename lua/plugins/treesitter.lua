---@diagnostic disable: undefined-global

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = "BufRead",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = 'all',
        -- remind: failed install ipkg, so ignore it temporarily
        ignore_install = { 'ipkg' },
        additional_vim_regex_highlighting = false,
        highlight = {
          enable = true,
          disable = { 'help' },
        },
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    config = function()
      require 'treesitter-context'.setup {
        enable = true,
        max_lines = 8,
        trim_scope = 'outer',
        patterns = {
          default = {
            'class',
            'function',
            'method',
          },
        },
        zindex = 20,
        mode = 'cursor',
      }
    end
  },
}
