#!/bin/python

import psutil
import time

log_file = "./data/battery.log"
bat = psutil.sensors_battery()
if bat.percent < 100.0:
    print('Battery is not full')
    exit(0)

perc = input("Enter % to log:")
with open(log_file,"a") as w:
    w.write(f'{time.time()} {perc}\n')
print('Done')

print('All Logs:')
with open(log_file,"r") as r:
    print(r.read())
