function dlog
  docker logs --tail 10 -f $argv;
end
