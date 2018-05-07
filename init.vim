"about hook_* : https://qiita.com/delphinus/items/cd221a450fd23506e81a

"about toml_sample : https://qiita.com/kawaz/items/ee725f6214f91337b42b
if !&compatible
set nocompatible
endif

" reset augroup
augroup MyAutoCmd
autocmd!
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
				let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
				if dein#load_state(s:dein_dir)
				call dein#begin(s:dein_dir)
				call dein#load_toml(s:toml_file)
				call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>', 'noremap')
				call dein#end()
				call dein#save_state()
				endif

				if has('vim_starting') && dein#check_install()
				call dein#install()
				endif
				"end of dein scripts------------------------

				"change the colorcheme
				syntax on
				colorscheme iceberg
				set t_Co=256

				"configuring display
				language C
				set title
				set number
				set tabstop=2
				set backspace=indent,eol,start
				set cursorline
				set smartcase
				set showmode

				inoremap <silent> jj <ESC>
				nnoremap <silent> i a
				nnoremap <silent> I A
				nnoremap <silent> a i
				nnoremap <silent> A I
				vnoremap <silent> A I
				vnoremap <silent> A I
				noremap <S-j> $
				noremap <S-h> 0
				nnoremap == gg=G''

				"windows config
				noremap <silent> t^ :<C-u>sp<CR>
				noremap <silent> t~ :<C-u>vs<CR>
				noremap <silent> th <C-w>h 
				noremap <silent> tj <C-w>j 
				noremap <silent> tk <C-w>k 
				noremap <silent> tl <C-w>l 
				noremap <silent> tH <C-w>H 
				noremap <silent> tJ <C-w>J 
				noremap <silent> tK <C-w>K 
				noremap <silent> tL <C-w>L 
				noremap <silent> t> <C-w>> 
				noremap <silent> t< <C-w>< 
				noremap <silent> t+ <C-w>+ 
				noremap <silent> t- <C-w>- 

				"terminal mapping
				noremap <silent> ex :<C-u>terminal<CR>
