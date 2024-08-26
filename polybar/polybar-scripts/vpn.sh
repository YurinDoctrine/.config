#!/usr/bin/sh

connect() {
	[[ $(ip link | grep -i 'tun' | wc -l) -gt 0 ]] || xterm -e 'connectvpn --start'
}

case "$1" in
    --connect)
        connect
        ;;
    *)
		if [[ $(ip link | grep 'UP mode' | wc -l) -gt 0 ]]; then
			[[ $(ip link | grep -i 'tun' | wc -l) -gt 0 ]] && echo "Connected  \uf023" || echo "Connect  \uf023"
		else
			echo ''
		fi
        ;;
esac
