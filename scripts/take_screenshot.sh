#!/bin/bash

FILE=$(xdg-user-dir PICTURES)/Screenshots/$(date +'Screenshot-%Y-%m-%d-%H%M%S.png')
BUFFER=~/.tmp/slurp.buffer

slurp -c 9d37fcff > $BUFFER
# so slurp's selection border has time to disappear before screenshot is taken
sleep 1
cat $BUFFER | grim -g - $FILE
wl-copy < $FILE
