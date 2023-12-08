alias sudo='doas'
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- || bash
