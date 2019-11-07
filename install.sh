#!/bin/bash

dotfiles_base="$(cd $(dirname "$0") && pwd)"

ln -snfv $dotfiles_base/.config/fish/conf.d/000-env.fish ~/.config/fish/conf.d/000-env.fish
ln -snfv $dotfiles_base/.config/fish/config.fish ~/.config/fish/config.fish
ln -snfv $dotfiles_base/.config/fish/fishfile ~/.config/fish/fishfile
mkdir -p ~/.config/git
ln -snfv $dotfiles_base/.config/git/ignore ~/.config/git/ignore
ln -snfv $dotfiles_base/.gemrc ~/.gemrc
ln -snfv $dotfiles_base/.gitconfig ~/.gitconfig
ln -snfv $dotfiles_base/.ideavimrc ~/.ideavimrc
ln -snfv $dotfiles_base/.tigrc ~/.tigrc
ln -snfv $dotfiles_base/.tmux.conf ~/.tmux.conf
ln -snfv $dotfiles_base/.vimrc ~/.vimrc

# for Mac
if [[ `uname -a` =~ Darwin ]]; then
  sudo ln -snfv /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
fi

# for WSL
if [[ `uname -a` =~ Linux && `uname -a` =~ Microsoft ]]; then
  ln -nfv $dotfiles_base/.config/appdata/Keyhac/config.py "$(wslpath -u $APPDATA)/Keyhac/config.py"
  ln -snfv $dotfiles_base/.config/fish/config.wsl.fish ~/.config/fish/config.local.fish
  sudo ln -snfv /usr/bin/fish /usr/local/bin/fish

  # Build & link diff-highlight
  cd /usr/share/doc/git/contrib/diff-highlight/
  sudo make
  sudo ln -snfv /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

  # Download & move starship
  cd /tmp
  wget -q --show-progress https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz -O starship-x86_64-unknown-linux-gnu.tar.gz
  tar xvf starship-x86_64-unknown-linux-gnu.tar.gz
  sudo mv -fv target/x86_64-unknown-linux-gnu/release/starship /usr/local/bin/

  # Download & move ghq
  cd /tmp
  wget -q --show-progress https://github.com/motemen/ghq/releases/latest/download/ghq_linux_amd64.zip -O ghq_linux_amd64.zip
  unzip -o ghq_linux_amd64.zip
  sudo mv -fv ghq_linux_amd64/ghq /usr/local/bin/

  # Clone or pull rbenv
  if [ -d $RBENV_ROOT ]; then
    cd $RBENV_ROOT && git pull
    cd $RBENV_ROOT/plugins/ruby-build && git pull
  else
    git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT
    mkdir -p $RBENV_ROOT/plugins
    git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build
  fi
fi

fish -c fisher

