#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $BASH_SOURCE); pwd)
NVIM_CONFIG_DIR="${HOME}/.config/nvim"

check() {
  read -p "$1 (y/N): " yn
  case "$yn" in
    [yY]*) return 0 ;;
    *) return 1 ;;
  esac
}

installForNeovim() {
  echo "Installing kqito's nvim config..."
  mkdir -p "$NVIM_CONFIG_DIR"

  # Remove existing init.lua if it exists
  if [ -e "$NVIM_CONFIG_DIR/init.lua" ]; then
    rm -f "$NVIM_CONFIG_DIR/init.lua"
  fi

  # Copy all Lua files to ~/.config/nvim
  cp -r "$SCRIPT_DIR/lua" "$NVIM_CONFIG_DIR"
  cp "$SCRIPT_DIR/init.lua" "$NVIM_CONFIG_DIR"

  # Optional: Copy coc-settings.json
  if [ -e "$SCRIPT_DIR/coc-settings.json" ]; then
      cp "$SCRIPT_DIR/coc-settings.json" "$NVIM_CONFIG_DIR"
  fi

  echo "Done!!"
}

isEmptyNvimConfigDir() {
  # Check if the directory is empty
  if [ ! -d "$NVIM_CONFIG_DIR" ] || [ ! -z "$(ls -A $NVIM_CONFIG_DIR)" ]; then
    echo "Your nvim config directory exists and is not empty: $NVIM_CONFIG_DIR"
    return 1
  else
    return 0
  fi
}

! isEmptyNvimConfigDir && $(! check "Remove all your existing nvim config to install kqito's config?") && exit 0
installForNeovim
