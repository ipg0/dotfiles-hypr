#!/bin/bash

if pidof -q iio-hyprland; then
    killall iio-hyprland
else
    exec /usr/bin/iio-hyprland
fi