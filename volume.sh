#!/bin/bash
ICON_PATH="/usr/share/icons/Adwaita/32x32"
VAL=`pactl get-sink-volume @DEFAULT_SINK@ | head -n1| awk -F/ '{print $2}'| sed 's/%//g;s/ //g'`

case "$1" in
    -echo) echo $VAL && exit
	   ;;
    -inc) VAL=$(($VAL+$2))
	  ;;
    -dec) VAL=$(($VAL-$2))
	  ;;
    -set) VAL=$(($2))
	  ;;
    -toggle) pactl set-sink-mute @DEFAULT_SINK@ toggle
	  ;;
    *) echo "Invalid Argument"
esac

if [ $VAL -lt 0 ]
then
    VAL=0
fi

if [ $VAL -gt 100 ]
then
    VAL=100
fi

pactl set-sink-volume @DEFAULT_SINK@ "$VAL%";

MUTE=`pactl get-sink-mute @DEFAULT_SINK@`
if [[ "$MUTE" == *"yes"* ]];
then
    notify-send "Audio Volume" "MUTE ($VAL)" -h int:value:0 -h string:x-dunst-stack-tag:volume -i "$ICON_PATH/devices/audio-headphones.png" --urgency=LOW && echo "MUTE ($VAL)">/tmp/volume && exit
else
    notify-send "Audio Volume" "$VAL" -h int:value:"$VAL" -h string:x-dunst-stack-tag:volume -i "$ICON_PATH/devices/audio-headphones.png" --urgency=LOW && echo $VAL>/tmp/volume && exit
fi
