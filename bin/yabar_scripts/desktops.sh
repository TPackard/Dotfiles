#!/usr/bin/zsh

source /home/tyler/bin/yabar_scripts/global.sh

desk_str=""

for i in $(bspc query -D); do
	color=${white}
	size="4096"
	spacing="3072"
	[[ "$i" == "$(bspc query -D --desktop focused)" ]] && color=${blue} && size="7168" && spacing="1536"
	rise="$(((16384 - 4096) / 2 - 1024))"
	padding="<span letter_spacing='$spacing'> </span>"
	desk_str+="  $padding<span size='$size' rise='$rise' color='${color}'></span>$padding"
done

echo -n "$desk_str "
