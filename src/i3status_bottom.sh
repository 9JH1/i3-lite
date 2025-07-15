#!/bin/bash
source ~/.cache/wal/colors.sh
color_good=$color5 
color_bad=$foreground 
color_degraded=$color6
font="Mononoki Nerd Font"
read -r -d '' tmp << EOM
general {
	colors = true
  interval = 5
	markup = "pango"
	output_format = "i3bar"
	color_good = "$color_good"
	color_bad  = "$color_bad"
	color_degraded = "$color_degraded"
}

order+=""
EOM

tmp2=$(mktemp --suffix=".conf")
echo "$tmp" >> "$tmp2"
i3status -c "$tmp2" \
	| python "$HOME/.config/i3/src/i3status.py" "$HOME/.config/i3/src/mac.sh" \
	| python "$HOME/.config/i3/src/i3status.py" "$HOME/.config/i3/src/hostname.sh"
