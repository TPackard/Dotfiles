#!/bin/zsh
# A script that dynamically adds and removes desktops to bspwm along with
# dynamically changing the gap width of windows based on the number of
# windows in the desktop. Dynamic gaps based off of the
# darndestthing.com/bspwm gym

# Generates a random 32 char hash for unique desktop names
function hash() {
	#echo $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
	echo $(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | head -c 32)
}

# Returns the number of desktops in bspwm
function num_desktops() {
	echo $(bspc wm --get-status | grep --ignore-case -oe ':[ufo]' | wc -l)
}

# Returns the desktop number of the first free desktop
function free_index() {
	index=0
	bspc wm --get-status | grep --ignore-case -oe ':[ufo]' | while read line; do
		((index++))

		if [[ "$line:l" == ":f" ]]; then
			break
		fi
	done

	echo $index
}

# Returns the desktop number of the focused desktop
function focus_index() {
	index=0
	bspc wm --get-status | grep --ignore-case -oe ':[ufo]' | while read line; do
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
	status_arr=(${$(bspc wm -g)})
	if [[ $status_arr[-3] == "LM" ]]; then # If monocle
		bspc config --desktop focused window_gap 0 # Remove window gaps
	else
		#dynamic_gaps
		/home/tyler/bin/resize_desktops.sh
	fi

	if [[ "$(bspc query -d focused -N | wc -l)" == "1" ]]; then # If only one node in focused desktop
		bspc config focused_border_color "#2C3E50"
		bspc config active_border_color "#2C3E50"
	else
		bspc config focused_border_color "#34495E"
		bspc config active_border_color "#34495E"
	fi

	free_desktops=$(grep -oi ":f" <<< "$line" | wc -l) # Number of free desktops
	if [[ $free_desktops -gt 1 ]]; then # If there are more than 1 free desktop, remove the extra desktops
		bspc desktop $(bspc query -D -d 'next.!occupied') -r
	elif [[ $free_desktops -eq 1 ]] && [[ $(free_index) != $(num_desktops) ]]; then # If there is only 1 free desktop but it isn't at the end, move it to the end
		if [[ $(focus_index) == $(free_index) ]]; then
			bspc desktop -f next
		fi

		bspc desktop "^$(free_index)" -s next
	fi

	if [[ $free_desktops -le 0 ]] && [[ ${#desktops[@]} -lt 10 ]]; then # If there are no free desktops, add one
		bspc monitor -a $(hash)
	fi
done
