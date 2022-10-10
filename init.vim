let g:rc_root_path = fnamemodify(expand('<sfile>'), ':h')
let g:python_host_prog = expand('~/.pyenv/versions/2.7.13/bin/python2')
let g:python3_host_prog = expand('/usr/local/bin/python3')
let g:ruby_host_prog = '/usr/bin/ruby'

exe 'source ' . g:rc_root_path . '/rc/init.vim'
