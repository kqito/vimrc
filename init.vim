"#######################################################
"#######################################################
if !&compatible
    set nocompatible
endif

"Reset augroup
augroup auto_insert
    autocmd!
    " Turn off paste mode when leaving insert
    autocmd InsertLeave * set nopaste"

    "To be insert mode when move to terminal buffer
    if has('nvim')
        autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
    else
        autocmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
    endif
augroup END
"#######################################################
"#######################################################
augroup ftindent
    autocmd!
    "Auto set indent spaces
    if has("autocmd")
        filetype plugin indent on
        "ts = tabstop
        "sts = softtabstop
        "sw = shiftwidth
        autocmd FileType vim         setlocal sw=4 sts=4 ts=4 et
        autocmd FileType conf         setlocal sw=4 sts=4 ts=4 et
        autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
        autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
        autocmd FileType ruby        setlocal sw=4 sts=4 ts=4 et
        autocmd FileType js          setlocal sw=4 sts=4 ts=4 et
        autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
        autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
        autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
        autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
        autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
        autocmd FileType javascript  setlocal sw=4 sts=4 ts=4 et
        autocmd FileType sh  setlocal sw=2 sts=2 ts=2 et
    endif
augroup END

"#######################################################
"#######################################################
"When you press 3 key, execute focuesd file
map 3 [autoCompile]

nnoremap <silent> [autoCompile] :call <SID>execute_compile()<CR>

function! s:execute_compile()
    if &filetype == 'c'
        call <SID>execute_c()
    elseif &filetype == 'python'
        call <SID>execute_py()
    elseif &filetype == 'java'
        call <SID>execute_java()
    endif
endfunction

function! s:execute_c()
    let path = substitute(expand('%:p'), ' ', '\\ ', "g")
    let compilePath = substitute(expand('%:h'), ' ', '\\ ', "g") .'/a.out'
    let catPath = substitute(expand('%:h'), ' ', '\\ ', "g") .'/word.txt'
    exe '!gcc' path '-o' compilePath '&&' compilePath
endfunction
function! s:execute_py()
    let path = substitute(expand('%:p'), ' ', '\\ ', "g")
    echo path
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
    let s:dein_file = fnamemodify(expand('<sfile>'), ':h').'/toml/dein.toml'
    let s:dein_lazy_file = fnamemodify(expand('<sfile>'), ':h').'/toml/dein_lazy.toml'
    let s:visual_file = fnamemodify(expand('<sfile>'), ':h').'/toml/visual.toml'
    if dein#load_state(s:dein_dir)
        call dein#begin(s:dein_dir)
        call dein#load_toml(s:dein_file, {'lazy': 0})
        call dein#load_toml(s:visual_file, {'lazy': 0})
        call dein#load_toml(s:dein_lazy_file, {'lazy': 1})
        call dein#end()
        call dein#save_state()
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
inoremap <silent> jj <ESC>
inoremap <silent> ll <ESC>A
nnoremap <silent> <S-q> <Nop>

"#######################################################
"#######################################################
"buffer
nmap [Buffer] <Nop>
map b [Buffer]

nnoremap [Buffer]b :b#<CR>
nnoremap [Buffer]p :bnext<CR>
nnoremap [Buffer]n :bprev<CR>

"#######################################################
"#######################################################
"Mapping space
nmap [call] <Nop>
map <Space> [call]

"#######################################################
"#######################################################
"yank
set clipboard+=unnamed
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
noremap <silent> W B

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
    if has("nvim")
        "If there is a terminal buffer, create a window horizontally. If not, create a window vertically
        if win_id2win(g:terminal_window_id) "if no have Terminal's window
            exe ':leftabove split'
            let s:current_window = win_getid()
            let s:result = win_gotoid(g:terminal_window_id) "move to specified window
            exe ':vertical resize ' g:terminal_window_size
            let s:result = win_gotoid(s:current_window) "move to current window
        else
            exe ':botright vsplit'
        endif
    else
        "If it is vim, create a window vertically
        exe ':botright vsplit'
    endif
    endfunction
    "#######################################################
    "#######################################################
    "Terminal mapping
    "Set zsh on using Terminal mode


    if has("nvim")
        let g:terminal_window_id = 0
        let g:terminal_window_size = 70

        set sh=zsh
        map <silent> 1 :call <SID>create_terminal()<CR>
        tnoremap <silent> <C-w>w <C-\><C-n><C-w>w<C-w><
        tnoremap <silent> ^ <C-\><C-n><C-w>w
        tnoremap <silent> <ESC> <C-\><C-n>
        tmap <silent> <C-c> <ESC>:q<Cr>

        function! s:create_terminal()
            if !win_id2win(g:terminal_window_id) "if no have Terminal's window
                exe ':vert botright ' g:terminal_window_size 'split'
                let g:terminal_window_id = win_getid()
            else "if you have it, 
                let s:result = win_gotoid(g:terminal_window_id) "move to specified window
                exe ':vertical resize ' g:terminal_window_size
            endif

            if !bufexists("Terminal") "if no have Terminal buffer
                exe ':terminal'
                exe ':file Terminal'
            else
                exe 'buffer Terminal'
            endif

            exe 'startinsert'
        endfunction
    endif

    "#######################################################
    "#######################################################
    "Map
    noremap m 'm
    noremap M mm
