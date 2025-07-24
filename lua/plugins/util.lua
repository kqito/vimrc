---@diagnostic disable: undefined-global

return {
  -- Git
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<C-g>a", ":GWrite<CR>", { silent = true })
      vim.keymap.set({ "n", "v" }, "<C-g>o", ":GBrowse<CR>", { silent = true })
      vim.keymap.set({ "n", "v" }, "<C-g>d", ":Gdiffsplit<CR>", { silent = true })
      vim.keymap.set("n", "<C-g>b", ":Git blame<CR>", { silent = true })
    end
  },
  -- TODO: 問題なかったら後で削除
  -- {
  --   "airblade/vim-gitgutter",
  --   config = function()
  --     vim.keymap.set("x", "[git]a", "<C-u>lua GitGutterStageSelectedHunk()<CR>", { silent = false })
  --     vim.api.nvim_command [[
  --       function! GitGutterStageSelectedHunk()
  --         let l:line_start = line("'<")
  --         let l:line_end = line("'>")
  --         execute l:line_start . "," . l:line_end . "GitGutterStageHunk"
  --         execute l:line_start . "," . l:line_end . "GitGutterStageHunk"
  --       endfunction
  --     ]]

  --     -- Unbind default keymaps
  --     vim.api.nvim_del_keymap('n', '<Space>hp')
  --     vim.api.nvim_del_keymap('n', '<Space>hu')
  --     vim.api.nvim_del_keymap('n', '<Space>hs')
  --     vim.api.nvim_del_keymap('x', '<Space>hs')
  --     vim.api.nvim_del_keymap('n', '<Space>h')
  --   end
  -- },
  { "tpope/vim-rhubarb" },

  -- File Tree
  { "nvim-lua/plenary.nvim" },
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local function my_on_attach(bufnr)
        local api = require "nvim-tree.api"
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open Directory'))
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', 'y', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
        vim.keymap.set('n', 'e', api.node.open.tab, opts('Copy Absolute Path'))
      end
      require("nvim-tree").setup {
        auto_reload_on_write = true,
        disable_netrw = true,
        hijack_netrw = true,
        update_cwd = true,
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        on_attach = my_on_attach,
      }
      vim.keymap.set('n', '<space>b', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
    end
  },

  { "tpope/vim-commentary" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  -- {
  --   "907th/vim-auto-save",
  --   config = function()
  --     vim.g.auto_save = 0
  --     vim.api.nvim_create_augroup("ft_markdown", { clear = true })
  --     vim.api.nvim_create_autocmd("FileType", {
  --       group = "ft_markdown",
  --       pattern = "rust",
  --       callback = function()
  --         vim.b.auto_save = 1
  --       end
  --     })
  --     vim.g.auto_save_events = { "InsertLeave", "TextChanged" }
  --     vim.g.auto_save_presave_hook = "call coc#config('coc.preferences.formatOnSaveFiletypes', [])"
  --     vim.g.auto_save_postsave_hook = "call coc#config('coc.preferences.formatOnSaveFiletypes', ['*'])"
  --   end
  -- },
  {
    "simeji/winresizer",
    config = function()
      vim.keymap.set("n", "<space>t", ":WinResizerStartResize<CR>", { silent = true })
    end
  },
  {
    "Yggdroot/indentLine",
    config = function()
      vim.g.indentLine_conceallevel = vim.o.conceallevel
      vim.g.indentLine_concealcursor = vim.o.concealcursor
      vim.keymap.set("n", "<space>it", ":IndentLinesToggle<CR>", { silent = true })
      vim.g.indentLine_color_term = 113
    end
  },
  {
    "easymotion/vim-easymotion",
    config = function()
      vim.keymap.set("n", "m", "<Plug>(easymotion-overwin-f)", { silent = false })
      vim.g.EasyMotion_smartcase = 1
      vim.g.EasyMotion_use_smartsign_us = 1
    end
  },
  {
    "monaqa/dial.nvim",
    config = function()
      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
      vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
      vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
      vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
      vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
      require("dial.config").augends:register_group {
        default = {
          require("dial.augend").integer.alias.decimal,
          require("dial.augend").integer.alias.hex,
          require("dial.augend").date.alias["%Y/%m/%d"],
          require("dial.augend").constant.alias.bool,
        },
        mygroup = {
          require("dial.augend").integer.alias.decimal,
          require("dial.augend").date.alias["%m/%d/%Y"],
        }
      }
    end
  },
  {
    "kqito/vim-easy-replace",
  },
  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup {
        show_numbers = true,         -- Enable 'number' for the window while peeking
        show_cursorline = true,      -- Enable 'cursorline' for the window while peeking
        hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
        number_only = true,          -- Peek only when the command is only a number instead of when it starts with a number
        centered_peeking = true,     -- Peeked line will be centered relative to window
      }
    end,
  },
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({})
      vim.keymap.set({ 'n', 'x' }, '<space>rr', function()
        require('grug-far').open({})
      end, { desc = 'grug-far: Search within range' })
    end
  },
}
