#!/usr/bin/sh

players=$(dbus-send --session --dest=org.freedesktop.DBus --type=method_call --print-reply \
    /org/freedesktop/DBus org.freedesktop.DBus.ListNames | grep org.mpris.MediaPlayer2 | awk -F'"' '{print $2}')

if [ -z "$players" ]; then
    echo ""
else
    player=$(echo -e "$players" | head -n1)
    metadata=$(dbus-send --print-reply --dest="$player" \
        /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get \
        string:'org.mpris.MediaPlayer2.Player' string:'Metadata')
    artist=$(echo -e "$metadata" | awk -F '"' '/xesam:artist/{getline; getline; print $2}')

    echo -e "${artist:0:32}"
fi
