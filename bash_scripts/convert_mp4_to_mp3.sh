#!/bin/shj

# script to convert all mp4 files to mp3 using ffmpeg

for f in `ls *.mp4`
do
    filename=$(basename -- "$f")
    echo "Converting $filename"

    basename=$(basename $f '.mp4')
    ffmpeg -i $filename "$basename.mp3"
done

#alternate way to find basename, if you don't know ext
#filename="${filename%.*}"
