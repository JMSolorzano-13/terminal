function penv --wraps='source (poetry env info --path)/bin/activate.fish' --description 'alias penv source (poetry env info --path)/bin/activate.fish'
  source (poetry env info --path)/bin/activate.fish $argv; 
end
