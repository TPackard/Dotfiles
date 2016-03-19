#!/bin/zsh

wew | while IFS=: read event wid; do
	case $event in
		19)
			# Ignore bar
			if [[ $(wname $wid) == "bar" ]]; then
				ignw -s $wid
			else
				wattr o $wid || $WM_SCRIPTS/focus.sh $wid
			fi ;;
	esac
done
