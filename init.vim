"#######################################################
" Autocmd settings
"#######################################################

filetype plugin indent on

if !&compatible
  set nocompatible
endif

"Reset augroup
augroup My_auto
  autocmd!
  " Turn off paste mode when leaving insert
  autocmd InsertLeave * set nopaste"

  " Move the cursor to previous position when a file is opened
  autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

  " Set indent space
  autocmd FileType *  setlocal sw=2 sts=2 ts=2 et

  " Open a help text vertically
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif

  " Remove space or tab at End of line
  autocmd BufWritePre * :%s/\s\+$//e

  " At last ,highlight settings
  autocmd VimEnter,ColorScheme * highlight PmenuSel ctermfg=magenta ctermbg=white
  autocmd VimEnter,ColorScheme * highlight Pmenu ctermfg=lightblue ctermbg=white
augroup END

"#######################################################
" Run a program on vim
"#######################################################
" When you press 3 key, run focuesd file
map [call]@ [autoCompile]

nnoremap <expr><silent> [autoCompile]
  \&filetype ==# 'c' ? ":call <SID>run_c()\<CR>" :
  \&filetype ==# 'python' ? ":call <SID>run_py()\<CR>" :
  \&filetype ==# 'java' ? ":call <SID>run_java()\<CR>" :
  \":echo \"The filetype is not supported\"\<CR>"

function! s:run_c()
  let path = substitute(expand('%:p'), ' ', '\\ ', "g")
  let compilePath = substitute(expand('%:h'), ' ', '\\ ', "g") .'/a.out'
  exe '!gcc' path '-o' compilePath '&&' compilePath
endfunction

function! s:run_py()
  let path = substitute(expand('%:p'), ' ', '\\ ', "g")
  exe '!python3' path
endfunction

function! s:run_java()
  let compilePath = substitute(expand('%:h'), ' ', '\\ ', "g")
  let filePath = substitute(expand('%:p'), ' ', '\\ ', "g")
  let runPath = fnamemodify(filePath, ":t:r")
  exe '!javac' filePath '-d' compilePath '&& java -cp' compilePath runPath
endfunction

"#######################################################
" Dein Scripts
"#######################################################

fun! s:callPlugins()
	if(v:version >= 800 || has('nvim'))
		let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
		let s:dein_dir = s:cache_home . '/dein'
		let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
		if !isdirectory(s:dein_repo_dir)
			call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
		endif
		let &runtimepath = s:dein_repo_dir .",". &runtimepath

		" read plugin & create chache
		let s:toml_dir = expand('~/.config/nvim/toml')
		let s:dein_file = s:toml_dir.'/dein.toml'
		let s:dein_lazy_file = s:toml_dir.'/dein_lazy.toml'
		let s:visual_file = s:toml_dir.'/visual.toml'
		if dein#load_state(s:dein_dir)
			call dein#begin(s:dein_dir)
			call dein#load_toml(s:dein_file, {'lazy': 0})
			call dein#load_toml(s:visual_file, {'lazy': 0})
			call dein#load_toml(s:dein_lazy_file, {'lazy': 1})
			call dein#end()
			call dein#save_state()
		endif

		if !has('nvim')
			call dein#add('roxma/nvim-yarp')
			call dein#add('roxma/vim-hug-neovim-rpc')
		endif

		"install plugins when no install them
		if has('vim_starting') && dein#check_install()
			call dein#install()
		endif
	endif
endfun

call s:callPlugins()
nnoremap <silent> [call]0d :call <SID>callPlugins()<CR>

"#######################################################
" Basic settings
"#######################################################
set autoread
set hidden
set wildmenu
filetype plugin indent on
inoremap <silent> jj <ESC>
nnoremap <silent> <S-q> <Nop>
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis
scriptencoding utf-8
set encoding=utf-8

" For US keyboard
nnoremap ; :
nnoremap ; :
"#######################################################;
" Buffer settings
"#######################################################
nmap [Buffer] <Nop>
map <C-b> [Buffer]

nnoremap [Buffer]<C-b> :b#<CR>
nnoremap [Buffer]<C-p> :bnext<CR>
nnoremap [Buffer]<C-n> :bprev<CR>
nnoremap [Buffer]<C-d> :bp<bar>sp<bar>bn<bar>bd<CR>

"#######################################################
" Mapping space
"#######################################################
nmap [call] <Nop>
map <Space> [call]

"#######################################################
" Yank Settings
"#######################################################
nnoremap <silent> Y <C-v>$"xy
vnoremap <silent> [call]y "+y
nnoremap <silent> [call]y "+y

"#######################################################
" Display settings
"#######################################################
language C
set title
set number
set backspace=indent,eol,start

set synmaxcol=200
set t_Co=256

let s:color_dir = expand('~/.config/nvim/color.vim')
if filewritable(s:color_dir)
  "if you have your colorscheme file
  exe 'source' s:color_dir
else
  set background=dark
  colorscheme lucius
endif

"#######################################################
" Indent settings
"#######################################################
set autoindent
set cindent
set nosmarttab
set expandtab
nnoremap <silent> > >>
nnoremap <silent> < <<
vnoremap > >`[V`]
vnoremap < <`[V`]

"#######################################################
" Clean all indents
"#######################################################
augroup IndentGroup
  autocmd!
  " Set indent space
  autocmd BufEnter * nnoremap <silent> <buffer> == gg=Gg;zz
  autocmd BufEnter *.vue nnoremap <silent> <buffer> == /<\/template><CR>:noh<CR><Down><S-v>G=Gg;zz
augroup END

"#######################################################
" Around the swap settings
"#######################################################
set noswapfile

"#######################################################
" Search settings
"#######################################################
set incsearch
set ignorecase
set hlsearch
set smartcase
nnoremap <silent> <ESC><ESC> :noh<CR>

"#######################################################
" Allow to undo after even closed any files
"#######################################################
if has('persistent_undo')
    set undodir=~/.config/nvim/.undo
    set undofile
endif

"#######################################################
" Move cursor settings
"#######################################################
noremap <silent> <S-j> <C-d>
noremap <silent> <S-k> <C-u>
noremap <silent> <S-l> $
noremap <silent> <S-h> 0
noremap <silent> g; g;zz
noremap <silent> ! %
"#######################################################
" Allow to move the cursor when insert mode
"#######################################################
inoremap <silent> <C-l> <Right>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-o> <ESC>o

"#######################################################
" Reload settings
"#######################################################
noremap [call]0i :source ~/.nvim/init.vim<CR>

"#######################################################
" Change key mapiings a,A,i,I respectively
"#######################################################
nnoremap <silent> i a
nnoremap <silent> a i
nnoremap <silent> I A
nnoremap <silent> A I
vnoremap <silent> A I
vnoremap <silent> I A

"#######################################################
" Move the cursor to the end of the line
"#######################################################
nmap <silent> v <S-v>

"#######################################################
" Tmux settings
"#######################################################
noremap <silent> <C-t> <Nop>
"
"#######################################################
" Replacement settings
"#######################################################
nnoremap <silent> [call]h "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
nmap # [call]h:%s//g<Left><Left><C-r>"/
nmap $ [call]h:%s//g<Left><Left>
vmap # <ESC>[call]h:let @a = getpos("'<")[1]<CR>:let @b = getpos("'>")[1]<CR>:<C-r>a,<C-r>bs//g<Left><Left><C-r>"/
vmap $ <ESC>[call]h:let @a = getpos("'<")[1]<CR>:let @b = getpos("'>")[1]<CR>:<C-r>a,<C-r>bs//g<Left><Left>

"#######################################################
" Settings to swap rows
"#######################################################
nnoremap <C-n> "zdd"zp
nnoremap <C-p> "zdd<Up>"zP
vnoremap <C-p> "zx<Up>"zP`[V`]
vnoremap <C-n> "zx"zp`[V`]

"#######################################################
" The delete register settings
"#######################################################
nnoremap d "xd
nnoremap D "xD
vnoremap d "xd
nnoremap y "xy
vnoremap y "xy
nnoremap x ""x
noremap p "xp

"#######################################################
" Allow to use of mouse settings
"#######################################################
if has('mouse')
	set mouse=a
	nnoremap <silent> [call]m :call <SID>toggle_mouse()<CR>
else
	nnoremap <silent> [call]m :echo 'Mouse function is not enabled'<CR>
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

"#######################################################
" Around the coding style setting
"#######################################################
inoremap ,, <ESC>:%s/\s\+$//e<CR><S-A>,<ESC>
nnoremap ,, <ESC>:%s/\s\+$//e<CR><S-A>,<ESC>
inoremap ;; <ESC><S-A>;<ESC>
nnoremap ;; <ESC><S-A>;<ESC>

"#######################################################
" Windows settings
"#######################################################
nmap [window] <Nop>
map <C-w> [window]
noremap <silent> [window]v :call <SID>create_new_window()<CR><ESC>
noremap <silent> [window]h <C-w>h
noremap <silent> [window]j <C-w>j
noremap <silent> [window]k <C-w>k
noremap <silent> [window]l <C-w>l
noremap <silent> [window]w <C-w>w
noremap <silent> ` <C-w>w

function! s:create_new_window()
    " If there is a terminal buffer, create a window horizontally. If not, create a window vertically
    exe win_id2win(g:terminal_window_id) ? ':vertical resize 134 | split': ':botright vsplit'
endfunction

"#######################################################
" Terminal settings
"#######################################################
if(v:version >= 800 || has('nvim'))
    augroup terminal
        autocmd!
        "To be insert mode when move to terminal buffer
        if has('nvim')
            autocmd BufEnter * if &buftype ==# 'terminal' | startinsert | endif
        else
            autocmd BufEnter * if &buftype ==# 'terminal' | normal i | endif
        endif

        autocmd BufLeave * if &buftype ==# 'terminal' | file Terminal | endif
    augroup END

    let g:terminal_window_id = winnr('$') == 1 ? 0 : bufwinid("Terminal")

    set sh=zsh
    map <silent> [call]1 :call <SID>create_terminal()<CR>
    tmap [window] <Nop>
    tmap <C-w> [window]
    tnoremap <silent> [window]w <C-\><C-n><C-w>w
    tnoremap <silent> [window]h <C-\><C-n><C-w>h
    tnoremap <silent> [window]j <C-\><C-n><C-w>j
    tnoremap <silent> [window]k <C-\><C-n><C-w>k
    tnoremap <silent> [window]l <C-\><C-n><C-w>l
    tnoremap <silent> [window]w <C-\><C-n><C-w>w
    tnoremap <silent> ^ <C-\><C-n><C-w>w
    tnoremap <silent> <ESC> <C-\><C-n>
    tmap <silent> <C-x> <ESC>:q<Cr>
    "Buffer
    tmap [Buffer] <Nop>
    tmap <C-b> [Buffer]
    tmap [Buffer]<C-b> <ESC>:b#<CR>
    tmap [Buffer]<C-p> <ESC>:bnext<CR>
    tmap [Buffer]<C-n> <ESC>:bprev<CR>
    tmap [Buffer]<C-d> <ESC>:bp<bar>sp<bar>bn<bar>bd<CR>

    function! s:create_terminal()
        exe winnr('$') == 1 || !win_id2win(g:terminal_window_id) ? ':vert botright split': win_gotoid(g:terminal_window_id)
        let g:terminal_window_id = win_getid() "memory window id
        exe !bufexists("Terminal") ? ':terminal' : 'buffer Terminal'
        exe ':vertical resize 70 | startinsert'
    endfunction
endif

"#######################################################
" Tmux settings
"#######################################################
nmap [Tmux] <Nop>
map <C-t> [Tmux]

nnoremap <silent> [Tmux]p <C-w>l
nnoremap <silent> [Tmux]n <C-w>h
