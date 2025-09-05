#!/bin/bash
echo -e "󰒍 <span font_family='Victor Mono' font_weight='ultrabold' font_style='italic'>"
ip link | grep "link/ether" | tail -n 1 | awk '{print $2}'
echo -e "</span>"
