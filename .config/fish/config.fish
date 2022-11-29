alias g git
alias ll "ls -al"

if [ -f ~/.config/fish/config.local.fish ]
  source ~/.config/fish/config.local.fish
end

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

starship init fish | source
zoxide init fish | source

