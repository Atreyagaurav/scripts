#!/usr/bin/env python
import pyperclip as pc
import time

clip = pc.paste()
# use primary selection to avoid even having to use Ctrl+C
try:
    while True:
        if clip != pc.paste():
            clip = pc.paste()
            print(clip)
        time.sleep(0.1)
except KeyboardInterrupt:
    pass
