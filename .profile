alias sudo='doas'
[[ -z $DISPLAY && $TERM != 'xterm' && $XDG_VTNR -eq 1 ]] && exec startx --
[[ -z $DISPLAY && $TERM != 'xterm' && $XDG_VTNR -ne 1 ]] && bash
