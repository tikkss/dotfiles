set -x RBENV_ROOT $HOME/.rbenv
set -x PATH $RBENV_ROOT/bin $PATH

set -x NODENV_ROOT $HOME/.nodenv
set -x PATH $NODENV_ROOT/bin $PATH

set -x GOPATH $HOME
set -x PATH $GOPATH/bin $PATH

set -x CARGO_HOME $HOME/.cargo
set -x PATH $CARGO_HOME/bin $PATH

set -x FZF_DEFAULT_OPTS '--height 40% --reverse --border'

