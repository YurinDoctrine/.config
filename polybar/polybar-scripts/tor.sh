#!/usr/bin/sh

_switch() {
	if [[ "$(ip link | grep 'UP mode' | wc -l)" -gt 0 ]] && [[ "$(curl -s https://check.torproject.org/api/ip | grep -e 'True' -e 'true')" ]]; then
		doas /root/.local/bin/tor-router stop
	elif [[ "$(ip link | grep 'UP mode' | wc -l)" -gt 0 ]] && [[ "$(curl -s https://check.torproject.org/api/ip | grep -e 'False' -e 'false')" ]]; then
		doas /root/.local/bin/tor-router start
	fi
}

case "$1" in
	switch)
		_switch
		;;
	*)
		if [[ "$(ip link | grep 'UP mode' | wc -l)" -gt 0 ]] && [[ "$(curl -s https://check.torproject.org/api/ip | grep -e 'True' -e 'true')" ]]; then
			echo -e "\uf023"
		elif [[ "$(ip link | grep 'UP mode' | wc -l)" -gt 0 ]] && [[ "$(curl -s https://check.torproject.org/api/ip | grep -e 'False' -e 'false')" ]]; then
			echo -e "\uf13e"
		else
			echo ''
		fi
		;;
esac
