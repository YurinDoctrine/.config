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
        echo -e "$(xdotool getwindowfocus getwindowname | rev | cut -c 1-48 | rev) " ;
        ;;
esac
