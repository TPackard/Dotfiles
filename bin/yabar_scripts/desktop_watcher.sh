#!/usr/bin/zsh

echo -n "$(/home/tyler/bin/yabar_scripts/desktops.sh)"
bspc subscribe | while read line; do
	echo -n "$(/home/tyler/bin/yabar_scripts/desktops.sh)"
done
