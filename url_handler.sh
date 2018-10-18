#!/bin/bash

# thanks to Luke Smith
# https://github.com/LukeSmithxyz

# Feed script a url.
# If an image, it will view in feh,
# if a video or gif, it will view in mpv
# if a music file or pdf, it will download,
# otherwise it opens link in browser.

ext="${1##*.}"
mpvFiles="mkv mp4 gif webm"
fehFiles="png jpg jpeg jpe"
wgetFiles="mp3 flac opus mp3?source=feed pdf"

if echo $fehFiles | grep -w $ext > /dev/null; then
 feh "$1" >/dev/null & disown
# elif echo $mpvFiles | grep -w $ext > /dev/null; then
#  mpv -quiet "$1" > /dev/null & disown
elif echo $wgetFiles | grep -w $ext > /dev/null; then
 wget "$1" >/dev/null & disown
# elif echo "$@" | grep "$vidsites">/dev/null; then
#  mpv -quiet "$1" > /dev/null & disown
else
    firefox "$1" 2>/dev/null & disown
fi
