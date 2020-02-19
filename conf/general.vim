" ===== General settings =====
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

" ===== For dispaly true color on tmux =====
set termguicolors

" ===== Dispaly gui color on tmux =====
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  syntax on
  set termguicolors
endif

" ===== Around the swap settings =====
set noswapfile

" ===== Allow to undo after even closed any files =====
if has('persistent_undo')
    set undodir=~/.config/nvim/.undo
    set undofile
endif

" ===== Move cursor settings =====
noremap <silent> <S-j> <C-d>
noremap <silent> <S-k> <C-u>
noremap <silent> <S-l> $
noremap <silent> <S-h> 0
noremap <silent> g; g;zz

" ===== Insert settings =====
inoremap <silent> <C-l> <Right>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-o> <ESC>o

" ===== Change key mapiings a,A,i,I respectively =====
nnoremap <silent> i a
nnoremap <silent> a i
nnoremap <silent> I A
nnoremap <silent> A I
vnoremap <silent> A I
vnoremap <silent> I A

" ===== Move the cursor to the end of the line =====
nmap <silent> v <S-v>

" ===== Replacement settings =====
noremap <silent> <space>r <Nop>
map <space>r [Replace]
nmap [Replace] <Nop>

nnoremap <silent> <space>h "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

nmap [Replace]w <space>h:%s//g<Left><Left><C-r>"/
nmap [Replace]p <space>h:%s//g<Left><Left>
vmap [Replace]w <ESC><space>h:let @a = getpos("'<")[1]<CR>:let @b = getpos("'>")[1]<CR>:<C-r>a,<C-r>bs//g<Left><Left><C-r>"/
vmap [Replace]p <ESC><space>h:let @a = getpos("'<")[1]<CR>:let @b = getpos("'>")[1]<CR>:<C-r>a,<C-r>bs//g<Left><Left>

" ===== Settings to swap rows =====
nnoremap <C-n> "zdd"zp
nnoremap <C-p> "zdd<Up>"zP
vnoremap <C-p> "zx<Up>"zP`[V`]
vnoremap <C-n> "zx"zp`[V`]

" ===== The delete register settings =====
nnoremap d "xd
nnoremap D "xD
vnoremap d "xd
nnoremap y "xy
vnoremap y "xy
nnoremap x ""x
noremap p "xp

" ===== Allow to use of mouse settings =====
if has('mouse')
	set mouse=
	nnoremap <silent> <space>m :call <SID>toggle_mouse()<CR>
else
	nnoremap <silent> <space>m :echo 'Mouse function is not enabled'<CR>
endif

if !has('nvim')
    set ttymouse=sgr
endif

function! s:toggle_mouse()
    if &mouse !=# 'a'
		set mouse=a
		echo 'Mouse function is enabled'
    else
		set mouse=
		echo 'Mouse function is disabled'
    endif
endfunction

" ===== Around the coding style setting =====
inoremap ,, <ESC>:%s/\s\+$//e<CR><S-A>,<ESC>
nnoremap ,, <ESC>:%s/\s\+$//e<CR><S-A>,<ESC>
inoremap ;; <ESC><S-A>;<ESC>
nnoremap ;; <ESC><S-A>;<ESC>
