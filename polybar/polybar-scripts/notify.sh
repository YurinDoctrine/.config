#!/bin/sh

case "$1" in
    --toggle)
        dunstctl set-paused toggle
        if [[ ! -e "$HOME/.config/polybar/polybar-scripts/dnd" ]]; then
            touch "$HOME/.config/polybar/polybar-scripts/dnd"
        else
            rm "$HOME/.config/polybar/polybar-scripts/dnd"
        fi
        ;;
    *)
        if [ "$(dunstctl is-paused)" = "true" ]; then
            if [[ ! -e "$HOME/.config/polybar/polybar-scripts/dnd" ]]; then
                xdotool getwindowgeometry "$(xdotool getactivewindow)" | \
                grep -q "$(xdpyinfo | grep dimensions | awk '{print $2}')" || \
                dunstctl set-paused toggle
            fi
            echo "\uf0a2"
        else
            if [[ ! -e "$HOME/.config/polybar/polybar-scripts/dnd" ]]; then
                xdotool getwindowgeometry "$(xdotool getactivewindow)" | \
                grep -q "$(xdpyinfo | grep dimensions | awk '{print $2}')" && \
                dunstctl set-paused toggle
            fi
            echo "\uf0f3"
        fi
        ;;
esac
