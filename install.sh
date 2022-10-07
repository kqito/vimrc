#!/bin/bash

SCRIPT_DIR=($(cd $(dirname $BASH_SOURCE); pwd))
declare -a VIMRC_DIRS=("${HOME}/.vim" "${HOME}/.config/nvim")

check() {
  read -p "$1 (y/N): " yn

  case "$yn" in
    [yY]*) return 0 ;;
    *) return 1 ;;
  esac
}

installForVim() {
  echo "Installing kqito's vimrc..."

  mkdir -p ~/.config/

  for dir in ${VIMRC_DIRS[@]}; do
    rm -rf ${dir}
    ln -s ${SCRIPT_DIR} ~/.vim
  done

  echo "Done!!"
}

isEmptyVimrcDir() {
  isEmpty=0

  for dir in ${VIMRC_DIRS[@]}; do
    if [ ! -z "$(ls -A ${dir})" ]; then
      echo "Your vimrc is exist!! => ${dir}"
      isEmpty=1
    fi
  done

  [ ${isEmpty} -eq 0 ] && return 0 || return 1
}


! isEmptyVimrcDir && $(! check "Remove all your vimrc to install kqito's vimrc?") && exit 0

installForVim
