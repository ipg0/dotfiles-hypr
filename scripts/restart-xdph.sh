#!/bin/bash

until /usr/lib/xdg-desktop-portal-hyprland; do
    echo "XDPH crashed with exit code $?. Respawning.." >&2
    sleep 1
done