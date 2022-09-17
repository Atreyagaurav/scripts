#!/usr/bin/env bash
~/github/birthdays-reminder/birthdays -u7 > /tmp/bdays.txt
~/github/birthdays-reminder/birthdays -d > /tmp/today.txt
remind -s ~/.reminder/ | grep `date +"%Y/%m/%d"` | awk '{x=$3;$1=$2=$3=$4=$5="";$0=$0;$1=$1; print "["x"] "$0}' | ~/github/calendar-desktop/calender-desktop > /tmp/calendar.txt 
~/github/birthdays-reminder/birthdays -r > ~/.reminder/40-birthdays.rem
# python ~/scripts/corona/summary.py
# ~/scripts/plot_corona.sh
