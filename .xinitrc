# remap caps to escape <3 vim
xmodmap .Xmodmap

# using xkbmap may be redundant...
setxkbmap -option "caps:escape"

# load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# remap mouse scroll direction on keypad, using xorg-xinput
# only on physical machine; use first 2 commands to get id & keys
#xinput: list devices with ids
#xinput get-button-map {touchpad-id}
#xinput set-button-map {touchpad-id} {1 2 3 5 4 6 7}

# running WM after remapping keys seems to work better
exec i3

