#!/bin/bash
is_video() {
	local file="$1"
	video_extensions="|gif|mp4|mkv|avi|mov|wmv|flv|webm|mpeg|mpg|m4v|3gp"
	if echo "$file" | grep -i -E "\.($video_extensions)$"; then return 0; fi
	return 1;
}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"
TMP_FILE="/tmp/.wallpaper"
touch "$TMP_FILE"
wall="" 

killall motionlayer &>/dev/null
if [ ! -d "$WALLPAPER_DIR" ];then
	echo "$WALLPAPER_DIR not valid"
	exit 
fi 

# parse arguments
if [[ "$1" = "--custom" ]];then	 wall="$2";
elif [[ "$1" = "--preserve" ]];then wall=$(cat "$TMP_FILE");
else wall="$(find -L "$WALLPAPER_DIR" -type f | grep -v ".git" | shuf -n 1)"
fi 


# handle file type
echo "$wall" > "$TMP_FILE"
if is_video "$wall"; then
	if ! command -v motionlayer &> /dev/null;then 
		echo "Motionlayer Binary not found, trying --preserve";
		$SCRIPT_DIR/wal.sh --preserve
		exit 
	fi 


	touch /tmp/.frame.jpg
	motionlayer --path "$wall" --frame-out "/tmp/.frame.jpg" & 		
	sleep 1
	wall="/tmp/.frame.jpg"
	echo "$wall" > "$TMP_FILE"
fi 

# set wallpaper 
echo "Using image: $wall"
wal -i "$wall" -n -q
feh --bg-fill "$wall"
pkill -term i3bar  

# dependancys
"$SCRIPT_DIR/dunst.sh" &
i3bar -b bar-0 &
i3bar -b bar-1 & 
wait
