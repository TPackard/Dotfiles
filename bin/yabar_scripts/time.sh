#!/usr/bin/zsh

source ~/bin/yabar_scripts/global.sh

time_str="$(date "+%-l:%M <span weight='light' color='${dull}'>%p</span>")"
echo -n "    $time_str   "
