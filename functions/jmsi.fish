function rr
  ranger-cd;
end
function mm
  micro $argv;
end
function dcd
  docker-compose up -d;
end
function dcu
  docker-compose up -u;
end
function dcr
  docker-compose restart;
end
function dps
  docker ps -a;
end
function dlog
  docker logs --tail 10 -f $argv;
end
function ds
  docker stop $argv;
end
function dr
  docker restart $argv;
end
function envars
  cd /var/www/.ssh;
drend
