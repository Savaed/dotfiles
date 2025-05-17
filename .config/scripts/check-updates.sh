#!/usr/bin/env sh


if [ ! -x "$(command -v checkupdates)" ]; then exit 1; fi

pacman_updates=$(checkupdates | awk '{print $1}')

if [ "$pacman_updates" != "" ];then
    updates_num=$(echo "$pacman_updates" | wc -l)

    if [ "$updates_num" -lt 30 ];then
        pacman_updates=$(echo "$pacman_updates" | xargs | sed 's/ /\\n/g')
        echo "{\"text\": \" $updates_num\", \"tooltip\": \"$pacman_updates\"}"
    else
        pacman_updates=$(echo "$pacman_updates" | xargs | sed 's/ /\\n/g')
        echo "{\"text\": \" $updates_num\", \"tooltip\": \"$pacman_updates and more...\"}"
    fi
fi
