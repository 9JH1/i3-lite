#!/bin/bash
source ~/.config/i3/src/i3.sh
out="<span bgcolor='$seed' foreground='$seed'>testsetsetttttttttttttttttttttttttttttttttttttttttt</span>"
out+="<span foreground='$bcolor6'>$i</span>"
out+="<span bgcolor='$bcolor6'>"
if [ $(dunstctl is-paused) = "true" ];then
    out+=" ";
else
    out+="󰵚 ";
fi

out+="</span>"
echo "$out"
