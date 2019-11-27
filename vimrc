" ===== Load neovim config file =====
source ~/.config/nvim/init.vim

" ===== Dispaly gui color on tmux =====
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  syntax on
  set termguicolors
endif
