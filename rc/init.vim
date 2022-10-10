filetype plugin indent on
set autoread
set hidden
set wildmenu
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set title
set number
set backspace=indent,eol,start
set synmaxcol=200
set redrawtime=10000
set nocompatible
set noswapfile
set sw=2 sts=2 ts=2 et
set updatetime=300
set signcolumn=yes
set cmdheight=2
set nobackup
set nowritebackup
set shortmess+=c

let mapleader = "\<Space>"

" ===== Display gui color on tmux =====
set termguicolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" ===== Allow to undo after even closed any files =====
if has('persistent_undo')
    set undodir=~/.config/nvim/.undo
    set undofile
endif

exe 'source ' . g:rc_root_path . '/rc/autocmd.vim'
exe 'source ' . g:rc_root_path . '/rc/command.vim'
exe 'source ' . g:rc_root_path . '/rc/remap.vim'
exe 'source ' . g:rc_root_path . '/dein/init.vim'