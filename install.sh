#!/bin/bash

dotfiles_base="$(cd $(dirname "$0") && pwd)"

mkdir -p ~/.config/fish/conf.d
mkdir -p ~/.config/git
mkdir -p ~/.config/memo
mkdir -p ~/.vim/colors
ln -snfv $dotfiles_base/.config/fish/conf.d/000-env.fish ~/.config/fish/conf.d/000-env.fish
ln -snfv $dotfiles_base/.config/fish/config.fish ~/.config/fish/config.fish
ln -snfv $dotfiles_base/.config/fish/fishfile ~/.config/fish/fishfile
ln -snfv $dotfiles_base/.config/git/ignore ~/.config/git/ignore
ln -snfv $dotfiles_base/.config/memo/config.toml ~/.config/memo/config.toml
ln -snfv $dotfiles_base/.config/starship.toml ~/.config/starship.toml
ln -snfv $dotfiles_base/.gemrc ~/.gemrc
ln -snfv $dotfiles_base/.gitconfig ~/.gitconfig
ln -snfv $dotfiles_base/.gvimrc ~/.gvimrc
ln -snfv $dotfiles_base/.ideavimrc ~/.ideavimrc
ln -snfv $dotfiles_base/.tigrc ~/.tigrc
ln -snfv $dotfiles_base/.tmux.conf ~/.tmux.conf
ln -snfv $dotfiles_base/.vim/colors/railscasts.vim ~/.vim/colors/railscasts.vim
ln -snfv $dotfiles_base/.vimrc ~/.vimrc

# for Mac
if [[ `uname -a` =~ Darwin ]]; then
  ln -snfv $dotfiles_base/alacritty.yml ~/alacritty.yml
  sudo ln -snfv /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
fi

# for WSL
if [[ `uname -a` =~ Linux && `uname -a` =~ (M|m)icrosoft ]]; then
  userprofile="$(wslpath -u $(wslvar USERPROFILE))"
  appdata="$(wslpath -u $(wslvar APPDATA))"

  mkdir -p $appdata/alacritty
  mkdir -p $userprofile/.config/git
  mkdir -p $userprofile/.config/memo
  ln -nfv $dotfiles_base/alacritty.yml $appdata/alacritty/
  ln -nfv $dotfiles_base/.config/appdata/Keyhac/config.py $appdata/Keyhac/config.py
  ln -nfv $dotfiles_base/.config/appdata/WindowsTerminal/settings.json $appdata/../Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
  ln -snfv $dotfiles_base/.config/fish/config.wsl.fish ~/.config/fish/config.local.fish
  ln -nfv $dotfiles_base/.config/git/ignore $userprofile/.config/git/ignore
  ln -snfv $dotfiles_base/.config/memo/config.wsl.toml ~/.config/memo/config.toml
  ln -nfv $dotfiles_base/.config/memo/config.toml $userprofile/.config/memo/config.toml
  ln -nfv $dotfiles_base/.gitconfig $userprofile/.gitconfig
  ln -nfv $dotfiles_base/.ideavimrc $userprofile/.ideavimrc
  ln -nfv $dotfiles_base/.wslconfig $userprofile/.wslconfig
  sudo ln -snfv /usr/bin/fish /usr/local/bin/fish

  # Build & link diff-highlight
  cd /usr/share/doc/git/contrib/diff-highlight/
  sudo make
  sudo ln -snfv /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

  # Download & move starship
  cd /tmp
  wget -q --show-progress https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz -O starship-x86_64-unknown-linux-gnu.tar.gz
  tar xvf starship-x86_64-unknown-linux-gnu.tar.gz
  sudo mv -fv starship /usr/local/bin/

  # Download & move ghq
  cd /tmp
  wget -q --show-progress https://github.com/motemen/ghq/releases/latest/download/ghq_linux_amd64.zip -O ghq_linux_amd64.zip
  unzip -o ghq_linux_amd64.zip
  sudo mv -fv ghq_linux_amd64/ghq /usr/local/bin/

  # Download & move mattn/memo
  cd /tmp
  wget -q --show-progress https://github.com/mattn/memo/releases/latest/download/memo_v0.0.13_linux_amd64.tar.gz -O memo_linux_amd64.tar.gz
  tar xvf memo_linux_amd64.tar.gz
  sudo mv -fv memo_v0.0.13_linux_amd64/memo /usr/local/bin/

  # Clone or pull rbenv
  if [ -d $RBENV_ROOT ]; then
    cd $RBENV_ROOT && git pull
    cd $RBENV_ROOT/plugins/ruby-build && git pull
  else
    git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT
    mkdir -p $RBENV_ROOT/plugins
    git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build
  fi

  # Clone or pull nodenv
  if [ -d $NODENV_ROOT ]; then
    cd $NODENV_ROOT && git pull
    cd $NODENV_ROOT/plugins/node-build && git pull
  else
    curl -fsSL https://raw.githubusercontent.com/nodenv/nodenv-installer/master/bin/nodenv-installer | bash
    mkdir -p $NODENV_ROOT/plugins
    git clone https://github.com/nodenv/node-build.git $NODENV_ROOT/plugins/node-build
  fi

  # Install Yarn without Node.js
  if [ ! -d ~/.yarn ]; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  fi
  sudo apt update && sudo apt install --no-install-recommends yarn

  # Clone & install fzf
  if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
  fi

fi

fish -c fisher

