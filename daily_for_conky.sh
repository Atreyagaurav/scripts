#!/usr/bin/env bash
~/github/birthdays-reminder/birthdays -u7 > /tmp/bdays.txt
~/github/birthdays-reminder/birthdays -d > /tmp/today.txt
~/github/calendar-desktop/calender-desktop > /tmp/calendar.txt 
~/github/birthdays-reminder/birthdays -r > ~/.reminder/40-birthdays.rem
# python ~/scripts/corona/summary.py
# ~/scripts/plot_corona.sh
