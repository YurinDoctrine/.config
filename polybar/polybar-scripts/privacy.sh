#!/usr/bin/env bash

MODULES=("snd_usb_audio" "uvcvideo" "gspca_main")

is_module_loaded() {
    lsmod | grep -q "^${1//-/_}\b"
}

print_status() {
    for module in "${MODULES[@]}"; do
        if is_module_loaded "$module"; then
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
            amixer set Capture nocap
        else
            doas modprobe -f "$module" >/dev/null
            amixer set Capture cap
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
