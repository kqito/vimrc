vnoremap ; <ESC>:
vnoremap / <ESC>/
nnoremap <silent> <S-q> <Nop>
cnoremap Q q!

" ===== Buffer settings =====
nmap [Buffer] <Nop>
map <C-b> [Buffer]

nnoremap [Buffer]<C-b> :b#<CR>
nnoremap [Buffer]<C-p> :bnext<CR>
nnoremap [Buffer]<C-n> :bprev<CR>
nnoremap [Buffer]<C-d> :bufdo bd<CR>
nnoremap -- :bufdo bd<CR>

" ===== Yank Settings =====
nnoremap <silent> Y <C-v>$"xy
vnoremap <silent> <C-y> "+y
nnoremap <silent> <C-y> "+y

" ===== Cursor settings =====
set cursorline
autocmd VimEnter,ColorScheme * highlight CursorLine guifg=NONE

" ===== Indent settings =====
set autoindent
set cindent
set nosmarttab
set expandtab
nnoremap <silent> > >>
nnoremap <silent> < <<
vnoremap > >`[V`]
vnoremap < <`[V`]
nnoremap <silent> <buffer> == gg=Gg;zz

" ===== Search settings =====
set incsearch
set ignorecase
set hlsearch
set smartcase
nnoremap <silent> <ESC><ESC> :noh<CR>
nnoremap <silent> <C-c><C-c> :noh<CR>


