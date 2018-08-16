set -x DOCKER_HOST 'tcp://0.0.0.0:2375'

switch (umask)
case 0000
  umask 0022
end

function rubymine
  "/c/Program Files/JetBrains/RubyMine 2018.1.4/bin/rubymine64.exe" .
end

