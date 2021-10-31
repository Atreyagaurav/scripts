radio_stn=$(cat ~/scripts/config/radios.txt | dmenu -p "Choose Radio:" -l 10 | cut -d ":" -f2-)
if [ -n "$radio_stn" ]; then
mpv $radio_stn --force-window --geometry=200x100-0-20 --x11-name=__scratchpad
fi
