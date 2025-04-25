---@diagnostic disable: undefined-global


---@diagnostic disable-next-line: lowercase-global
function open_current_file_in_cursor()
  local buf_path = vim.fn.expand('%:p')
  local line_number = vim.fn.line('.')
  local escaped_path = vim.fn.shellescape(buf_path)
  vim.cmd('!' .. 'cursor -g ' .. escaped_path .. ':' .. line_number)
end

vim.api.nvim_set_keymap('n', '<C-g>0', ':lua open_current_file_in_cursor()<CR>', { noremap = true, silent = true })


---@diagnostic disable-next-line: lowercase-global
function open_buffer_line()
  local buf_path = vim.fn.expand('%:p')
  local start_line = vim.fn.line("'<")
  local line_number = start_line
  local escaped_path = vim.fn.shellescape(buf_path)

  vim.cmd('!' .. 'cursor -g ' .. escaped_path .. ':' .. line_number)
end

vim.api.nvim_set_keymap('v', '<C-g>0', ":lua open_buffer_line()<CR>", { noremap = true, silent = true })

return {
  -- Copilot
  {
    "github/copilot.vim",
    lazy = false, -- lazyしたいが下記設定だとcopilotが動かないので暫定
    -- lazy = true,
    -- event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-f>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
      vim.keymap.set("i", "<C-c>", "<ESC>:Copilot<CR>", { silent = true })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    keys = {
      { "<space>aa", "<cmd>CopilotChatToggle<cr>", desc = "Avante Chat" },
    },
    config = function()
      require("CopilotChat").setup({
        mappings = {
          -- Resolve configuration conflicts Tab/S-Tab mappings
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "",
          },
          submit_prompt = {
            normal = '<CR>',
            -- insert = '<C-CR>',
          },
        },
        model = 'gpt-4o',
        agent = 'copilot',
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "copilot-chat",
        callback = function()
          vim.api.nvim_buf_set_keymap(0, "i", "<Tab>", [[pumvisible() ? '<C-n>' : '<Tab>']],
            { expr = true, noremap = true })
          vim.api.nvim_buf_set_keymap(0, "i", "<S-Tab>", [[pumvisible() ? '<C-p>' : '<S-Tab>']],
            { expr = true, noremap = true })
        end,
      })
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          -- Set buffer-local options
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
          vim.opt_local.conceallevel = 0
        end
      })
    end,
  },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  --   opts = {
  --     -- add any opts here
  --     -- for example
  --     provider = "copilot",
  --     auto_suggestions_provider = "copilot",
  --     behaviour = {
  --       auto_suggestions = true,
  --       auto_set_highlight_group = true,
  --       auto_set_keymaps = true,
  --       auto_apply_diff_after_generation = true,
  --       support_paste_from_clipboard = true,
  --     },
  --     -- windows = {
  --     --   position = "right",
  --     --   width = 30,
  --     --   sidebar_header = {
  --     --     align = "center",
  --     --     rounded = false,
  --     --   },
  --     --   ask = {
  --     --     floating = true,
  --     --     start_insert = true,
  --     --     border = "rounded"
  --     --   }
  --     -- },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.pick",         -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua",              -- for file_selector provider fzf
  --     "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
  --     "github/copilot.vim",            -- for providers='copilot'
  --     -- "zbirenbaum/copilot.lua",        -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- }
}
