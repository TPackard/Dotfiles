#!/usr/bin/zsh

source /home/tyler/bin/yabar_scripts/global.sh

info="$(acpi -b)"
percent="$(echo ${info} | cut -d, -f2 | cut -d "%" -f1)"

# Set dot green for full, yellow for charging, and red for discharging
state=${green} #${dull}
if [[ $info == *"Full"* ]]; then
	state=${green}
elif [[ $info == *"Charging"* ]]; then
	if [[ $info == *"100%"* ]]; then
		state=${green}
	else
		state=${yellow}
	fi
elif [[ $info == *"Discharging"* ]]; then
	state=${red}
fi

echo -n "    <span size='4096' rise='5120' color='${state}'></span> $percent<span weight='light' color='${dull}'>%</span>"
