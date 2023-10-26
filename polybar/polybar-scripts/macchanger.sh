#!/usr/bin/sh

if [[ $(ip link | grep 'UP mode' | wc -l) -gt 0 ]]; then
	ip link | awk '/UP mode/ {print $2}' | tr -d ':' | tee ~/.config/polybar/polybar-scripts/iface >/dev/null
else
	iface=$(cat ~/.config/polybar/polybar-scripts/iface)
	doas macchanger -e $iface >/dev/null
	echo ''
fi
