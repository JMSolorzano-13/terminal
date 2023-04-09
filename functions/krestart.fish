function krestart --wraps='killall plasmashell && kstart5 plasmashell &' --description 'alias krestart=killall plasmashell && kstart5 plasmashell &'
  killall plasmashell && kstart5 plasmashell & $argv; 
end
