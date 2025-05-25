#!/bin/bash
source ~/.cache/wal/colors.sh
color_good=$color5 
color_bad=$foreground 
color_degraded=$color6

read -r -d '' tmp << EOM
general {
	separator = "  |  "
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
order += "volume master"
order += "cpu_usage"
order += "load"
order += "memory"
order += "tztime local"

wireless _first_ {
	format_up = "󰖩 %quality"
  format_down = "W: down"
}

disk "/" {
	format = "󰨣 %percentage_used/%used"
}

battery all {
  format = "<span foreground='$color_degraded'>󰁹 %percentage %remaining</span>"
	low_threshold = 30
	threshold_type = percentage
}

load {
  format = " %1min"
	max_threshold = "2.0"
}

memory {
  format = "  %percentage_used"
	threshold_degraded = 75%
	threshold_critical = 25%
}

tztime local {
	format = "%A, %l:%M (%d/%m)"
}

volume master {
	format = "<span foreground='$color_bad'>󰕾 %volume</span>"
  format_muted = "<span foreground='$color_good'>󰖁 %volume</span>"
  device = "default"
  mixer = "Master"
  mixer_idx = 0
}

cpu_usage {
	format = " %usage"
	max_threshold = 75
	degraded_threshold = 50
	format_above_threshold = " %usage"
}
EOM
tmp2=$(mktemp --suffix=".conf")
echo "$tmp" >> "$tmp2"
i3status -c "$tmp2" \
	| python /home/$USER/.config/i3/src/i3status.py "/home/$USER/.config/i3/src/playerctl.sh" \
	| python /home/$USER/.config/i3/src/i3status.py "/home/$USER/.config/i3/src/notify.sh"
