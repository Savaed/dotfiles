#!/usr/bin/env bash


work_period=$1
notification_title=$3
notification_body=$4

case $2 in
    *"m")
        x="${2%m}"
        break_secods=$((x * 60))
        ;;
    *"h")
        x="${2%h}"
        break_secods=$((x * 60 * 60))
        ;;
    *"s")
        break_secods=$2
        ;;
    *)
        break_secods=$2
        ;;
esac

update_interval=$(awk "BEGIN {printf \"%.2f\" , $break_secods / 100.0}" )
timeout=$(awk "BEGIN {printf \"%.0f\" , ($update_interval + 1 ) * 1000}" )
# echo $update_interval

while true;
do
    break_tmp=$break_secods
    i=100

    sleep "$work_period" 
    echo -e "\a"

    while [ "$i" -gt 0 ];
    do
        # breake_min=$((break_secods / 60)) 
        # breake_seconds=$((break_secods % 60)) 

        # Compute remaining minutes and strip numbers after . so 1.23 min -> 1 min
        remaining_min=$(  awk "BEGIN {printf \"%.2f\" , $break_tmp / 60}" )
        remaining_min="${remaining_min%.*}"

        # Compute remaining seconds and strip numbers after . so 1.23 s -> 1 s
        remaining_sec=$(  awk "BEGIN {printf \"%.2f\" , $break_tmp % 60}" )
        remaining_sec="${remaining_sec%.*}"

        dunstify "$notification_title" "$notification_body przez $((break_secods / 60)) min\n\nPozostało: $remaining_min min $remaining_sec s" --replace 8982377 --hints int:value:"$i" --icon /usr/share/icons/Yaru/32x32/apps/clock-app.png --timeout "$timeout"
        ((i--))
        break_tmp=$(  awk "BEGIN {printf \"%.2f\" , $break_tmp - $update_interval }" )
        # break_tmp=$((break_tmp - update_interval))
        sleep "$update_interval"
    done
done
