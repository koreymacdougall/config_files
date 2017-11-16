# remap caps to escape <3 vim
xmodmap .Xmodmap
# using xkbmap may be redundant...
setxkbmap -option "caps:escape"
# load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
# running WM after remapping keys seems to work better
exec i3

