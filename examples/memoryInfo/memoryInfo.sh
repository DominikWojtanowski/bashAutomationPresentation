#!/bin/bash

howMuchMemoryIsUsed=$(df | grep "^/dev/" | awk '{print $5}' | tr -d '%' | awk '{s += $1} END {print s}')
if [[ howMuchMemoryIsUsed -gt 80 ]]; then
    notify-send "Warning!" "Uzyto zbyt duzo miejsca na dysku!!!"
else
    notify-send "Stan dobry" "Nie uzywasz zbyt duzej ilosci miejsca na dysku"
fi
