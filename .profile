alias sudo='doas'
alias ls='ls -h --color=auto'
alias grep='grep --color=auto'

[[ -z $DISPLAY && $TERM != 'xterm' && $XDG_VTNR -eq 1 ]] && exec startx --
[[ -z $DISPLAY && $TERM != 'xterm' && $XDG_VTNR -ne 1 ]] && bash
