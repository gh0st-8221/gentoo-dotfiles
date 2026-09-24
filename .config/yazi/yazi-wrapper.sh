#!/bin/bash
multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"

[ -z "$path" ] && path="$HOME"

if [ "$directory" = "1" ]; then
    alacritty -e yazi "$path" --cwd-file="$out"
else
    alacritty -e yazi "$path" --chooser-file="$out"
fi
