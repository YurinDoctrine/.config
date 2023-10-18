#!/usr/bin/sh

updates() {

        list_upgradeable=$(pacman -Qu | wc -l)
        if [ "$list_upgradeable" -gt "0" ]; then
            echo -e "[$list_upgradeable]"
        else
            echo ''
        fi
}

upgrade() {
    $(cbpp-gksudo xterm -e 'pacman -Syyu' && polyrestart)
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
