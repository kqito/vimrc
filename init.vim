if !&compatible
  set nocompatible
endif

"Reset augroup
augroup MyAutoCmd
  autocmd!
  " Turn off paste mode when leaving insert
  autocmd InsertLeave * set nopaste"

	"To be insert mode when move to terminal buffer
  if has('nvim')
    autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
  else
    autocmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
  endif

	"Auto set indent spaces
  if has("autocmd")
    filetype plugin on
    filetype indent on
    autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
    autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType js          setlocal sw=4 sts=4 ts=4 et
    autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
    autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
    autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
    autocmd FileType javascript  setlocal sw=4 sts=4 ts=4 et
  endif
augroup END

"Save the file that open buffer when leave insert mode
augroup Vimrc
  autocmd!
  autocmd InsertLeave * call <SID>auto_save()
  function! s:auto_save()
    if filewritable(expand('%'))
      write
    endif
  endfunction
augroup END

"dein scripts----------
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" read plugin & create chache
let s:dein_file = fnamemodify(expand('<sfile>'), ':h').'/toml/dein.toml'
let s:lazy_file = fnamemodify(expand('<sfile>'), ':h').'/toml/dein_lazy.toml'
let s:visual_file = fnamemodify(expand('<sfile>'), ':h').'/toml/visual.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:dein_file)
  call dein#load_toml(s:lazy_file)
  call dein#load_toml(s:visual_file)
  call dein#end()
  call dein#save_state()
endif

"install plugins when no install them
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
"end of dein scripts-------------

"common
set autoread
set hidden
inoremap <silent> jj <ESC>

"display
language C
set fenc=utf-8
set title
set number
set backspace=indent,eol,start
set showmode
let s:color_dir = expand('~/.config/nvim/.color.vim')
exe 'source' s:color_dir

"indent
set autoindent
set smartindent
set cindent
"Auto indent when pressed ==
nnoremap == gg=G''

"tab
set tabstop=2
set shiftwidth=2
set softtabstop=0
set noexpandtab

"swap config
set noswapfile

"search config
set incsearch
set ignorecase
set hlsearch
set smartcase
nnoremap <silent> <ESC><ESC> :noh<CR>

"To able be undo after closed any files
if has('persistent_undo')
  set undodir=~/.config/nvim/.undo
  set undofile
endif

"cursor
noremap <S-l> $
noremap <S-h> 0
inoremap <silent> <C-j> <ESC>o
inoremap <silent> <C-k> <ESC>O
inoremap <silent> <C-h> <Right>
"Move cursor to end of bracket
inoremap <silent> <C-h><C-h> <ESC>:call <SID>ReachToSingle()<CR>
nnoremap <silent> <C-h><C-h> <ESC>:call <SID>ReachToSingle()<CR>

"Map reload init.vim
noremap <silent> 123 :<C-u>source ~/.nvim/init.vim<CR>

"Change key mapiings a,A,i,I respectively
nnoremap <silent> i a
nnoremap <silent> a i
nnoremap <silent> I A
nnoremap <silent> A I
vnoremap <silent> A I
vnoremap <silent> I A

"coding mapping
inoremap { {}<Left>
inoremap {<CR> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap [ []<ESC>i
nnoremap ;; <ESC><S-A>;<ESC>
inoremap ;; <ESC><S-A>;<ESC>
inoremap :: <ESC><S-A>:<ESC><S-a>
inoremap {{ <ESC><S-A>{}<Left>
inoremap {{<CR> <ESC><S-A>{}<Left><CR><ESC><S-o>
inoremap >> <ESC><S-A>><ESC>

"Close opening buffer
noremap <silent> :b :<C-u>bd<CR>

"Windows mapping
nmap [window] <Nop>
map <C-w> [window]
noremap <silent> [window]^ :<C-u>sp<CR>
noremap <silent> [window]~ :<C-u>vs<CR>
noremap <silent> [window]h <C-w>h 
noremap <silent> [window]j <C-w>j 
noremap <silent> [window]k <C-w>k 
noremap <silent> [window]l <C-w>l 
noremap <silent> [window]w <C-w>w
noremap <silent> [window]H <C-w>H 
noremap <silent> [window]J <C-w>J 
noremap <silent> [window]K <C-w>K 
noremap <silent> [window]L <C-w>L 

"Terminal mapping
"Set zsh on using Terminal mode
set sh=zsh
noremap <silent> ex :<C-u>sp<CR><C-w>j:<C-u>terminal<CR>i
tnoremap <silent> <C-w>w <C-\><C-n><C-w>w
tnoremap <silent> <ESC> <C-\><C-n>

"Map
noremap M '

"Move cursor to " or '
function! s:ReachToSingle()
  let cursor = col('.')
  let diff = len(getline('.')) - cursor + 1
  if s:checkStr(getline('.'), "\'") || s:checkStr(getline('.'), "\"")
    for i in range(diff)
      if i == 0 
        continue 
      endif
      exe "normal! \<Right>"
      if matchstr(getline('.'), '.', cursor - 1 + i) == "\'"  ||  
            \ matchstr(getline('.'), '.', cursor - 1 + i) == "\"" 
        if len(getline('.')) - col('.') == 0
          startinsert!
        else
          startinsert!
          exe "normal! \<Right>"
        endif
        break
      endif
    endfor
  else
    echo "That word does not exist in this line"
  endif
endfunction

"Move cursor to )
function! s:ReachToBracket()
  let cursor = col('.')
  let diff = len(getline('.')) - cursor + 1
  if s:checkStr(getline('.'), "\)")
    for i in range(diff)
      if i == 0
        continue
      endif
      exe "normal! \<Right>"
      if matchstr(getline('.'), '.', cursor - 1 + i) == "\)"
        if len(getline('.')) - col('.') == 0
          exe "startinsert!"
        else
          exe "startinsert"
          exe "normal! \<Right>"
        endif
        break
      endif
    endfor
  else
    echo "That word does not exist in this line"
  endif
endfunction

"Check if there is a target char
function! s:checkStr(str, check)
  for i in range(len(a:str))
    if i == 0 
      continue 
    endif
    if matchstr(a:str, '.', i) == a:check
      return 1
    endif
  endfor
  return 0
endfunction
