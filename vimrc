let g:vim_conf_dir = expand('~/.vim/conf/')

for s:path in split(glob(g:vim_conf_dir . '*.vim'), "\n")
  exe 'source ' . s:path
endfor
