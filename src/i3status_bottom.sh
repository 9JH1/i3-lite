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

disk "/" {
	format = " %used -> %free"
	prefix_type = binary
}

volume master {
	format = "<span foreground='$color_bad'>󰕾 %volume</span>"
  format_muted = "<span foreground='$color_good'>󰖁 %volume</span>"
  device = "default"
  mixer = "Master"
  mixer_idx = 0
}

cpu_usage {
	format = "<span> %usage</span>"
	max_threshold = 75
	degraded_threshold = 50
	format_above_threshold = "<span> %usage</span>"
}

memory {
  format = "<span>  %percentage_used</span>"
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
