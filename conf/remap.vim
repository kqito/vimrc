vnoremap ; <ESC>:
vnoremap / <ESC>/
nnoremap <silent> <S-q> <Nop>
cnoremap Q q!

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
nmap [Replace]a <space>h:%s//g<Left><Left>
vmap [Replace]w <ESC><space>h:let @a = getpos("'<")[1]<CR>:let @b = getpos("'>")[1]<CR>:<C-r>a,<C-r>bs//g<Left><Left><C-r>"/
vmap [Replace]a <ESC><space>h:let @a = getpos("'<")[1]<CR>:let @b = getpos("'>")[1]<CR>:<C-r>a,<C-r>bs//g<Left><Left>

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


