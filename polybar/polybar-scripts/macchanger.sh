#!/usr/bin/sh

blocked_count=$(rfkill list | grep -c "blocked: yes")

if [ "$blocked_count" -gt 2 ]; then
	echo "\uf072"
else
	echo ''
fi

if [[ $(ip link | grep 'UP mode' | wc -l) -gt 0 ]]; then
	ip link | awk '/UP mode/ {print $2}' | tr -d ':' | tee ~/.config/polybar/polybar-scripts/iface >/dev/null
else
	iface=$(cat ~/.config/polybar/polybar-scripts/iface)
	doas macchanger -a $iface >/dev/null
	doas sv restart wpa_supplicant
	rm ~/.config/polybar/polybar-scripts/iface
	echo ''
fi
