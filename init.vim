"#######################################################
"#######################################################
if !&compatible
    set nocompatible
endif

"Reset augroup
augroup My_auto
    autocmd!
    " Turn off paste mode when leaving insert
    autocmd InsertLeave * set nopaste"
    autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
    autocmd FileType sh  setlocal sw=2 sts=2 ts=2 et
augroup END

"#######################################################
"#######################################################
"When you press 3 key, execute focuesd file
map 3 [autoCompile]

nnoremap <expr><silent> [autoCompile] 
            \&filetype ==# 'c' ? ":call <SID>execute_c()\<CR>" : 
            \&filetype ==# 'python' ? ":call <SID>execute_py()\<CR>" : 
            \&filetype ==# 'java' ? ":call <SID>execute_java()\<CR>" :
            \":echo \"The filetype is not supported\"\<CR>"

function! s:execute_c()
    let path = substitute(expand('%:p'), ' ', '\\ ', "g")
    let compilePath = substitute(expand('%:h'), ' ', '\\ ', "g") .'/a.out'
    exe '!gcc' path '-o' compilePath '&&' compilePath
endfunction
function! s:execute_py()
    let path = substitute(expand('%:p'), ' ', '\\ ', "g")
    exe '!python3' path
endfunction
function! s:execute_java()
    let compilePath = substitute(expand('%:h'), ' ', '\\ ', "g")
    let filePath = substitute(expand('%:p'), ' ', '\\ ', "g")
    let executePath = fnamemodify(filePath, ":t:r")
    exe '!javac' filePath '-d' compilePath '&& java -cp' compilePath executePath
endfunction
"#######################################################
"#######################################################
"dein scripts----------
if(v:version >= 800 || has('nvim'))
    let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
    let s:dein_dir = s:cache_home . '/dein'
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif
    let &runtimepath = s:dein_repo_dir .",". &runtimepath

    " read plugin & create chache
    let s:toml_dir = fnamemodify(expand('<sfile>'), ':h').'/toml'
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
"end of dein scripts-------------
"#######################################################
"#######################################################
"common
set autoread
set hidden
set wildmenu
filetype plugin indent on
inoremap <silent> jj <ESC>
nnoremap <silent> <S-q> <Nop>

"#######################################################
"#######################################################
"buffer
nmap [Buffer] <Nop>
map <C-b> [Buffer]

nnoremap [Buffer]<C-b> :b#<CR>
nnoremap [Buffer]<C-p> :bnext<CR>
nnoremap [Buffer]<C-n> :bprev<CR>
nnoremap [Buffer]<C-d> :bd<CR>

"#######################################################
"#######################################################
"Mapping space
nmap [call] <Nop>
map <Space> [call]

"#######################################################
"#######################################################
"yank
nnoremap <silent> Y <C-v>$"xy

"#######################################################
"#######################################################
"display
language C
set fenc=utf-8
set title
set number
set backspace=indent,eol,start

set showmode
let s:color_dir = expand('~/.config/nvim/color.vim')
if filewritable(s:color_dir)
    exe 'source' s:color_dir
endif

"#######################################################
"#######################################################
"highlight color
highlight PmenuSel ctermfg=lightred ctermbg=black
highlight Pmenu ctermfg=lightblue ctermbg=black

"#######################################################
"#######################################################
"indent
set autoindent
set smartindent
set cindent
set expandtab
set tabstop=4
set shiftwidth=4
nnoremap <silent> > >>
nnoremap <silent> < <<

"#######################################################
"#######################################################
"Auto indent when pressed ==
nnoremap == gg=G''

"#######################################################
"#######################################################
"delete next space
nnoremap <silent> d<Space> df<Space>

"#######################################################
"#######################################################
"swap config
set noswapfile

"#######################################################
"#######################################################
"search config
set incsearch
set ignorecase
set hlsearch
set smartcase
nnoremap <silent> <ESC><ESC> :noh<CR>

"#######################################################
"#######################################################
"To able be undo after closed any files
if has('persistent_undo')
    set undodir=~/.config/nvim/.undo
    set undofile
endif

"#######################################################
"#######################################################
"cursor
noremap <silent> <S-j> <C-d>
noremap <silent> <S-k> <C-u> 
noremap <silent> <S-l> $
noremap <silent> <S-h> 0

"#######################################################
"#######################################################
"to able to be move when in insertmode
inoremap <silent> <C-l> <Right>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-o> <ESC>o

"#######################################################
"#######################################################
"reload init.vim
noremap <silent> 0<CR> :source ~/.nvim/init.vim<CR>

"#######################################################
"#######################################################
"Change key mapiings a,A,i,I respectively
nnoremap <silent> i a
nnoremap <silent> a i
nnoremap <silent> I A
nnoremap <silent> A I
vnoremap <silent> A I
vnoremap <silent> I A

"#######################################################
"#######################################################
"Move the cursor to the end of the line
nmap <silent> v <S-v>

"#######################################################
"#######################################################
"high light settings
nnoremap <silent> // "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
nmap # //:%s/<C-r>///g<Left><Left>

"#######################################################
"#######################################################
" move the an line
nnoremap <C-n> "zdd"zp
nnoremap <C-p> "zdd<Up>"zP
" move the multiple line
vnoremap <C-p> "zx<Up>"zP`[V`]
vnoremap <C-n> "zx"zp`[V`]

"#######################################################
"#######################################################
"specify delete register
nnoremap d "xd
nnoremap D "xD
vnoremap d "xd
nnoremap y "xy
vnoremap y "xy
nnoremap x ""x
noremap p "xp


"#######################################################
"#######################################################
inoremap , , 
inoremap ;; <ESC><S-A>;<ESC>
nnoremap ;; <ESC><S-A>;<ESC>
inoremap :: <ESC><S-A>:<ESC>

"#######################################################
"#######################################################
"Windows mapping
nmap [window] <Nop>
map <C-w> [window]
noremap <silent> [window]^ :call <SID>create_new_window()<CR><ESC>
noremap <silent> [window]h <C-w>h 
noremap <silent> [window]j <C-w>j 
noremap <silent> [window]k <C-w>k 
noremap <silent> [window]l <C-w>l 
noremap <silent> [window]w <C-w>w
noremap <silent> ^ <C-w>w
nnoremap <silent> [call]q :bp<bar>sp<bar>bn<bar>bd<CR>

function! s:create_new_window()
    "If there is a terminal buffer, create a window horizontally. If not, create a window vertically
    exe win_id2win(g:terminal_window_id) ? ':vertical resize 134 | split': ':botright vsplit'
endfunction
"#######################################################
"#######################################################
"Terminal mapping
"Set zsh on using Terminal mode
"split : vertical resize 134

if has("nvim")

    augroup terminal
        autocmd!
        "To be insert mode when move to terminal buffer
        if has('nvim')
            autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
        else
            autocmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
        endif

        autocmd BufLeave * if &buftype ==# 'terminal' | file Terminal | endif
    augroup END

    let g:terminal_window_id = winnr('$') == 1 ? 0 : bufwinid("Terminal") 

    set sh=zsh
    map <silent> 1 :call <SID>create_terminal()<CR>
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
    tmap <silent> <C-c> <ESC>:q<Cr>

    function! s:create_terminal()
        exe winnr('$') == 1 || !win_id2win(g:terminal_window_id) ? ':vert botright split': win_gotoid(g:terminal_window_id)
        let g:terminal_window_id = win_getid() "memory window id
        exe !bufexists("Terminal") ? ':terminal' : 'buffer Terminal'
        exe ':vertical resize 70 | startinsert'
    endfunction
endif

"#######################################################
"#######################################################
