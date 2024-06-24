#!/bin/sh

usb_print() {
    devices=$(lsblk -Jplno NAME,TYPE,RM,SIZE,MOUNTPOINT,VENDOR)
    output=""

    for unmounted in $(echo -e "$devices" | jq -r '.blockdevices[] | select(.rm == true) | select(.mountpoint == null) | .name'); do
        unmounted=$(echo -e "$unmounted" | tr -d "[:digit:]")
        unmounted=$(echo -e "$devices" | jq -r '.blockdevices[] | select(.name == "'"$unmounted"'") | .vendor')
        unmounted=$(echo -e "$unmounted" | tr -d ' ')

        output="\uf052"
    done

    for mounted in $(echo -e "$devices" | jq -r '.blockdevices[] | select(.rm == true) | select(.mountpoint != null) | .size'); do

        output="\uf052"
    done

    echo -e "$output"
}

case "$1" in
    --eject)
        devices=$(lsblk -Jplno NAME,TYPE,RM,MOUNTPOINT)

        for unmount in $(echo "$devices" | jq -r '.blockdevices[] | select(.rm == true) | select(.mountpoint != null) | .name'); do
            udisksctl unmount --no-user-interaction -b "$unmount"
            udisksctl power-off --no-user-interaction -b "$unmount"
        done
        ;;
    *)
        usb_print
        ;;
esac
