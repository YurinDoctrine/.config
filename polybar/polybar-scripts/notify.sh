#!/bin/sh

case "$1" in
    --toggle)
        dunstctl set-paused toggle
		dunstctl history-pop
        ;;
    *)
        if [ "$(dunstctl is-paused)" = "true" ]; then
            echo "\uf0a2"
        else
            echo "\uf0f3"
        fi
        ;;
esac
