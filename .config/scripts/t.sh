#!/usr/bin/env bash


selected=$( find ~/wallpapers/ -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort --random-sort | while read -r rfile
do
    echo -en "$rfile\x00icon\x1f$HOME/wallpapers/${rfile}\n"
done | rofi -dmenu -i -replace -p "" -config ~/.config/rofi/config-wallpaper.rasi)

if [ ! "$selected" ]; then
    exit
fi

~/.config/scripts/setwallpaper.sh ~/wallpapers/"$selected"
