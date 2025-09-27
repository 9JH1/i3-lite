#!/bin/bash
source ~/.config/i3/src/i3.sh 
out="<span foreground='$bcolor11'>$i</span>"
out+="<span bgcolor='$bcolor11'>󰒍 "
out+=$(ip link | grep "link/ether" | tail -n 1 | awk '{print $2}')
out+="</span>"
echo "$out"
