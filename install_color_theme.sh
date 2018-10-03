#!/bin/bash
if type wget > /dev/null 2>&1; then
  wget https://github.com/jonathanfilip/vim-lucius/raw/master/colors/lucius.vim
  echo 'install successfully!!'
else
  cat << EOS
  you have not wget command!!
  please install it.
EOS
fi
