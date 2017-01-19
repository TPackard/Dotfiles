source ~/.zshrc

[[ ! -s ~/.config/mpd/pid ]] && mpd
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	if startx; then
		exit
	fi
fi
