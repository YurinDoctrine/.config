#!/usr/bin/sh

if [[ $(ip link | grep 'UP mode' | wc -l) -gt 0 ]]; then
	ip link | awk '/UP mode/ {print $2}' | tr -d ':' | tee ~/.config/polybar/polybar-scripts/iface >/dev/null 2>&1
else
	IFACE=$(cat ~/.config/polybar/polybar-scripts/iface)
	if [ "$IFACE" ]; then
		doas macchanger -a $IFACE >/dev/null 2>&1
		doas sv restart wpa_supplicant >/dev/null 2>&1 && doas sv restart dhcpcd >/dev/null 2>&1
		rm ~/.config/polybar/polybar-scripts/iface >/dev/null 2>&1
	fi
fi

blocked_count=$(rfkill list | grep -c "blocked: yes")

if [ "$blocked_count" -ge 2 ]; then
	echo "\uf072"
else
	echo ''
fi
