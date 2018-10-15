#!/bin/bash

declare -a site=(\
  "jonathanfilip/vim-lucius/raw/master/colors/lucius.vim" \
  "fcpg/vim-orbital/blob/master/colors/orbital.vim"\
  )
if type wget > /dev/null 2>&1; then

  color_dir="/usr/local/share/nvim/runtime/colors/"
  for ((i = 0; i < ${#site[@]}; i++)) {
    wget https://github.com/${site[i]} -P $color_dir > /dev/null 2>&1
  }

  printf "Install successfully!!\n\nThe additional colorscheme you can use are\n"

  for ((i = 0; i < ${#site[@]}; i++)) {
    filename=${site[i]##*/}
    printf "\e[31;4m $((i+1)). ${filename%.*}\e[m\n"
  }

  printf "\nPlease write it in vimrc as follows.\
    \n\e[32;40mcolorscheme ${filename}"

else
  cat << EOS
  You have not wget command!!
  Please install it.
EOS
fi
