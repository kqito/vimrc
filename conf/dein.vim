let g:python_host_prog = expand('~/.pyenv/versions/2.7.13/bin/python2')
let g:python3_host_prog = expand('/usr/local/bin/python3')
let g:ruby_host_prog = '/usr/bin/ruby'

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

  if dein#load_state(g:dein_dir)
    call dein#begin(g:dein_dir)

    call dein#add('Shougo/dein.vim')
    autocmd VimEnter * call dein#call_hook('post_source')

    exe 'source ' . g:vim_conf_dir . 'editor/load.vim'
    exe 'source ' . g:vim_conf_dir . 'plugins/load.vim'

    call dein#end()
    call dein#save_state()
  endif

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  if has('vim_starting') && dein#check_install()
    call dein#install()
  endif
endif
