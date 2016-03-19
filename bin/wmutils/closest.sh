#!/bin/zsh
#
# Based off of closest.sh by z3bra
# Echoes the id of the closest window in a specific direction

# get current window id
CUR=$(pfw)

usage() {
    echo "usage: $(basename $0) <direction>" >&2
    exit 1
}

next_east() {
    lsw | xargs wattr xi | sort -nr | sed "0,/$CUR/d" | sed "1s/^[0-9]* //p;d"
}

next_west() {
    lsw | xargs wattr xi | sort -n | sed "0,/$CUR/d" | sed "1s/^[0-9]* //p;d"
}

next_north() {
    lsw | xargs wattr yi | sort -nr | sed "0,/$CUR/d" | sed "1s/^[0-9]* //p;d"
}

next_south() {
    lsw | xargs wattr yi | sort -n | sed "0,/$CUR/d" | sed "1s/^[0-9]* //p;d"
}

# Use the specification of your choice: WASD, HJKL, ←↑↓→, west/north/south/east
case $1 in
    h|a|east|left)  echo $(next_east)  ;;
    j|s|south|down) echo $(next_south) ;;
    k|w|north|up)   echo $(next_north) ;;
    l|d|west|right) echo $(next_west)  ;;
    *) usage ;;
esac
