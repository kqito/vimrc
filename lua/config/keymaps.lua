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

-- Highlight
function _G.highlight_word_under_cursor()
  local cw = vim.fn.expand('<cword>')
  vim.fn.setreg("z", cw)
  vim.fn.setreg("/", '\\<' .. cw .. '\\>')
  vim.opt.hlsearch = true
end

vim.keymap.set("n", "<space>h", function() _G.highlight_word_under_cursor() end, { silent = true })
