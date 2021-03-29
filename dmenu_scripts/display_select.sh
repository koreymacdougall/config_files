#!/bin/sh
# A dmenu script to choose monitor(s)
# Thanks to Luke Smith (again) - https://www.youtube.com/watch?v=R9m723tAurA

choices="Laptop\nBenq\nDual"


chosen=$(echo "$choices" | dmenu -i)
# -e for echo is to recognize new lines, but it was messing up script
# keeping for posterity / troubleshooting (2021-03-29)
# chosen=$(echo -e "$choices" | dmenu -i)

case "$chosen" in
    Laptop) xrandr --output eDP1 --auto --output DP1 --off;;
    Benq) xrandr --output eDP1 --off --output DP1 --auto;;
    Dual) xrandr --output eDP1 --auto --output DP1 --auto --left-of eDP1;;
esac

sh ~/.fehbg
