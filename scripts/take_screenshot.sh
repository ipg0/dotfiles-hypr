#!/bin/bash

FILE=$(xdg-user-dir PICTURES)/Screenshots/$(date +'Screenshot-%Y-%m-%d-%H%M%S.png')

slurp -b 0000008f -c ffffffff | grim -g - $FILE
wl-copy < $FILE
