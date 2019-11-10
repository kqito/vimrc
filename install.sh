#!/bin/bash

scriptDirectory=($(cd $(dirname $BASH_SOURCE); pwd))

# Create nvim dir
mkdir -p ~/.config/

# Copy vimrc files
`cp -r "${scriptDirectory}" ~/.config/nvim`
`cp -r "${scriptDirectory}" ~/.vim`
