#!/usr/bin/sh

updates() {
        doas pacman -Syw >/dev/null
        list_upgradeable=$(pacman -Qu | wc -l)
        if [ "$list_upgradeable" -gt "0" ]; then
            echo -e "[$list_upgradeable]"
        else
            echo ""
        fi
}

upgrade() {
    $(xterm -e 'doas pacman -Syyuu --needed --disable-download-timeout;flatpak remove --unused;flatpak update;doas fwupdmgr get-devices;doas fwupdmgr refresh --force;doas fwupdmgr get-updates -y;doas fwupdmgr update -y' && polyrestart)
    updates
}

case "$1" in
    --upgrade)
        upgrade
        ;;
    *)
        updates
        ;;
esac
