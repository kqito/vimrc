let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:plugins_dir = s:dein_dir . '/repos/github.com'
let s:dein_repo_dir = s:plugins_dir . '/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" Prevent to register duplicated runtimepath
if (&runtimepath !~ ".*".s:dein_repo_dir.".*")
    let &runtimepath = s:dein_repo_dir .",". &runtimepath
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('Shougo/dein.vim')

  for toml_path in glob(g:rc_root_path . '/dein/plugins/*.toml', 1, 1)
    if toml_path =~# 'lazy'
      call dein#load_toml(toml_path, { 'lazy': 1 })
    else
      call dein#load_toml(toml_path, { 'lazy': 0 })
    endif
  endfor

  call dein#end()
  call dein#save_state()

endif

if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

if has('vim_starting')
  if dein#check_install()
    call dein#install()
  end
else
  call dein#call_hook('source')
  call dein#call_hook('post_source')
endif
