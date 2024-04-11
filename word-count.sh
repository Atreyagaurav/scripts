#!/usr/bin/env bash
notify-send "Text Counts" "$(xclip -o -selection primary | wc | awk '{print $1,"lines",$2,"words",$3,"chars"}')"
