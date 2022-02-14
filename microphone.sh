#!/bin/bash
# combine this with volume.sh since these two are very similar.
ICON_PATH="/usr/share/icons/Adwaita/32x32"
VAL=`pactl get-source-volume @DEFAULT_SOURCE@ | head -n1| awk -F/ '{print $2}'| sed 's/%//g;s/ //g'`

case "$1" in
    -echo) echo $VAL &&  echo $VAL>/tmp/mic  && exit
	   ;;
    -inc) VAL=$(($VAL+$2))
	  ;;
    -dec) VAL=$(($VAL-$2))
	  ;;
    -set) VAL=$(($2))
	  ;;
    -toggle) pactl set-source-mute @DEFAULT_SOURCE@ toggle
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

pactl set-source-volume @DEFAULT_SOURCE@ "$VAL%";

MUTE=`pactl get-source-mute @DEFAULT_SOURCE@`
if [[ "$MUTE" == *"yes"* ]];
then
    notify-send Mic "MUTE ($VAL)" -h int:value:0 -h string:x-dunst-stack-tag:mic -i "$ICON_PATH/status/microphone-disabled-symbolic.symbolic.png" --urgency=LOW && rm /tmp/mic && exit
else
    notify-send Mic "$VAL" -h int:value:"$VAL" -h string:x-dunst-stack-tag:mic  -i "$ICON_PATH/status/microphone-sensitivity-high-symbolic.symbolic.png" --urgency=LOW && echo $VAL>/tmp/mic && exit
fi
