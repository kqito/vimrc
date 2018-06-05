if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
  " Turn off paste mode when leaving insert
  autocmd InsertLeave * set nopaste"

  "autocmd config
  if has('nvim')
    autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
  else
    autocmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
  endif

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

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
"end of dein scripts------------------------

"change the jolorcheme
syntax on
colorscheme antares
set t_Co=256

"configuring display
language C
set title
set number
set modifiable
set tabstop=2
set shiftwidth=2
set shiftwidth=2
set backspace=indent,eol,start
set showmode
set autoindent
set smartindent
set cindent
set smarttab
set expandtab
"swap configuring"
set noswapfile
"search config
set incsearch
set ignorecase
set hlsearch
set smartcase

if has('persistent_undo')
  set undodir=~/.config/nvim/.undo
  set undofile
endif

inoremap <silent> jj <ESC>
noremap <silent> 123 :<C-u>source ~/.nvim/init.vim<CR>
let mapleader = "\<Space>"
inoremap <silent> <C-i> <ESC>i
inoremap <silent> <C-o> <ESC>o
nnoremap <silent> i a
nnoremap <silent> a i
nnoremap <silent> I A
nnoremap <silent> A I
vnoremap <silent> A I
vnoremap <silent> I A
noremap <S-k> $
noremap <S-j> 0
nnoremap == gg=G''
noremap <silent> :b :<C-u>bd<CR>

"windows mapping
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

"terminal mapping
"set zsh on using terminalmode
set sh=zsh
noremap <silent> ex :<C-u>sp<CR><C-w>j:<C-u>terminal<CR>i
noremap  <silent> <C-l> <ESC>:call <SID>ChangeDirectory()<CR><ESC>:call <SID>Exec("hello")<CR>
tnoremap <silent> <C-w>w <C-\><C-n><C-w>w
tnoremap <silent> <ESC> <C-\><C-n>

function! s:ChangeDirectory()
  let dir = expand("%:p")
  split
  exe "normal \<C-w>j"
  terminal
  startinsert
endfunction

funct! s:Exec(command)
  redir =>output
  silent exe a:command
  redir END
  ""    return output
endfunct!

"map mapping
noremap M '

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

"coding mapping
inoremap { {}<Left>
inoremap {<CR> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap [ []<ESC>i
inoremap <silent> <C-j> <ESC>o
inoremap <silent> <C-k> <ESC>O
inoremap <silent> <C-h><<C-h> <ESC>:call <SID>ReachToSingle()<CR>
nnoremap <silent> <C-h><<C-h> <ESC>:call <SID>ReachToSingle()<CR>
inoremap <silent> <C-h> <Right>

"End of sentence
nnoremap ;; <ESC><S-A>;<ESC>
inoremap ;; <ESC><S-A>;
inoremap :: <ESC><S-A>:<ESC><S-a>
inoremap {{ <ESC><S-A>{}<Left>
inoremap {{<CR> <ESC><S-A>{}<Left><CR><ESC><S-o>
inoremap >> <ESC><S-A>><ESC>

