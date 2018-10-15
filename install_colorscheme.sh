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

    echo "Install successfully!!\nThe additional colorscheme you can use are"

    for ((i = 0; i < ${#site[@]}; i++)) {
        echo $((i+1)). ${site[i]##*/} | sed -e 's/\.vim//'
    }

else
    cat << EOS
  You have not wget command!!
  Please install it.
EOS
fi
