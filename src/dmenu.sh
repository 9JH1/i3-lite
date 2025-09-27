#!/bin/bash
source ~/.cache/wal/colors.sh
source ~/.config/i3/src/i3.sh

if [[ ! -n "$1" ]];then 
	dmenu_run -fn "Mononoki Nerd Font:size=$((dpi-5))" -nb "$color5" -nf "$color1" -sb "$color2" -sf "$color5" -h $i3bar_height
else
	if [[ -n $2 ]];then 
		echo "$2" | dmenu -i -l 30 -p "$1" -fn "Mononoki Nerd Font:size=$((dpi-5))" -nb "$color5" -nf "$color1" -sb "$color2" -sf "$color5" -h $i3bar_height
		exit 
	fi 

	echo | dmenu -p "$1" -fn "Mononoki Nerd Font:size=$((dpi-5))" -nb "$color5" -nf "$color1" -sb "$color5" -sf "$color2" -h $i3bar_height
fi
