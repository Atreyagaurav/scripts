#!/usr/bin/env bash
# Script to play sounds according to the notification type.

# script appname summary body icon urgency
AUDIO_PATH=/usr/share/sounds/freedesktop/stereo/

case $1 in
    MPV) echo "MPV"
	 ;;
    "Email Check") mpv --no-config --quiet --really-quiet $AUDIO_PATH/phone-incoming-call.oga
		   ;;
    *)
	case $5 in
	    CRITICAL) mpv --no-config --quiet --really-quiet  $AUDIO_PATH/bell.oga
		      ;;
	    NORMAL) mpv --no-config --quiet --really-quiet  $AUDIO_PATH/message-new-instant.oga
		    ;;
	    LOW) mpv --volume=30 --no-config --quiet --really-quiet  $AUDIO_PATH/message.oga
		 ;;
	esac;;
esac
