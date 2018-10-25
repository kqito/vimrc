#!/bin/bash

declare -a site=(\
  "https://raw.githubusercontent.com/jonathanfilip/vim-lucius/master/colors/lucius.vim" \
  "https://raw.githubusercontent.com/fcpg/vim-orbital/master/colors/orbital.vim"\
  "https://raw.githubusercontent.com/elmindreda/vimcolors/master/colors/phosphor.vim"\
  )

vim_dir=`which vim | sed 's/\/bin\/vim//'`

function install_colorscheme(){ 
  if type wget > /dev/null 2>&1; then
    for ((i = 0; i < ${#site[@]}; i++)) {
      find ${vim_dir} -name '*vim*' -type d | \
        xargs -n1 -I@ find @ -name 'colors' | \
        uniq | \
        xargs -I@ wget ${site[i]} -O @/${site[i]##*/} > /dev/null 2>&1
    }
  else
    cat << EOS
You have not wget command!!
Please install it.
EOS
exit 1
fi
}

function result(){
  printf "Install successfully!!\n\nThe additional colorscheme you can use are\n"

  for ((i = 0; i < ${#site[@]}; i++)) {
    filename=${site[i]##*/}
    printf "\e[31;4m $((i+1)). ${filename%.*}\e[m\n"
  }

  printf "\nPlease write it in vimrc as follows.\
    \n\e[32;40mcolorscheme ${filename%.*}"
}

function error(){
  cat << EOS
Someting to wrong!
Please check to exist the url. 
Also please check the permissions of colorscheme directory. 

EOS
for ((i = 0; i < ${#site[@]}; i++)) {
  printf "Colorscheme url $((i+1)): \e[31;4m${site[i]}\e[m\n"
}

printf "\nSave location : \e[31;4m\n"
find ${vim_dir} -name '*vim*' -type d | \
  xargs -n1 -I@ find @ -name 'colors' | \
  uniq | \
  xargs -I@ && 
  exit
}

install_colorscheme && result || error
