#xmodmap -e "keycode 66 = Escape"
#xmodmap -pke > ~/.xmodmap

setxkbmap -option caps:escape
xmodmap -e "clear Lock"
