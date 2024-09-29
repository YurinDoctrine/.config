#!/usr/bin/env bash

news_feed=$(curl -s https://www.cnbc.com/id/100727362/device/rss/rss.html)

counter=1

while [ $counter -le 5 ]
do
	news_title=$(echo "$news_feed" | xmlstarlet sel -t -m '//item' -v 'title' -n | awk 'NR=='$counter'')
	news_description=$(echo "$news_feed" | xmlstarlet sel -t -m '//item' -v 'description' -n | awk 'NR=='$counter'')
	news_link=$(echo "$news_feed" | xmlstarlet sel -t -m '//item' -v 'link' -n | awk 'NR=='$counter'')

	notify=$(notify-send -u critical -i notification-message-im -A "open=Open URL" "$news_title" "$news_description") && [[ $notify == "open" ]] && xdg-open "$news_link" &

	echo ""

	((counter++))
done
