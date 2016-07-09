#!/usr/bin/zsh

# Colors
true_black="#000000"
black="#2C3E50"
light_black="#34495E"
dark_gray="#95A5A6"
gray="#E0E0E0"
light_gray="#ECF0F1"
red="#E74C3C"
orange="#E67E22"
yellow="#F1C40F"
green="#2ECC71"
cyan="#1ABC9C"
blue="#3498DB"
magenta="#9B59B6"

subtle=$black
dull=$dark_gray

# Send signal to redraw via SIGINT (slightly hacky). Stands for SIGnal REDraw
local sigred="kill -s SIGINT ${$}"

# Shows the desktops
# Left click to move to a specific desktop
desktops() {
	local desk_str=""
	#local after_select=false

	for i in $(bspc query -D); do
		#local background=
		local color=${dull}
		#local space=" "
		#local after_space=""
		#[[ "$after_select" = true ]] && space="" && after_select=false
		[[ "$i" == "$(bspc query -D --desktop focused)" ]] && color=${blue} #&& background=${blue} && color=${white} && after_space=" " && after_select=true
		desk_str+=" %{F${color}}•"
	done

	echo -n "$desk_str"
}

# Shows the volume
# Left click to change volume and mute
# TODO: Right click to change volume in small increments and bring up alsamixer
volume() {
	local vol=$(awk -F"[]%[]" '/dB/ { print $2 }' <(amixer sget Master))
	local volume_color="-"
	[[ "$(awk -F"[][]" '/dB/ { print $6 }' <(amixer sget Master))" == "off" ]] && volume_color=${dull}
	local dec_vol="%{F${dull}}%{A:amixer -q sset Master 5%-; ${sigred}:}%{A3:amixer -q sset Master 1%-; ${sigred}:} - %{A}%{A}"
	local vol_level="%{F${volume_color}}%{A:amixer -q sset Master toggle; ${sigred}:}%{A3:termite -e \"alsamixer\":}${vol}%{A}%{A}"
	local inc_vol="%{F${dull}}%%{A:amixer -q sset Master 5%+; ${sigred}:}%{A3:amixer -q sset Master 1%+; ${sigred}:} + %{A}%{A}"
	echo "${dec_vol}${vol_level}${inc_vol}"
}

# Returns the time in HH:MM AM/PM
clock() {
	local time_str="$(date "+%{F-}%-l%{F${dull}}:%{F-}%M %{F${dull}}%p")"
	echo -n "$time_str"
}

# Shows battery charge state and percentage
battery() {
	local info="$(acpi -b)"
	local percent="$(echo ${info} | cut -d, -f2 | cut -d "%" -f1)"

	# Set dot green for full, yellow for charging, and red for discharging
	local state=${dull}
	if [[ $info == *"Full"* ]]; then
		state=${green}
	elif [[ $info == *"Charging"* ]]; then
		if [[ $info == *"100%"* ]]; then
			state=${green}
		else
			state=${yellow}
		fi
	elif [[ $info == *"Discharging"* ]]; then
		state=${red}
	fi

	echo -n "%{F${state}}•%{F-}$percent%{F${dull}}%"
}

# Redraw the bar when the interrupt signal is sent. This allows button clicks to automatically redraw the bar
trap redraw SIGINT
redraw() {
	#                                          |                         |
	echo "$(desktops)%{r}$(volume)%{F${subtle}}  $(battery) %{F${subtle}}  $(clock)%{F-} "
}

while true; do
	redraw
	sleep 1 & wait
done
