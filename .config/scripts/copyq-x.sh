#!/usr/bin/env bash


# clipboard=$(cat ~/.config/scripts/copyq.js | copyq eval - | jq .[] -r -c)

# data=$(echo "$clipboard" | jq '.[] | select(.mimetypes | contains(["image/"])) | {row, data}' -c)

# if [ ! -d /tmp/copyq/ ];then
#     mkdir /tmp/copyq/
# fi
#

# echo "$clipboard" | while read -r item
# do
#     row=$(echo "$item" | jq .row -r)
#     is_image=$(echo "$item" | jq '.mimetypes | contains(["image/"])')
#
#     if [ "$is_image" = true ];then
#         mimetype=$(copyq "read '?' $row" | head -1)
#         copyq read "$mimetype" "$row" >
#     fi
#
# done

lines=()
clipboard_size=$(copyq size)

for row in $(seq "$clipboard_size")
do 
    mimetype=$(copyq "read '?' $row" | head -1)
    
    if (echo "$mimetype" | grep '^image/');then
        copyq read "$mimetype" "$row" > "/tmp/copyq/$row"
        lines+=("\0icon\x1f/tmp/copyq/$row")
    else
        line=$(copyq read "$row")
        lines+=("$line")
    fi

done

echo "${lines[@]}"










