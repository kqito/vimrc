#!/bin/bash

declare -a site=(\
  "https://raw.githubusercontent.com/jonathanfilip/vim-lucius/master/colors/lucius.vim" \
  "https://raw.githubusercontent.com/fcpg/vim-orbital/master/colors/orbital.vim"\
  "https://raw.githubusercontent.com/elmindreda/vimcolors/master/colors/phosphor.vim"\
		"https://github.com/tomasr/molokai"\
  )
color_dir="/usr/local/share/nvim/runtime/colors/"

function install_colorscheme(){ 
  if type wget > /dev/null 2>&1; then
    for ((i = 0; i < ${#site[@]}; i++)) {
      wget ${site[i]} -O $color_dir${site[i]##*/} > /dev/null 2>&1
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
printf "Save location : \e[31;4m$color_dir"

exit
}

install_colorscheme && result || error
