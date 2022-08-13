#!/usr/bin/sh

get_window() {
  xdotool windowactivate getactivewindow ;
}
xdotool getactivewindow getwindowname ;

case "$1" in
    --get)
        get_window
        ;;
esac
