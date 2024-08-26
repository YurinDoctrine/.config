#!/usr/bin/env bash

MODULES=("snd_usb_audio" "uvcvideo" "gspca_main")

is_module_loaded() {
    lsmod | grep -q "^${1//-/_}[^ ]*"
}

print_status() {
    for module in "${MODULES[@]}"; do
        if is_module_loaded "$module" || pactl get-source-mute @DEFAULT_SOURCE@ | grep "Mute: no"; then
            echo -e "\uf06e"
            break
        else
            echo -e "\uf070"
        fi
    done
}

toggle_modules() {
    for module in "${MODULES[@]}"; do
        if is_module_loaded "$module"; then
            doas rmmod -f "$module" >/dev/null
            amixer set Capture 0% >/dev/null
            amixer set Capture nocap >/dev/null
        else
            doas modprobe -f "$module" >/dev/null
            amixer set Capture 50% >/dev/null
            amixer set Capture cap >/dev/null
        fi
    done
}

case "$1" in
    --toggle)
        toggle_modules
        ;;
    *)
        print_status
        ;;
esac
