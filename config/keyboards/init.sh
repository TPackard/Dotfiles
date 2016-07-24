#!/usr/bin/zsh

cd $(dirname $0)

for xkb_file in $(ls *.xkb); do
	keyboard_id=$(xinput list --id-only "${${xkb_file//_/ }%\.xkb}")
	xkbcomp -i $keyboard_id -synch ~/.config/keyboards/$xkb_file $DISPLAY
done
