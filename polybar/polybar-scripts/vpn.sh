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
			[[ $(ip link | grep -i 'tun' | wc -l) -gt 0 ]] && echo "\uf023  Connected" || echo "\uf023  Connect"
		else
			echo ''
		fi
        ;;
esac
