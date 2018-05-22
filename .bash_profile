# .bash_profile
export PATH=$HOME/.rbenv/bin:$PATH

# Get the aliasesand functions
if [ -f ~/.bashrc ] ; then
  . ~/.bashrc
fi

# User specific environment and startup programs
eval "$(rbenv init -)"
source ~/.rbenv/completions/rbenv.bash

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# for Go lang
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

