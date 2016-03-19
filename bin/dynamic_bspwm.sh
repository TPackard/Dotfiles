#!/bin/zsh
# A script that dynamically adds and removes desktops to bspwm along with
# dynamically changing the gap width of windows based on the number of
# windows in the desktop. Dynamic gaps based off of the
# darndestthing.com/bspwm gym

# Dynamically change gaps based on the number of windows in the desktop.
# Maximum 48 pixels, minimum 24 pixels. The gap changes by 12 pixels for
# every window added
function dynamic_gaps() {
	X=$(echo "48 * 0.25 / 0.282" | bc)
	W=$(bspc query --desktop focused --windows | wc -l)
	G=$(echo "($X + 12) - ($W - 1) * 12" | bc)
	[[ $G -lt 24 ]] && G=24
	bspc config --desktop focused window_gap $G
}

# Generates a random 32 char hash for unique desktop names
function hash() {
	echo $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
}

# Returns the number of desktops in bspwm
function num_desktops() {
	echo $(bspc control --get-status | grep --ignore-case -oe ':[ufo]' | wc -l)
}

# Returns the desktop number of the first free desktop
function free_index() {
	index=0
	bspc control --get-status | grep --ignore-case -oe ':[ufo]' | while read line; do
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
	bspc control --get-status | grep --ignore-case -oe ':[ufo]' | while read line; do
		((index++))

		if [[ -n "$(grep -e '[UFO]' <<< $line)" ]]; then
			break
		fi
	done

	echo $index
}

# Main loop
bspc control --subscribe | while read line; do
	if [[ "${line: -1}" == "M" ]]; then
		bspc config --desktop focused window_gap 14
	else
		bspc config --desktop focused window_gap 12
	fi

	if [[ "$(bspc query --desktop focused --windows | wc -l)" == "1" ]]; then
		bspc config focused_border_color "#2C3E50"
		bspc config active_border_color "#2C3E50"
	else
		bspc config focused_border_color "#34495E"
		bspc config active_border_color "#34495E"
		#$(dynamic_gaps)
	fi

	free_desktops=$(grep -oi ":f" <<< "$line" | wc -l) # Number of free desktops
	if [[ $free_desktops -gt 1 ]]; then # If there are more than 1 free desktop, remove the extra desktops
		bspc monitor -r $(bspc query -D -d next.free)
		redrawbar.sh
	elif [[ $free_desktops -eq 1 ]] && [[ $(free_index) != $(num_desktops) ]]; then # If there is only 1 free desktop but it isn't at the end, move it to the end
		if [[ $(focus_index) == $(free_index) ]]; then
			bspc desktop -f next
		fi

		bspc desktop "^$(free_index)" -s next
		redrawbar.sh
	fi

	if [[ $free_desktops -le 0 ]] && [[ ${#desktops[@]} -lt 10 ]]; then # If there are no free desktops, add one
		bspc monitor -a $(hash)
		redrawbar.sh
	fi
done
