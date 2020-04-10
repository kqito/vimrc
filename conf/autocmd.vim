" ===== Autocmd settings =====
augroup general
  autocmd!

  " Turn off paste mode when leaving insert
  autocmd InsertEnter * set nopaste

  " Move the cursor to previous position when a file is opened
  autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

  " Set indent space
  autocmd FileType *  setlocal sw=2 sts=2 ts=2 et

  " Open a help text vertically
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif

  " Remove space or tab at End of line
  autocmd BufWritePre * :%s/\s\+$//e

  " Auto reload
  autocmd! FocusGained,BufEnter * if mode() != 'c' | checktime | endif
augroup END

" ===== Filetype settings =====
augroup updateFiletype
  autocmd!

  autocmd BufNewFile,BufRead *.tsx setf typescript
augroup END

