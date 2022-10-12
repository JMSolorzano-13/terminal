# Defined via `source`
function dkl --wraps='docker logs -f --tail 10' --description 'alias dkl=docker logs -f --tail 10'
  docker logs -f --tail 10 $argv; 
end
