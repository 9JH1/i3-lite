#!/bin/bash

source ~/.config/i3/src/i3.sh
font="Mononoki Nerd Font"
read -r -d '' tmp << EOM
general {
	colors = true
  interval = 5
	markup = "pango"
	output_format = "i3bar"
	color_degraded = "$color_degraded"
	color_degraded = "$color_degraded"
	color_degraded = "$color_degraded"
}

disk "/" {
	format = "<span foreground='$bcolor10' bgcolor='$bcolor11'>$i</span><span bgcolor='$bcolor10'> %used -> %free</span>"
	prefix_type = binary
}

volume master {
	format = "<span foreground='$bcolor9' bgcolor='$bcolor10'>$i</span><span bgcolor='$bcolor9' foreground='$color_bad'>󰕾 %volume</span>"
  format_muted = "<span foreground='$bcolor9' bgcolor='$bcolor10'>$i</span><span bgcolor='$color9' foreground='$color_good'>󰖁 %volume</span>"
  device = "default"
  mixer = "Master"
  mixer_idx = 0
}

cpu_usage {
	format = "<span foreground='$bcolor8' bgcolor='$bcolor9'>$i</span><span bgcolor='$bcolor8'> %usage</span>"
	max_threshold = 75
	degraded_threshold = 50
	format_above_threshold = "<span foreground='$bcolor8' bgcolor='$bcolor9'>$i</span><span bgcolor='$bcolor8'> %usage</span>"
}

memory {
  format = "<span foreground='$bcolor7' bgcolor='$bcolor8'>$i</span><span bgcolor='$bcolor7'>  %percentage_used </span>"
	threshold_degraded = 75%
	threshold_critical = 25%
}

order+="disk /"
order += "volume master"
order += "cpu_usage"
order += "memory"
EOM

tmp2=$(mktemp --suffix=".conf")
echo "$tmp" >> "$tmp2"
i3status -c "$tmp2" \
	| python "$HOME/.config/i3/src/i3status.py" "$HOME/.config/i3/src/mac.sh"
