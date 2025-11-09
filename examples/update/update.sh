#!/bin/bash

currentSystemInfo=$(grep "^ID=" /etc/os-release)
currentSystemId=$(echo "$currentSystemInfo" | awk -F= '{print $2}')
case "$currentSystemId" in
ubuntu | debian)
    echo "System bazuje na Debianie — użyjemy APT"
    echo "Aktualizacja systemu..."
    sudo apt update && sudo apt upgrade -y
    ;;
arch | manjaro)
    echo "System bazuje na Archu — użyjemy pacman"
    echo "Aktualizacja systemu..."
    sudo pacman -Syu
    ;;
*)
    echo "Nieznany system: $systemId" echo "Nie wiem jakiego menedżera pakietów użyć."
    ;;
esac
