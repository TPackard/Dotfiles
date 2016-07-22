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

echo -n "    <span size='4096' rise='5120' color='${state}'></span> $percent<span weight='light' color='${dull}'>%</span>"
