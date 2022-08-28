#!/usr/bin/sh

get_window() {
  xdotool windowactivate "$(xdotool getactivewindow)" ;
}
xdotool getwindowfocus getwindowname ;

case "$1" in
    --get)
        get_window
        ;;
esac
