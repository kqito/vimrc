#!/bin/bash

scriptDirectory=($(cd $(dirname $BASH_SOURCE); pwd))

# Create nvim dir
mkdir -p ~/.config/

# Copy vimrc files
`cp -r "${scriptDirectory}" ~/.config/`

# Rename the dir for vim command
mv ~/.config/vimrc ~/.config/nvim

# Copy vimrc
cp ~/.config/nvim/vimrc ~/.vimrc
