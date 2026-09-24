if [[ "$(tty)" == "/dev/tty1" ]]; then
    export XDG_CURRENT_DESKTOP=ghostwm
    export XDG_SESSION_TYPE=x11
    exec startx
fi
