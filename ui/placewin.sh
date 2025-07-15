#!/bin/bash

# handle arguments
out=$($HOME/.config/i3/ui/libs/base $@)
if [[ "$?" = "1" ]];then 
	$HOME/.config/i3/ui/libs/base $@
	exit
fi

eval set -- $out

geo_x=$1
geo_y=$2
wid_r=$3 
wid_c=$4
fnt_s=$5
prg_c=$6

echo Geo_x: $geo_x
echo Prg_c: $prg_c


# spawn st with unique identifyer
UNIQUE_TITLE="alacritty-$(date +%s%N)"
alacritty --config-file ~/.cache/wal/colors-alacritty.toml --class "floating_menu_i3" -T "$UNIQUE_TITLE" -o "window.dimensions={columns=$wid_c,lines=$wid_r}" -o "font.normal={family='Mononoki Nerd Font'}" -o "font.size = $fnt_s" -e "sh" -c "$prg_c" &

sleep 0.3
i3-msg "[class=\"floating_menu_i3\"] floating enable"
# await the st spawn
window_id=""
count=0;
while [[ "$window_id" = "" ]];do 
	
	# timeout dialog
	if [[ $count -gt 50 ]]; then 
		echo "Terminal took to long to launch"
		echo "Check your settings"
		exit
	fi

	# fetch the window id using xdotool
	window_id=$(xdotool search --name "$UNIQUE_TITLE" | head -n 1);
	# count++
	count=$((count+1))
done
echo "Found window ID: $window_id"

# set st geometry
wmctrl -i -r "$window_id" -e 0,"$geo_x","$geo_y",-1,-1
echo "finished successfully!"
