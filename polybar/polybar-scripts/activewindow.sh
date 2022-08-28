#!/usr/bin/sh

get_window() {
  xdotool windowactivate "$(xdotool getwindowfocus)" ;
}
xdotool getactivewindow getwindowname ;

case "$1" in
    --get)
        get_window
        ;;
esac
