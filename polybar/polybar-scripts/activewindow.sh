#!/usr/bin/sh

get_window() {
  xdotool windowactivate "$(xdotool getactivewindow)" >> /dev/null ;
}

kill_task() {
  kill "$(xdotool getactivewindow getwindowpid)" >> /dev/null ;
}

case "$1" in
    --get)
        get_window
        ;;
    --kill)
        kill_task
        ;;
    *)
        DESKTOP=$(xdotool get_desktop)
        echo -e "$((DESKTOP + 1)) / $(xdotool get_num_desktops)  $(xprop -id $(xdotool getactivewindow) | awk -F '"' '/^_OB_APP_TITLE/ {print $2}')" ;
        ;;
esac
