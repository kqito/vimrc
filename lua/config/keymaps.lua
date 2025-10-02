---@diagnostic disable: undefined-global

-- Normal mode remaps
vim.keymap.set("n", "<S-q>", "<Nop>", { silent = true })
vim.keymap.set("n", "\\w", "<ESC>:wa<CR>", { silent = true })
vim.keymap.set("n", "<S-j>", "<C-d>", { silent = true })
vim.keymap.set("n", "<S-k>", "<C-u>", { silent = true })
vim.keymap.set("n", "<S-l>", "$", { silent = true })
vim.keymap.set("n", "<S-h>", "0", { silent = true })
vim.keymap.set("n", "g;", "g;zz", { silent = true })
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "i", "a", { silent = true })
vim.keymap.set("n", "a", "i", { silent = true })
vim.keymap.set("n", "I", "A", { silent = true })
vim.keymap.set("n", "A", "I", { silent = true })
vim.keymap.set("n", "v", "<S-v>", { silent = true })
vim.keymap.set("n", "<S-v>", "v", { silent = true })
vim.keymap.set("n", "x", "\"\"x", { silent = true })
vim.keymap.set("n", ">", ">>", { silent = true })
vim.keymap.set("n", "<", "<<", { silent = true })
vim.keymap.set("n", "<ESC><ESC>", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<C-c><C-c>", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<C-t>n", ":tabprevious<cr>", { silent = true })
vim.keymap.set("n", "<C-t>p", ":tabnext<cr>", { silent = true })
vim.keymap.set("n", "<C-t>e", ":tabnew<cr>", { silent = true })
vim.keymap.set("n", "Y", "<C-v>$y", { silent = true })
vim.keymap.set("n", "yc", function()
  local relative_path = vim.fn.expand("%")
  vim.fn.setreg("+", relative_path)
  vim.notify("Copied: " .. relative_path)
end, { desc = "Copy relative path to clipboard" })
vim.keymap.set("n", "yC", function()
  local absolute_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", absolute_path)
  vim.notify("Copied: " .. absolute_path)
end, { desc = "Copy absolute path to clipboard" })
vim.keymap.set("n", "<buffer>==", "gg=Gg;zz", { silent = true })

-- Buffer remaps
vim.keymap.set("n", "<C-b>", "<Nop>", { silent = true })
vim.keymap.set("n", "<C-b><C-b>", ":b#<CR>", { silent = true })
vim.keymap.set("n", "<C-b><C-p>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<C-b><C-n>", ":bprev<CR>", { silent = true })
vim.keymap.set("n", "<C-b><C-d>", ":bufdo bd<CR>", { silent = true })

-- Insert mode remaps
vim.keymap.set("i", "\\w", "<ESC>:wa<CR>", { silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { silent = true })
vim.keymap.set("i", "<C-h>", "<Left>", { silent = true })
vim.keymap.set("i", "<C-o>", "<ESC>o", { silent = true })
vim.keymap.set("i", "<C-p>", "<C-r>*", { silent = true })

-- Visual mode remaps
vim.keymap.set("v", ">", ">`[V`]", { silent = true })
vim.keymap.set("v", "<", "<`[V`]", { silent = true })
vim.keymap.set("v", "<S-j>", "<C-d>", { silent = true })
vim.keymap.set("v", "<S-k>", "<C-u>", { silent = true })
vim.keymap.set("v", "<S-l>", "$", { silent = true })
vim.keymap.set("v", "<S-h>", "0", { silent = true })
vim.keymap.set("v", ";", "<ESC>:", { silent = true })
vim.keymap.set("v", "/", "y/<C-R>\"", { silent = true })
vim.keymap.set("v", "A", "I", { silent = true })
vim.keymap.set("v", "I", "A", { silent = true })

-- Copy file path with line numbers in visual mode
vim.keymap.set("v", "yc", function()
  local relative_path = vim.fn.expand("%")
  
  -- Use vim.fn.line() instead of getpos() for more reliable results
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  
  -- Ensure start_line <= end_line
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  
  local result
  if start_line == end_line then
    -- Single line selected
    result = relative_path .. ":" .. start_line
  else
    -- Multiple lines selected
    result = relative_path .. ":" .. start_line .. ":" .. end_line
  end
  
  vim.fn.setreg("+", result)
  vim.notify("Copied: " .. result)
  
  -- Exit visual mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', false)
end, { desc = "Copy file path with line numbers" })

-- Copy absolute file path with line numbers in visual mode
vim.keymap.set("v", "yC", function()
  local absolute_path = vim.fn.expand("%:p")
  
  -- Use vim.fn.line() instead of getpos() for more reliable results
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  
  -- Ensure start_line <= end_line
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  
  local result
  if start_line == end_line then
    -- Single line selected
    result = absolute_path .. ":" .. start_line
  else
    -- Multiple lines selected
    result = absolute_path .. ":" .. start_line .. ":" .. end_line
  end
  
  vim.fn.setreg("+", result)
  vim.notify("Copied: " .. result)
  
  -- Exit visual mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', false)
end, { desc = "Copy absolute file path with line numbers" })

-- Highlight
function _G.highlight_word_under_cursor()
  local cw = vim.fn.expand('<cword>')
  vim.fn.setreg("z", cw)
  vim.fn.setreg("/", '\\<' .. cw .. '\\>')
  vim.opt.hlsearch = true
end

vim.keymap.set("n", "<space>h", function() _G.highlight_word_under_cursor() end, { silent = true })

-- q mapping
-- ref: https://zenn.dev/vim_jp/articles/29d021fff07e60
vim.api.nvim_create_autocmd('RecordingEnter', {
  pattern = '*',
  group = augroup_wrapper,
  callback = function()
    if vim.fn.reg_recording() ~= 'q' then
      vim.cmd('normal! q')
      return
    end

    local augroup_inner = vim.api.nvim_create_augroup('prefix-q-inner', {})

    local buffer = vim.api.nvim_get_current_buf()

    vim.keymap.set('n', 'q', 'q', { nowait = true, buffer = buffer })

    vim.api.nvim_create_autocmd({ 'BufLeave', 'WinLeave' }, {
      pattern = '*',
      once = true,
      group = augroup_inner,
      callback = function()
        vim.cmd('normal! q')
        vim.notify('stop recording', vim.log.levels.INFO)
      end,
      desc = 'stop recording when leaving buffer',
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
      pattern = '*',
      once = true,
      callback = function()
        vim.keymap.del('n', 'q', { buffer = buffer })
        vim.api.nvim_del_augroup_by_id(augroup_inner)
      end,
      desc = 'delete q mapping when recording leave',
    })
  end,
})

-- マクロ記録開始
vim.keymap.set('n', 'qq', 'qq', { desc = 'start recording' })

-- 直前のバッファに切り替え
vim.keymap.set('n', 'qt', '<c-^>', { desc = 'toggle buffer' })
