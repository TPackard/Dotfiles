#!/bin/zsh
# Based on focus.sh by z3bra

BW=${BW:-2}			# Border width
ACTIVE=${ACTIVE:-0x34495E}	# Active border color
INACTIVE=${INACTIVE:-0x2C3E50}	# Inactive border color

CUR=$(pfw)

set_border() {
	ROOT=$(lsw -r)

	wattr $2 || return
	test "$(wattr xywh $2)" = "$(wattr xywh $ROOT)" && return

	case $1 in
		active)   chwb -s $BW -c $ACTIVE $2 ;;
		inactive) chwb -s $BW -c $INACTIVE $2 ;;
	esac
}

case $1 in
	next) wid=$(lsw | grep -v $CUR | sed '1 p;d') ;;
	prev) wid=$(lsw | grep -v $CUR | sed '$ p;d') ;;
	0x*)  wattr $1 && wid=$1 ;;
	*)
		echo "usage: $(basename $0) <next|prev|wid>"
		exit 1
	;;
esac

test -z "$wid" && echo "$(basename $0): can't find a window to focus" >&2 && exit 1

set_border inactive $CUR
set_border active $wid
chwso -r $wid
wtf $wid
