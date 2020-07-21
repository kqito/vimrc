for s:path in split(glob('~/.vim/conf/*.vim'), "\n")
  exe 'source ' . s:path
endfor
