#!/bin/zsh
# A script that dynamically adds and removes desktops from bspwm.

# Global desktop ID number (did)
did=${1:-0}

# Returns the number of desktops in the given monitor
# $1: monitor status string
function num_desktops() {
	echo $(grep -oi ':[ufo]' <<< $1 | wc -l)
}

# Returns the desktop number of the first unfocused free desktop in the given
# monitor
# $1: monitor status string
function free_index() {
	index=0
	grep -oi ':[ufo]' <<< $1 | while read line; do
		((index++))

		if [[ "$line" == ":f" ]]; then
			break
		fi
	done

	echo $index
}

# Returns the desktop number of the focused desktop in the given monitor
# $1: monitor status string
function focus_index() {
	index=0
	grep -oi ':[ufo]' <<< $1 | while read line; do
		((index++))

		if [[ -n "$(grep -e '[UFO]' <<< $line)" ]]; then
			break
		fi
	done

	echo $index
}

# Main loop
IFS=":"
bspc subscribe | while read line; do
	# Iterate over active monitors
	line="$(bspc wm -g)"
	grep -Poi '(?<=w|:)m.*?(?=:m|$)' <<< $line | while read monitor; do
		#status_arr=(${$(bspc wm -g)})
		#if [[ $status_arr[-3] == "LM" ]]; then # If monocle
			#bspc config --desktop focused window_gap 0 # Remove window gaps
		#else
			#~/bin/resize_desktops.sh
			#bspc config --desktop focused window_gap 12
		#fi

		# MDP-1-2:OI:LT:TT:G
		# meDP-1:ODesktop:oW268idkEFitmuZyNYs94ILh0Hq0oGjK:ojskdk2e8caUWXAVxLvk
		# 		DdhdEHcXclXP:fNeCC6BxNw968hoVXMgW0SCWGPErxBny:LT:TT:

		# Monitor name
		mon_name=$(grep -Poi '(?<=^m).*?(?=:)' <<< $monitor)

		# Number of free desktops. Doesn't count a focused free desktop if it's
		# not the last desktop.
		free_desktops=$(grep -o ":f" <<< "$monitor" | wc -l)
		((free_desktops += $(grep -Pc ':F[^:]*:L' <<< $monitor)))

		if [[ $free_desktops -gt 1 ]]; then
			# If there are more than 1 free desktop, remove one unoccupied
			# desktop from the monitor
			bspc desktop $(grep -Po '(?<=:f).*?(?=:)' <<< $monitor | head -n 1) -r
		elif [[ $free_desktops -le 0 ]] && [[ ${#desktops[@]} -lt 10 ]]; then
			# If there are no free desktops, add one
			((++did))
			bspc monitor $mon_name -a $did
		elif [[ $free_desktops -eq 1 ]] && [[ $(free_index $monitor) != $(num_desktops $monitor) ]]; then
			# If there is only 1 free desktop but it isn't at the end, move it to
			# the end
			bspc desktop "$mon_name:^$(free_index $monitor)" -b next
		fi
	done
done
