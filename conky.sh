#!/bin/bash
conky -c ~/.config/conky/conky_left.conf -d &

~/kool/programming/c/birthdays/birthdays_final -u7 > /tmp/bdays.txt
~/kool/programming/c/birthdays/birthdays_final -d > /tmp/today.txt

conky -c ~/.config/conky/conky_lb.conf -d &
conky -c ~/.config/conky/conky_rb.conf -d &
# conky -c ~/.config/conky/conky_bottom.conf -d &
conky -c ~/.config/conky/conky_right.conf -d &
conky -c ~/.config/conky/conky_2ndmon.conf -d &
~/scripts/daily_for_conky.sh 
exit
