#!/usr/bin/sh

get_window() {
  xdotool windowactivate "$(xdotool getactivewindow)" >> /dev/null ;
}

case "$1" in
    --get)
        get_window
        ;;
    *)
        xdotool getwindowfocus getwindowname ;
        ;;
esac
