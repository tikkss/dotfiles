#!/bin/bash

dotfiles_base="$(cd $(dirname "$0") && pwd)"

ln -snfv $dotfiles_base/.config/fish/config.fish ~/.config/fish/config.fish
mkdir -p ~/.config/git
ln -snfv $dotfiles_base/.config/git/ignore ~/.config/git/ignore
ln -snfv $dotfiles_base/.gemrc ~/.gemrc
ln -snfv $dotfiles_base/.gitconfig ~/.gitconfig
ln -snfv $dotfiles_base/.ideavimrc ~/.ideavimrc
ln -snfv $dotfiles_base/.tmux.conf ~/.tmux.conf
ln -snfv $dotfiles_base/.vimrc ~/.vimrc

# for WSL
if [[ `uname -a` =~ Linux && `uname -a` =~ Microsoft ]]; then
  ln -snfv $dotfiles_base/.config/fish/config.wsl.fish ~/.config/fish/config.local.fish
  sudo ln -snfv /usr/bin/fish /usr/local/bin/fish
fi
