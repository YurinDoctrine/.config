#!/usr/bin/sh

updates() {

        list_upgradeable=$(apt-get dist-upgrade -s | grep '[0-9] upgraded' | grep -o '[0-9]' | head -n1)
        if [ "$list_upgradeable" -gt "0" ]; then
            echo -e "[$list_upgradeable]"
        else
            echo -ne "" >> /dev/null
        fi
}

upgrade() {
    DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical $(cbpp-gksudo xterm -e 'apt-get dist-upgrade' && polyrestart)
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
