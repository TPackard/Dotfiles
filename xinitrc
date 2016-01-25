xrdb ~/.Xresources

# Set the default cursor to pointer instead of X
xsetroot -cursor_name left_ptr&
# Set background color
hsetroot -solid '#2C3E50'

#compton -b --sw-opti &
exec runbar.sh &
exec rofi &
sxhkd &
exec bspwm &
exec ~/bin/dynamic_bspwm.sh
