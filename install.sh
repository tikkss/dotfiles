#!/bin/bash

dotfiles_base="$(cd $(dirname "$0") && pwd)"

ln -snfv $dotfiles_base/.config/fish/config.fish ~/.config/fish/config.fish
ln -snfv $dotfiles_base/.config/git/ignore ~/.config/git/ignore
ln -snfv $dotfiles_base/.gitconfig ~/.gitconfig
ln -snfv $dotfiles_base/.ideavimrc ~/.ideavimrc

# for WSL
if [[ `uname -a` =~ Linux && `uname -a` =~ Microsoft ]]; then
  ln -snfv $dotfiles_base/.config/fish/config.wsl.fish ~/.config/fish/config.local.fish
fi
