#!/usr/bin/env python
import pyperclip as pc
import time
import sys

primary = False
if '-p' in sys.argv:
    primary = True

_, paste = pc.determine_clipboard()

clip = paste(primary=primary)

try:
    while True:
        new_clip = paste(primary=primary)
        if clip != new_clip:
            clip = new_clip
            print(clip)
        time.sleep(0.1)
except KeyboardInterrupt:
    pass
