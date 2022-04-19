#!/usr/bin/sh

updates() {

        list_upgradeable=$(apt list --upgradeable -qq | cut -d ' ' -f 2 | wc -l)
        if [ "$list_upgradeable" -gt "0" ]; then
            echo -e "[$list_upgradeable]"
        else
            echo "" >/dev/null
        fi
}

upgrade() {
    DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical cbpp-gksudo xterm -e 'apt-get -yy dist-upgrade' 2>&1 >/dev/null && echo ""
}

case "$1" in
    --upgrade)
        upgrade
        ;;
    *)
        updates
        ;;
esac
