#!/bin/bash
first_wall=$(find "/home/$USER/Pictures/Wallpapers" -type f  -maxdepth 3 | sort -R | head -n 1)
wal -i "$first_wall" -n -a 92 -q
"$HOME/.config/i3/src/dunst.sh" &
feh --bg-fill "$first_wall"
