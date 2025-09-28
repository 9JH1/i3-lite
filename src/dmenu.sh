#!/bin/bash
source ~/.config/i3/src/i3.sh

if [[ ! -n "$1" ]];then 
	dmenu_run -p "Launch:" -fn "Mononoki Nerd Font:size=$font_size:weight=bold" -nb "$background" -nf "$color1" -sb "$color5" -sf "$background" -h $i3bar_height
else
	if [[ -n $2 ]];then 
		echo "$2" | dmenu -i -l 30 -p "$1" -fn "Mononoki Nerd Font:size=$font_size" -nb "$background" -nf "$color1" -sb "$color5" -sf "$background" -h $i3bar_height
		exit 
	fi 

	echo | dmenu -p "$1" -fn "Mononoki Nerd Font:size=$font_size" -nb "$background" -nf "$color1" -sb "$background" -sf "$color5" -h $i3bar_height
fi
