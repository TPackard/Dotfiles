#!/usr/bin/zsh
# I wish I didn't need this, but my laptop's brightness automatically decreases
# whenever it wakes from hibernation. This is just a quick fix.

sudo tee /sys/class/backlight/intel_backlight/brightness <<< 1808
