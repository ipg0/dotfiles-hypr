#!/bin/bash

if ! pidof -q wvkbd-mobintl; then
  /home/pyro/.config/scripts/launch_osc.sh &
  sleep 0.5
fi

kill -34 $(ps -C wvkbd-mobintl)
