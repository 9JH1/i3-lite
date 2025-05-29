#!/bin/bash 
source "$HOME/.cache/wal/colors.sh"
source "$HOME/.config/i3/config.sh"
read -r -d '' DUNSTRC << EOM
[global]
font = MonaspiceRN NFM $dpi
markup = full
format = "<b>%s</b>\n<b>%b</b>"
icon_position = left
icon_path = /usr/share/icons/
max_icon_size = 64
show_indicators = false
separator_height = 2
padding = 2
frame_width = 4
separator_color = frame
shrink = yes
mouse_left_click = do_action
mouse_middle_click = close_current
mouse_right_click = close_current
width = 400
progress_bar = true
progress_bar_min_width = 300
offset = (15,15)
origin = bottom-right
[urgency_low]
foreground = "${color3}"
background = "${color0}"
frame_color = "${color4}"

[urgency_normal]
foreground = "${color3}"
background = "${color0}"
frame_color = "${color4}"

[urgency_critical]
foreground = "#ffffff"
background = "#ff5050"
frame_color = "#ff0000"
EOM
killall -q dunst
dunst_config_file=$(mktemp)
echo "$DUNSTRC" >  $dunst_config_file
echo "starting dunst"
dunst -config "$dunst_config_file" -print > ~/.config/i3/logs/dunst.log.txt & 
notify-send "Changed Wallpaper"
