#!/bin/sh

ln -sf $PWD/.zshrc ~/.zshrc
ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.gvimrc ~/.gvimrc
ln -sf $PWD/.ideavimrc ~/.ideavimrc
ln -sf $PWD/.xvimrc ~/.xvimrc
ln -sf $PWD/.tmux.conf ~/.tmux.conf
ln -sf $PWD/.gitconfig ~/.gitconfig

sudo ln -sf $PWD/bin/wifi /usr/local/bin/wifi && sudo chmod +x /usr/local/bin/wifi
sudo ln -sf $PWD/bin/battery /usr/local/bin/battery && sudo chmod +x /usr/local/bin/battery
