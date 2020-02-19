" ===== Dein Scripts =====
if(v:version >= 800 || has('nvim'))
  let g:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
  let g:dein_dir = g:cache_home . '/dein'
  let g:plugins_dir = g:dein_dir . '/repos/github.com'
  let g:dein_repo_dir = g:plugins_dir . '/Shougo/dein.vim'
  if !isdirectory(g:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(g:dein_repo_dir))
  endif

  " Prevent to register duplicated runtimepath
  if (&runtimepath !~ ".*".g:dein_repo_dir.".*")
      let &runtimepath = g:dein_repo_dir .",". &runtimepath
  endif

  " read plugin & create chache
  let s:toml_dir = expand('~/.vim/toml/')
  if dein#load_state(g:dein_dir)
    call dein#begin(g:dein_dir)
    call dein#load_toml(s:toml_dir.'/dein.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir.'/plugins.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir.'/plugins_lazy.toml', {'lazy': 1})
    call dein#load_toml(s:toml_dir.'/coc.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir.'/status.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir.'/theme.toml', {'lazy': 0})
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
