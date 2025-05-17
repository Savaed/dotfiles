#!/usr/bin/env bash


# current_filter=$(hyprshade current)
#
# if [ "$current_filter" = "blue-light-filter" ];then
#     echo "󰃝 "
# fi

if pgrep --exact hyprsunset > /dev/null; then
    echo "󰃝 "
fi
