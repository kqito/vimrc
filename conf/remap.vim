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

" ===== Centering cursor after jump =====
nnoremap n nzz
nnoremap N Nzz

" ===== Insert settings =====
inoremap <silent> <C-l> <Right>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-o> <ESC>o
inoremap <silent> <C-p> <C-r>*

" ===== Change key mapiings a,A,i,I respectively =====
nnoremap <silent> i a
nnoremap <silent> a i
nnoremap <silent> I A
nnoremap <silent> A I
vnoremap <silent> A I
vnoremap <silent> I A

" ===== Move the cursor to the end of the line =====
nnoremap <silent> v <S-v>
nnoremap <silent> <S-v> v

" ===== Replacement settings =====

nnoremap <silent> <space>h "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

" ===== Clipboard settings =====
set clipboard+=unnamed

" Ignore x map
nnoremap x ""x

" No longer used registers
" nnoremap d "xd
" nnoremap D "xD
" vnoremap d "xd
" nnoremap y "xy
" vnoremap y "xy
" noremap p "xp

" ===== Allow to use of mouse settings =====
if has('mouse')
	set mouse=a
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

" ===== Yank Settings =====
nnoremap <silent> Y <C-v>$y

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

" ===== tab settings =====
nnoremap <silent> <C-t>n :tabprevious<cr>
nnoremap <silent> <C-t>p :tabnext<cr>
nnoremap <silent> <C-t>e :tabnew<cr>
