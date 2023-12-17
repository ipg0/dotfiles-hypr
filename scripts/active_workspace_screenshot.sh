#!/bin/bash

FILE=$(xdg-user-dir PICTURES)/Screenshots/$(date +'Screenshot-%Y-%m-%d-%H%M%S.png')
sleep 2
grim -o $(hyprctl activeworkspace -j | jq -r .monitor) $FILE
wl-copy < $FILE
