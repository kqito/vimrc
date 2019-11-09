#!/bin/bash

scriptDirectory=($(cd $(dirname $BASH_SOURCE); pwd))

# Create nvim dir
mkdir -p ~/.config/nvim/

# Copy vimrc files
`cp "${scriptDirectory}"/* ~/.config/nvim/`
