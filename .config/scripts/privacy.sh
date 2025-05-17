#!/usr/bin/env bash


pw_dump=$(pw-dump)

audio_streams=$(echo "$pw_dump" | jq '[.[] | select(.info.props."media.class"=="Stream/Input/Audio")]')
video_streams=$(echo "$pw_dump" | jq '[.[] | select(.info.props."media.class"=="Stream/Input/Video")]')

is_mic_plugged_in=$(amixer contents | rg -SU 'mic.*\n.*\n.*values=on')

is_mic_mutted=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep --ignore-case muted)

bluetooth_connected_devices=$(bluetoothctl devices Connected | awk '{print $2}' | xargs -I % bluetoothctl info % | grep -i icon | awk '{print $2}')
is_mic_bluetooth_connected=$(echo "$bluetooth_connected_devices" | grep "audio-headset")

format_txt=""
tooltip_txt=""

audio_using_apps=$(echo "$audio_streams" | jq -r .[].info.props.\"application.name\")

if [ "$audio_using_apps" != "" ] ; then  
    if [ "$is_mic_plugged_in" ] || [ "$is_mic_bluetooth_connected" != "" ]; then
        tooltip_txt+="$audio_using_apps "
        if [ "$is_mic_mutted" != "" ]; then
            format_txt+="  "
        else
            format_txt+=" "
        fi
    fi
fi

video_using_apps=$(echo "$video_streams" | jq -r .[].info.props.\"media.name\")

if [ "$video_using_apps" != "" ]; then
    tooltip_txt+="$video_using_apps "

    sources=$(echo "$pw_dump" | jq -r '.[] | select(.info.props."media.class"=="Video/Source").info.props."node.name"')

    if [[ "$sources" = *"xdg-desktop-portal"* ]];then
        format_txt+="󰹑 "
    fi

    if [[ "$sources" = *"v4l2"* ]]; then
        format_txt+="  "
    fi
fi

    # video_streams_sources_ids=$(echo "$video_streams" | jq -r .[].info.props.\"node.target\")
    #
    #
    # for id in $video_streams_sources_ids
    # do 
    #     source=$(echo "$video_streams" | jq select(.id=="$id").info.props.\"node.name\")
    #
    #     if [[ "$source" != *"xdg-desktop-portal"* ]];then
    #         format_txt+="󰹑  "
    #     fi
    #
    #     if [[ "$source" = *"v4l2"* ]]; then
    #         format_txt+="  "
    #     fi
    #
    # done
    #

tooltip_txt=$(echo "$tooltip_txt" | tr '[:upper:]' '[:lower:]' | tr " " "\n" | sort -u | xargs | sed 's/ /\\n/g')
format_txt=$(echo "$format_txt" | xargs | sed 's/ /  /g')

echo "{ \"text\": \"$format_txt\", \"tooltip\": \"$tooltip_txt\"}"

# WARN: nie dziala dla udostepniania przez przegladarke (działa jak się udostępnia okno lub ekran, nie działa na taby przegladarki)
# pw-dump | jq '.[] | select(.info.props."media.class"=="Video/Source").info.props."node.name"'
# "v4l2_input.pci-0000_00_14.0-usb-0_1_1.0"
# "xdg-desktop-portal-hyprland"
