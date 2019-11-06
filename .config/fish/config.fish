alias g git
alias ll "ls -al"

if [ -f ~/.config/fish/config.local.fish ]
  source ~/.config/fish/config.local.fish
end

starship init fish | source

