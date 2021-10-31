#!/usr/bin/env bash

CURR_PATH=$HOME
COMMAND=$(dmenu_path | dmenu -i -p "COMMAND")

while :
do
    NEW_PATH=$(find $CURR_PATH/ -maxdepth 1 | dmenu -i -p "$COMMAND" -l 20)
    if [[ -z "$NEW_PATH" ]];
    then
	break
    fi
    CURR_PATH=$NEW_PATH
    if [[ ! -d $CURR_PATH ]]; # || [[ -z $NEW_PATH]];
    then
	break
    fi
done

$COMMAND $CURR_PATH

