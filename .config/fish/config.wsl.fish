set -x DOCKER_HOST 'tcp://0.0.0.0:2375'

switch (umask)
case 0000
  umask 0022
end

function rubymine
  cmd.exe /c rubymine.cmd (wslpath -w (pwd))
end

