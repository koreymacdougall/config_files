# remap caps to escape <3 vim
xmodmap .Xmodmap
# using xkbmap may be redundant...
setxkbmap -option "caps:escape"
# running WM after remapping keys seems to work better
exec i3
