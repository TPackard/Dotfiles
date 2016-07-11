#!/usr/bin/zsh

# Dynamically change gaps based on the number of windows in the desktop.
# Maximum 96 pixels, minimum 24 pixels. The gap changes by 24 pixels for
# every window added
gap_diff="$(/home/tyler/bin/metadata.sh bspwm gap_width)"
max_gap="$(($gap_diff*4))"
W=$(( ($(bspc query -d focused -N | wc -l) + 1) / 2 ))
G=$(( max_gap - (W - 1) * gap_diff ))
[[ $G -gt max_gap ]] && G=max_gap
[[ $G -lt gap_diff ]] && G=gap_diff

cur_gap="$(bspc config -d focused window_gap)"
inc="1"
[[ "$cur_gap" -gt "$G" ]] && inc="-1"

for gap_width in $(seq "$cur_gap" "$inc" "$G"); do
	bspc config -d focused window_gap "$gap_width"
done
