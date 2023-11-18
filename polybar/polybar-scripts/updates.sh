#!/usr/bin/sh

updates() {
        doas pacman -Syw >/dev/null
        list_upgradeable=$(pacman -Qu | wc -l)
        if [ "$list_upgradeable" -gt "0" ]; then
            echo -e "[$list_upgradeable]"
        else
            echo ''
        fi
}

upgrade() {
    $(xterm -e 'doas pacman -Syyuu;flatpak update' && polyrestart)
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
