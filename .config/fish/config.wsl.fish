alias gvim gvim.exe
alias open xdg-open

switch (umask)
case 0000
  umask 0022
end

function rubymine
  cmd.exe /c rubymine.cmd (wslpath -w (pwd))
end

