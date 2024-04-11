#!/usr/bin/env bash

# imagemagic has a cute little command for importing screen into a file
import -colorspace gray /tmp/screenshot.png
mogrify /tmp/screenshot.png -color-threshold "100-200"
# extra magic to invert if the average pixel is dark
details=`convert /tmp/screenshot.png -resize 1x1 txt:-`
total=`echo $details | awk -F, '{print $4}'`
value=`echo $details | awk '{print $7}'`
darkness=$(( ${value#_(%_)} * 100 / $total ))
if (( $darkness < 50 )); then
   mogrify -negate /tmp/screenshot.png
fi

# now run the OCR
text=`tesseract /tmp/screenshot.png -`
echo $text | xclip -selection c
notify-send OCR-Screen "$text"
