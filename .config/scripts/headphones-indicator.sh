#!/usr/bin/env bash


is_headphone_plugged_in=$(amixer contents | rg -SU 'headphone jack.*\n.*\n.*values=on')
bluetooth_connected_devices=$(bluetoothctl devices Connected | awk '{print $2}' | xargs -I % bluetoothctl info % | grep -i icon | awk '{print $2}')

if echo "$bluetooth_connected_devices" | grep -q "audio-headset"; then
    format_txt+=" "
elif echo "$bluetooth_connected_devices" | grep -q "audio-headphones"; then
    format_txt+=" "
fi

if [ "$is_headphone_plugged_in" != "" ]; then
    format_txt+=" "
fi

echo "$format_txt"
