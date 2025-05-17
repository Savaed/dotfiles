#!/usr/bin/env bash

# if pgrep --exact hyprsunset > /dev/null; then
/usr/bin/killall hyprsunset || /usr/bin/hyprsunset --temperature 2000 &
