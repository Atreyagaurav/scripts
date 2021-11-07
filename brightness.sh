#!/bin/bash


VAL=$(cat /sys/class/backlight/intel_backlight/brightness)
VAL_MAX=$(cat /sys/class/backlight/intel_backlight/max_brightness)
PERC=$((VAL*100/VAL_MAX))

case $1 in
    -echo) echo $PERC && exit
	  ;;
    -inc) PERC=$(($PERC+$2))
	  ;;
    -dec) PERC=$(($PERC-$2))
	  ;;
    -set) PERC=$(($2))
	  ;;
    *) echo "invalid argument"
esac


if [ $PERC -lt 1 ]
then
    PERC=1
fi

if [ $PERC -gt 100 ]
then
    PERC=100
fi

VAL=$(($VAL_MAX*$PERC/100))
# && makes it so that the notification.sh is not sent if the operation
# fails
echo $VAL>/sys/class/backlight/intel_backlight/brightness && notify-send brightness $PERC% -h int:value:$PERC -i /usr/share/icons/Adwaita/32x32/status/display-brightness-symbolic.symbolic.png -h string:x-dunst-stack-tag:brightness --urgency=LOW && echo $PERC>/tmp/brightness
