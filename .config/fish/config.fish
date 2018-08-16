set -x PATH $HOME/.rbenv/bin $PATH
rbenv init - fish | source

set -x GOPATH $HOME
set -x PATH $GOPATH/bin $PATH

set -x FZF_DEFAULT_OPTS '--height 40% --reverse --border'

alias g git

if [ -f ~/.config/fish/config.local.fish ]
  source ~/.config/fish/config.local.fish
end

