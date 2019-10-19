# remap caps to escape <3 vim
xmodmap .Xmodmap


# load .Xresources
#[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xrdb -load ~/config_files/.Xresources

# remap mouse scroll direction on keypad, using xorg-xinput
# these settings for XPS13; use first 2 commands to get id & keys
#   xinput-> list devices with ids
#   xinput get-button-map {touchpad-id}
xinput set-button-map 10 1 2 3 5 4 6 7 8 9 10 11 12

# this reduces the defaut sensitivty of the trackpad
xinput set-prop "DLL0704:01 06CB:76AE Touchpad" "Synaptics Finger" 25 30 30

# these fonts were mainly for wayland, I think
FontPath /usr/share/fonts/100dpi

# set background colour to match color scheme
hsetroot -solid $bg_color

# swap caps and escape
# using xkbmap may be redundant...
setxkbmap -option "caps:escape"

# set bg as last image set with feh
source '/home/km/.fehbg'
#
# running WM after remapping keys seems to work better
# launch a console kit session and dbus
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session i3

exec i3
#exec startxfce4

