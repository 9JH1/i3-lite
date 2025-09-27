#!/bin/bash
source ~/.config/i3/src/i3.sh

read -r -d '' tmp << EOM
general {
	colors = true
  interval = 5
	markup = "pango"
	output_format = "i3bar"
	separator = default
	color_degraded = "$color_degraded"
	color_degraded = "$color_degraded"
	color_degraded = "$color_degraded"
}

order += "wireless _first_"
order += "battery all"
order += "load"
order += "tztime local"

wireless _first_ {
	format_up = "<span foreground='$bcolor4' bgcolor='$bcolor5'>$i</span><span foreground='$bcolor4'>󰖩 %quality</span>"
  format_down = "<span foreground='$bcolor4' bgcolor='$bcolor5'>$i</span><span bgcolor='$bcolor4'>󰖪 No Internet</span>"
} 

battery all {
  format = "<span foreground='$bcolor3' bgcolor='$bcolor4'>$i</span><span foreground='$color_degraded' bgcolor='$bcolor3'>󰁹 %percentage</span>"
  format_down = "<span foreground='$bcolor3' bgcolor='$bcolor4'>$i</span><span foreground='$color_degraded' bgcolor='$bcolor3'>󰁹 No battery</span>"
	low_threshold = 30
	threshold_type = percentage
}

load {
  format = "<span foreground='$bcolor2' bgcolor='$bcolor3'>$i</span><span bgcolor='$bcolor2'> %1min</span>"
	max_threshold = "2.0"
}

tztime local {
	format = "<span foreground='$bcolor1' bgcolor='$bcolor2'>$i</span><span bgcolor='$bcolor1'>%l:%M, %d/%m</span>"
}

EOM

tmp2=$(mktemp --suffix=".conf")
echo "$tmp" >> "$tmp2"
i3status -c "$tmp2" \
	| python /home/$USER/.config/i3/src/i3status.py "/home/$USER/.config/i3/src/playerctl.sh" \
	| python /home/$USER/.config/i3/src/i3status.py "/home/$USER/.config/i3/src/notify.sh"
