#!/usr/bin/env bash

counter=1
while [ $counter -le 5 ]
do
	news_title=$(curl -s https://www.cnbc.com/id/100727362/device/rss/rss.html | xmlstarlet sel -t -m '//item' -v 'title' -n | head -n5 | awk 'NR=='$counter'')
	news_description=$(curl -s https://www.cnbc.com/id/100727362/device/rss/rss.html | xmlstarlet sel -t -m '//item' -v 'description' -n | head -n5 | awk 'NR=='$counter'')

	notify-send -t 0 "$news_title" "$news_description" -u normal -i notification-message-im
	echo ""
	((counter++))
done
