#!/usr/bin/sh

connect() {
	cbpp-gksudo xterm -e 'connectvpn --start'
}

case "$1" in
    --connect)
        connect
        ;;
    *)
		if [[ $(ip link | grep 'UP mode' | wc -l) -gt 0 ]]; then
			[[ $(ip link | grep -i 'tun' | wc -l) -gt 0 ]] && echo 'VPN: Connected' || echo 'Connect VPN'
		else
			echo ''
		fi
        ;;
esac
