#!/usr/bin/zsh

source ~/bin/yabar_scripts/global.sh

bat_status="$(cat /sys/class/power_supply/BAT0/status)"
percent="$(cat /sys/class/power_supply/BAT0/capacity)"

# Set dot green for full, yellow for charging, and red for discharging
state=${green} #${dull}
if [[ $bat_status == "Full" ]]; then
	state=${green}
elif [[ $bat_status == "Charging" ]]; then
	if [[ $bat_status == "100" ]]; then
		state=${blue}
	else
		state=${yellow}
	fi
elif [[ $bat_status == "Discharging" ]]; then
	state=${red}
fi

echo -n "<span size='3072' rise='2048' color='${state}'></span> <span rise='1024'>$percent</span><span rise='1024' weight='light' color='${dull}'>%</span>"
