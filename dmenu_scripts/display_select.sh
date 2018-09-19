#!/bin/sh
# A dmenu script to choose monitor(s)
# Thanks to Luke Smith (again) - https://www.youtube.com/watch?v=R9m723tAurA

choices="Laptop\nBenq\nDual"

chosen=$(echo -e "$choices" | dmenu -i)

case "$chosen" in
    Laptop) xrandr --output LVDS1 --auto --output VGA1 --off;;
    Benq) xrandr --output LVDS1 --off --output VGA1 --auto;;
    Dual) xrandr --output LVDS1 --auto --output VGA1 --auto --right-of LVDS1;;
esac

feh --bg-scale "$HOME/.fehbg"
