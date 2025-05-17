#!/usr/bin/env bash

response=$(curl 'https://api.open-meteo.com/v1/forecast?latitude=49.69&longitude=21.77&daily=sunrise%2Csunset&timezone=auto&forecast_days=1&timeformat=unixtime')
sunrise=$(echo "$response" | jq -r '.daily.sunrise[0]')
sunset=$(echo "$response" | jq -r '.daily.sunset[0]')

sunrise=$(date --date @"$sunrise" +'%H:%M:%S')
sunset=$(date --date @"$sunset" +'%H:%M:%S')

sed -i "s/\(OnCalendar=\*-\*-\*\).*/\1 $sunrise $sunset Europe\/Warsaw/" /etc/systemd/system/night-light.timer
# sed -i "s/\(end_time\).*/\1 = $sunrise/" ~/.config/hypr/hyprshade.toml

# hyprshade install
systemctl --user enable --now night-light.timer
# hyprshade auto



