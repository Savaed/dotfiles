#!/usr/bin/env bash

WALLPAPERS_DIR=$HOME/wallpapers
WALLPAPER_BLUR_CACHE_FILE=$HOME/.cache/wallpaper-blurred.png
WALLPAPER_CACHE_FILE=$HOME/.cache/wallpaper.png

if [ ! -d "$WALLPAPERS_DIR" ]; then
    exit 1
fi

if [ "$1" = "random" ]; then
    wallpaper_filename=$(ls "$WALLPAPERS_DIR" | sort --random-sort | head -1)
    wallpaper="$WALLPAPERS_DIR/$wallpaper_filename"
elif [ -f "$1" ]; then
    wallpaper="$1"
fi

wallust run "$wallpaper" --skip-sequences
active_monitor=$(hyprctl monitors | grep Monitor | awk '{print $2}')

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$wallpaper"
hyprctl hyprpaper wallpaper "$active_monitor,$wallpaper"

# cp "$wallpaper" "$WALLPAPER_CACHE_FILE"
convert "$wallpaper" "$WALLPAPER_CACHE_FILE"
convert "$wallpaper" -scale 30% -blur 20x4 -resize 200% "$WALLPAPER_BLUR_CACHE_FILE"
