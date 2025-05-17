#!/usr/bin/env bash


pid=$(pidof wlsunset)
echo "$pid"

sudo strace -p "$pid" -e write | while IFS= read -r line
do
    is_temp_set_to_low=$(echo "$line" | grep 'setting temperature to 3400')
    echo "$is_temp_set_to_low"
done
