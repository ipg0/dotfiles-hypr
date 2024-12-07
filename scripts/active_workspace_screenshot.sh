#!/bin/bash

FILE=~/Pictures/Screenshots/$(date +'Screenshot-%Y-%m-%d-%H%M%S.png')
sleep 2
grim -o $(hyprctl activeworkspace -j | jq -r .monitor) $FILE
wl-copy < $FILE
notify-send "Screenshot taken"