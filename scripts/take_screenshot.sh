#!/bin/bash

FILE=~/Pictures/Screenshots/$(date +'Screenshot-%Y-%m-%d-%H%M%S.png')
BUFFER=~/.tmp/slurp.buffer

slurp -b 9d37fc66 -c 00000000 > $BUFFER
# so slurp's selection border has time to disappear before screenshot is taken
cat $BUFFER | grim -g - $FILE
wl-copy < $FILE
