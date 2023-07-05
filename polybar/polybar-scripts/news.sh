#!/usr/bin/sh

start_newsboat() {
  exec kitty newsboat -r
}

case "$1" in
    --start_newsboat)
        start_newsboat
        ;;
    *)
        main() {
            counter=1
            while [ $counter -le 5 ]
            do
                news_title=$(curl -s https://www.cnbc.com/id/100727362/device/rss/rss.html | xmlstarlet sel -t -m '//item' -v 'title' -n | head -n5 | awk 'NR=='$counter'')
                news_title="${news_title} . "
                title_lenght=${#news_title}
                lenght_count=(${title_lenght}*3)
                display_width=32
                if [ $title_lenght -gt $display_width ]; then
                    while [ $lenght_count -gt 0 ]
                    do
                        display_title="${news_title:0:$display_width}"
                        echo $display_title
                        sleep 0.5
                        news_title="${news_title:1}${news_title:0:1}"
                        ((lenght_count--))
                    done
                else
                    echo $news_title
                    sleep 60s
                fi
                ((counter++))
	    done
            echo "" >/dev/null
            main
        }
        main
        ;;
esac
