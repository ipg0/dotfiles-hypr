#!/bin/bash

mv /home/pyro/.tmp/.wvkbd.log /home/pyro/.tmp/.wvkbd.log.1

wvkbd-mobintl --landscape-layers landscape,landscapespecial,cyrillic,landscapespecial -l simple,special,cyrillic,special -L 250 -H 250 -R 12 --hidden > /home/pyro/.tmp/.wvkbd.log