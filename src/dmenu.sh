#!/bin/bash
source ~/.cache/wal/colors.sh
source ~/.config/i3/src/i3.sh
if [[ ! -n "$1" ]];then 
	dmenu_run -fn "Mononoki Nerd Font:size=$((dpi_number-dpi_alt_number+2))" -nb "$color5" -nf "$color1" -sb "$color2" -sf "$color5"
else
	if [[ -n $2 ]];then 
		echo "$2" | dmenu -i -l 30 -p "$1" -fn "Mononoki Nerd Font:size=$((dpi_number-dpi_alt_number+2))" -nb "$color5" -nf "$color1" -sb "$color2" -sf "$color5"
		exit 
	fi 

	echo | dmenu -p "$1" -fn "Mononoki Nerd Font:size=$((dpi_number-dpi_alt_number+2))" -nb "$color5" -nf "$color1" -sb "$color5" -sf "$color2"
fi
