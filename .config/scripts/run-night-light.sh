#!/usr/bin/env bash


pipe=/tmp/night-light.pipe

if [ ! -p "$pipe" ];then
    mkfifo $pipe
fi

wlsunset -l 49.7 -L 21.8 -t 3400 > "$pipe"
