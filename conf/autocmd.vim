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
  autocmd! InsertEnter,FocusGained,BufEnter * if mode() != 'c' && &filetype != 'vim' | checktime | endif
augroup END

" ===== Filetype settings =====
augroup updateFiletype
  autocmd!

augroup END

" ===== Go settings =====
augroup go
  autocmd FileType go setlocal sw=4 ts=4 sts=4 noet
augroup END

" ===== Rust settings =====
augroup rust
  function s:AutoWriteIfPossible()
    if &modified && !&readonly && bufname('%') !=# '' && &buftype ==# '' && expand("%") !=# ''
      exe ":noa wa"
    endif
  endfunction

  " for auto check within coc-rust-analyzer
  autocmd CursorHold *.rs call s:AutoWriteIfPossible()
  autocmd CursorHoldI *.rs call s:AutoWriteIfPossible()
augroup END
