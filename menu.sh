#!/usr/bin/env bash
echo $(jq -r '.scripts | .["'$(jq -r '.scripts|keys[]' \
			     ~/.config/personal/menu.json \
			      | dmenu)'"] |.script' \
     ~/.config/personal/menu.json) |sh
