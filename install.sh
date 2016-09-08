#!/bin/sh
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gvimrc ~/.gvimrc
ln -sf ~/dotfiles/.ideavimrc ~/.ideavimrc
ln -sf ~/dotfiles/.xvimrc ~/.xvimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

sudo ln -sf ~/dotfiles/bin/wifi /usr/local/bin/wifi && sudo chmod +x /usr/local/bin/wifi
sudo ln -sf ~/dotfiles/bin/battery /usr/local/bin/battery && sudo chmod +x /usr/local/bin/battery
