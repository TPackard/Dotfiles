#!/usr/bin/zsh

source ~/bin/yabar_scripts/global.sh

desk_str=""

for i in $(bspc query -D); do
	color=${white}
	size="3072"
	spacing="1536"
	[[ "$i" == "$(bspc query -D --desktop focused)" ]] && color=${blue} && size="5120" && spacing="768"
	rise="$((5120 - ($size - 2048) / 4))"
	padding="<span letter_spacing='$spacing'> </span>"
	desk_str+="  $padding<span size='$size' rise='$rise' color='${color}'></span>$padding"
done

echo -n "$desk_str "
