if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias sudo='doas'

set -U fish_greeting

if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx --
    end
end
