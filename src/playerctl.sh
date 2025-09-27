#!/bin/bash
source ~/.config/i3/src/i3.sh

out="<span foreground='$bcolor5' bgcolor='$bcolor6'>$i</span>"	
out+="<span bgcolor='$bcolor5'>"

if [[ "$(playerctl metadata --format '-' 2>/dev/null)" == *-* ]]; then
	raw_title=$(playerctl metadata --format '{{ title }}')
	title=$(echo "$raw_title" | awk '{if(length > 25) printf "%.25s...\n", $0; else print}')
	out+=" "
	out+="$title "
	
	if [ $(playerctl status) == "Playing" ]; then
		out+=""
	else 
		out+=""
	fi

else 
	out+="󰝛 "
fi
out+="</span>"
echo "$out"
