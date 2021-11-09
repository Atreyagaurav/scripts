#!/usr/bin/env bash

CURR_PATH=$HOME
COMMAND=$(dmenu_path | dmenu -i -p "COMMAND")
ARGS=$( echo | dmenu -p "Args:" )

$COMMAND $ARGS
