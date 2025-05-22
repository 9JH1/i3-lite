#!/bin/bash
first_wall=$(find "/home/$USER/Pictures/Wallpapers" -type f  -maxdepth 3 | sort -R | head -n 1)
export XDG_CACHE_HOME="/home/$USER/.cache"
wal -i "$first_wall" -n -a 92 -q
#xrdb -merge ~/.Xresources &
"$HOME/.config/i3/src/dunst.sh" &
source "/home/$USER/.cache/wal/colors.sh"
hex="$color3"
solid_color_ppm=$(mktemp --suffix=.ppm)
printf "P6\n1 1\n255\n\\x${hex:1:2}\\x${hex:3:2}\\x${hex:5:2}" > "$solid_color_ppm"
feh --bg-scale "$solid_color_ppm"
nitrogen --head=0 --set-zoom-fill "$first_wall"
rm -f "$solid_color_ppm"
