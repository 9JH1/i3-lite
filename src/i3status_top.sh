#!/bin/bash
source ~/.cache/wal/colors.sh
color_good=$background
color_bad=$color3 
color_degraded=$color2
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

order += "wireless _first_"
order += "battery all"
order += "load"
order += "tztime local"

wireless _first_ {
	format_up = "<span>󰖩 %quality</span>"
  format_down = "<span>󰖪 </span>"
} 

battery all {
  format = "<span foreground='$color_degraded'>󰁹 %percentage</span>"
	low_threshold = 30
	threshold_type = percentage
}

load {
  format = "<span> %1min</span>"
	max_threshold = "2.0"
}

tztime local {
	format = "<span>%l:%M</span>"
}
EOM

tmp2=$(mktemp --suffix=".conf")
echo "$tmp" >> "$tmp2"
(i3bar --bar_id bar-1 &>/dev/null &) # strap on secondary bar
i3status -c "$tmp2" \
	| python /home/$USER/.config/i3/src/i3status.py "/home/$USER/.config/i3/src/playerctl.sh" \
	| python /home/$USER/.config/i3/src/i3status.py "/home/$USER/.config/i3/src/notify.sh"

