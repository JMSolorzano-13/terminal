starship init fish | source

# Add this to your ~/.config/fish/config.fish
function ranger-cd
	ranger --choosedir="$HOME/.rangerdir"; cd (cat $HOME/.rangerdir)
end
