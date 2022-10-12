# Defined in - @ line 1
function gitinit --description 'alias gitinit git init ; and git add . ; and git commit -am [INIT]'
	git init ; and git add . ; and git commit -am [INIT] $argv;
end
