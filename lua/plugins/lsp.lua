---@diagnostic disable: undefined-global

return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      vim.opt.hidden = true
      vim.opt.backup = false
      vim.opt.writebackup = false
      vim.opt.cmdheight = 2
      vim.opt.updatetime = 300
      vim.opt.shortmess:append "c"
      vim.opt.signcolumn = "yes"

      vim.g.coc_filetype_map = {
        ["*.jsx"] = "javascriptreact",
        ["*.tsx"] = "typescriptreact",
      }
      vim.g.coc_global_extensions = {
        "coc-browser",
        "coc-calc",
        "coc-clock",
        "coc-css",
        "coc-deepl",
        "coc-emmet",
        "coc-eslint",
        "coc-git",
        "coc-github",
        "coc-gitignore",
        "coc-highlight",
        "coc-html",
        "coc-jest",
        "coc-json",
        "coc-lines",
        "coc-lists",
        "coc-lua",
        "coc-marketplace",
        "coc-omni",
        "coc-omnisharp",
        "coc-pairs",
        "coc-phpls",
        "coc-prettier",
        "coc-project",
        "coc-python",
        "coc-rust-analyzer",
        "coc-sh",
        "coc-sql",
        "coc-syntax",
        "coc-stylelint",
        "coc-tabnine",
        "coc-tag",
        "coc-todolist",
        "coc-translator",
        "coc-tsserver",
        "coc-vetur",
        "coc-vimlsp",
        "coc-vimtex",
        "coc-webpack",
        "coc-word",
        "coc-yaml",
        "coc-yank",
      }

      --  Map with vim script since not working with pure lua setup
      vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
          vim.cmd([[
      inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
      inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

      function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction
    ]])
        end
      })

      vim.keymap.set("i", "<CR>", 'coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"',
        { expr = true, silent = true })
      vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
      vim.keymap.set("n", "gt", "<Plug>(coc-declaration)", { silent = true })
      vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
      vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
      vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })
      vim.keymap.set("n", "gu", "<Plug>(coc-references-used)", { silent = true })
      vim.keymap.set("n", "gb", "<C-o>", { silent = true })
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end

      vim.keymap.set("n", "<space>d", '<CMD>lua _G.show_docs()<CR>', { silent = true })
      vim.keymap.set("x", "<space>f", "<Plug>(coc-format-selected)", { silent = true })
      vim.keymap.set("n", "<space>f", "<Plug>(coc-format-selected)", { silent = true })
      vim.cmd [[
        augroup mygroup
          autocmd!
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end
      ]]
      vim.keymap.set("x", "<space>a", "<Plug>(coc-codeaction-selected)", { silent = true })
      vim.keymap.set("n", "<space>a", "<Plug>(coc-codeaction-selected)", { silent = true })
      vim.keymap.set("n", "<space>c", ":CocCommand<CR>", { silent = true })
      vim.keymap.set("n", "<space>.", "<plug>(coc-codeaction-line)", { silent = true })
      vim.keymap.set("v", "<space>.", "<plug>(coc-codeaction-selected)", { silent = true })
      -- vim.keymap.set("n", "<space>rr", "<plug>(coc-refactor)", { silent = true })
      vim.keymap.set("n", "<space>rn", "<Plug>(coc-rename)", { silent = true })
      vim.keymap.set("n", "<space>rf", ":CocCommand workspace.renameCurrentFile<CR>", { silent = true })
      vim.keymap.set("n", "<space>k", "<Plug>(coc-diagnostic-prev)", { silent = true })
      vim.keymap.set("n", "<space>j", "<Plug>(coc-diagnostic-next)", { silent = true })
      vim.g.markdown_fenced_languages = { "css", "javascript", "js=javascript", "typescript" }
      vim.keymap.set({ "n", "v" }, "<space>T", "<Plug>(coc-deepl-selected)", { silent = true })
      vim.keymap.set("n", "<space>T", "<Plug>(coc-deepl)", { silent = true })

      vim.keymap.set("n", "s", "Nop", { silent = true })
      vim.keymap.set("n", "<space>e", ":<C-u>CocList diagnostics<CR>", { silent = true })
      vim.keymap.set("n", "<space>y", ":<C-u>CocList -A --normal yank<CR>", { silent = true })
      vim.keymap.set("n", "so", ":<C-u>CocList -A outline<CR>", { silent = true })
      vim.keymap.set("n", "sw", ":<C-u>CocList -A -I symbols<CR>", { silent = true })
      vim.keymap.set("n", "sg", ":<C-u>CocList -A -I grep<CR>", { silent = true })
      vim.keymap.set("n", "ss", ":exe 'CocList -A -I --input='.expand('<cword>').' grep'<CR>", { silent = true })
      vim.keymap.set("n", "sp", ":<C-u>CocList files<CR>", { silent = true })
      vim.keymap.set("n", "sc",
        ":exe 'CocList --input=' . fnamemodify(v:lua.get_vim_open_path(), ':t') . '/' . ' files'<CR>", { silent = true })
      vim.keymap.set("n", "se", ":<C-u>CocList diagnostics<CR>", { silent = true })
      vim.keymap.set("n", "sy", ":<C-u>CocList mru<CR>", { silent = true })
      vim.keymap.set("n", "sb", ":<C-u>CocList buffers<CR>", { silent = true })
      vim.keymap.set("n", "sh", ":<C-u>CocList helptags<CR>", { silent = true })
      vim.keymap.set({ "n", "i" }, "\\f",
        "<ESC>:<C-u>CocCommand tsserver.executeAutofix<CR>:<C-u>CocCommand eslint.executeAutofix<CR>", { silent = true })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "typescript,json",
        callback = function()
          vim.opt_local.formatexpr = "CocAction('formatSelected')"
        end
      })
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
      end

      _G.get_vim_open_path = function()
        return vim.fn.getcwd()
      end
    end
  },
}
