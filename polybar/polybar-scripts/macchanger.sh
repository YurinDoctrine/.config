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
	IFACE=$(cat ~/.config/polybar/polybar-scripts/iface)
	if [ "$IFACE" ]; then
		doas macchanger -a $IFACE >/dev/null
		doas sv restart wpa_supplicant >/dev/null && doas sv restart dhcpcd >/dev/null
		rm ~/.config/polybar/polybar-scripts/iface >/dev/null
	fi
	echo ''
fi
