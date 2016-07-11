#!/usr/bin/zsh

source /home/tyler/bin/yabar_scripts/global.sh

vol=$(awk -F"[]%[]" '/dB/ { print $2 }' <(amixer sget Master))
volume_color=$gray
[[ "$(awk -F"[][]" '/dB/ { print $6 }' <(amixer sget Master))" == "off" ]] && volume_color=${dull}
echo -n "  <span color='${volume_color}'>${vol}</span><span weight='light' color='${dull}'>%</span> "
