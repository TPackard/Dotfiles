#!/usr/bin/zsh

source ~/bin/yabar_scripts/global.sh

vol=$(awk -F"[]%[]" '/dB/ { print $2 }' <(amixer sget Master))
volume_color=$white
[[ "$(awk -F"[][]" '/dB/ { print $6 }' <(amixer sget Master))" == "off" ]] && volume_color=${dull}
echo -n "<span rise='1024' color='${volume_color}'>${vol}</span><span rise='1024' weight='light' color='${dull}'>%</span>"
