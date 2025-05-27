#!/bin/bash
if [[ "$(playerctl metadata --format '-' 2>/dev/null)" == *-* ]]; then
	raw_artist=$(playerctl metadata --format '{{ artist }}')
	raw_title=$(playerctl metadata --format '{{ title }}')

	# Shorten to 10 chars max with ...
	artist=$(echo "$raw_artist" | awk '{if(length > 20) printf "%.20s...\n", $0; else print}')
	title=$(echo "$raw_title" | awk '{if(length > 20) printf "%.20s...\n", $0; else print}')

	echo -e "  $artist - $title "
	if [ $(playerctl status) == "Playing" ]; then
		echo ""
	else 
		echo ""
	fi

else 
	echo "󰝛 "
fi

