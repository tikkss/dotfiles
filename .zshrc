# Set up the prompt

autoload -Uz promptinit
promptinit
# Disable for starship
# prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Basics
# ---

# bash like
bindkey \^U backward-kill-line

alias g=git
alias ll="ls -al"

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.zshrc.work ] && source ~/.zshrc.work

export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"

type fzf > /dev/null 2>&1 && eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --reverse --border"

export GOPATH="$HOME"
export PATH="$GOPATH/bin:$PATH"

export NODENV_ROOT="$HOME/.nodenv"
export PATH="$NODENV_ROOT/bin:$PATH"

export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init - zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

eval "$(starship init zsh)"

export PATH="$HOME/.local/bin:$PATH"
eval "$(zoxide init zsh)"

WORDCHARS=${WORDCHARS:s,/,,}

# Plugins
# ---

source ~/.zsh.d/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh.d/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Functions
# ---

function ghq-fzf() {
  local selected_repo=$(ghq list | fzf --query="$LBUFFER")

  if [ -n "$selected_repo" ]; then
    selected_repo=$(ghq list --full-path --exact $selected_repo)
    BUFFER="cd ${selected_repo}"
    zle accept-line
  fi

  zle reset-prompt
}
zle -N ghq-fzf
bindkey "^g" ghq-fzf

function git-branch-fzf() {
  local selected_branch=$(git branch --sort=-committerdate | fzf --query="$LBUFFER" | sed -e "s/^.* //g")
  
  if [ -n "$selected_branch" ]; then
    BUFFER="git switch ${selected_branch}"
    zle accept-line
  fi

  zle reset-prompt
}
zle -N git-branch-fzf
bindkey "^]" git-branch-fzf

function history-fzf() {
  local selected_history=$(history -nr -1000 | fzf --query="$LBUFFER")

  if [ -n "$selected_history" ]; then
    BUFFER="$selected_history"
    zle end-of-line
  fi

  zle redisplay
}
zle -N history-fzf
bindkey "^r" history-fzf

function ide() {
  tmux split-window -v -p 30
  tmux split-window -h -p 66
  tmux split-window -h -p 50

  tmux send-keys C-l
  tmux select-pane -L
  tmux send-keys C-l
  tmux select-pane -L
  tmux send-keys C-l
  tmux select-pane -U
  tmux send-keys C-l
}

