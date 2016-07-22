#!/usr/bin/zsh

echo -n "$(~/bin/yabar_scripts/desktops.sh)"
bspc subscribe | while read line; do
	echo -n "$(~/bin/yabar_scripts/desktops.sh)"
done
