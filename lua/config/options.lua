---@diagnostic disable: undefined-global

-- General settings
vim.opt.filetype = "on"
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.wildmenu = true
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8"
vim.opt.fileformats = "unix,dos,mac"
vim.opt.title = true
vim.opt.number = true
vim.opt.backspace = "indent,eol,start"
vim.opt.synmaxcol = 200
vim.opt.redrawtime = 10000
vim.opt.compatible = false -- nocompatible -> compatible = false
vim.opt.swapfile = false   -- noswapfile -> swapfile = false
vim.opt.shiftwidth = 2     -- sw -> shiftwidth
vim.opt.softtabstop = 2    -- sts -> softtabstop
vim.opt.tabstop = 2        -- ts -> tabstop
vim.opt.expandtab = true   -- et -> expandtab
vim.opt.tabpagemax = 500
vim.g.mapleader = " "

-- GUI colors in tmux
-- vim.opt.termguicolors = true
-- if vim.fn.has("termguicolors") == 1 then
--   vim.opt.t_8f = [[<Esc>[38;2;%lu;%lu;%lum]]
--   vim.opt.t_8b = [[<Esc>[48;2;%lu;%lu;%lum]]
--   vim.opt.termguicolors = true
-- end

-- Persistent undo
if vim.fn.has("persistent_undo") == 1 then
  vim.opt.undodir = vim.fn.expand("~/.config/nvim/.undo")
  vim.opt.undofile = true
end

-- Indent settings
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.smarttab = false -- nosmarttab -> smarttab = false
vim.opt.expandtab = true

-- Search settings
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.smartcase = true

-- Clipboard settings
vim.opt.clipboard:append "unnamed"

-- Cursor settings
vim.opt.cursorline = true

-- Mouse settings
if vim.fn.has("mouse") == 1 then
  vim.opt.mouse = "a"
else
  vim.keymap.set("n", "<space>M", function()
    vim.notify("Mouse function is not enabled", vim.log.levels.INFO) -- echo -> vim.notify
  end, { silent = true })
end

if vim.fn.has("nvim") == 0 then
  vim.opt.ttymouse = "sgr"
end

-- Autocmds
vim.api.nvim_create_augroup("general", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  group = "general",
  callback = function()
    vim.opt.paste = false
  end,
})
vim.api.nvim_create_autocmd("BufRead", {
  group = "general",
  callback = function()
    if vim.fn.line("''") > 0 and vim.fn.line("''") <= vim.fn.line("$") then
      vim.cmd("normal! g``") -- normal -> normal!
    end
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = "general",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = "general",
  pattern = "*.txt",
  callback = function()
    if vim.bo.buftype == "help" then
      vim.cmd("wincmd L")
    end
  end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "general",
  callback = function()
    vim.cmd("%s/\\s\\+$//e")
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "FocusGained", "BufEnter" }, {
  group = "general",
  callback = function()
    if vim.fn.mode() ~= "c" and vim.bo.filetype ~= "vim" then
      vim.cmd("checktime")
    end
  end,
})

-- Go settings
vim.api.nvim_create_augroup("go", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "go",
  pattern = "go",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.noexpandtab = false -- noet -> noexpandtab = false
  end,
})
