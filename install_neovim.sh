#!/usr/bin/env bash
mkdir -p ~/.config/nvim
mkdir -p ~/.cache/dein
echo "alias vi='nvim'" >> ~/.zshrc
cp -r {init.vim,toml} ~/.config/nvim/
source ~/.zshrc

sudo yum groups install -y Development\ tools
sudo yum install -y cmake
sudo yum install -y python34-{devel,pip}
sudo pip-3.4 install neovim --upgrade
(
cd "$(mktemp -d)"
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
)

vi
