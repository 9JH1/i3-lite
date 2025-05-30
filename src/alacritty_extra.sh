#!/bin/bash
source ~/.config/i3/src/i3.sh
CONFIG="$HOME/.config/i3/conf/alacritty-extra.toml"

# Read current values
padding_set=false

if grep -q "y=$dpi" "$CONFIG"; then
    padding_set=true
fi

echo "changing padding"
echo "[window.padding]" > "$CONFIG"
if $padding_set; then
    echo "y=0" >> "$CONFIG"
    echo "x=0" >> "$CONFIG"
else
    echo "y=$dpi" >> "$CONFIG"
    echo "x=$dpi" >> "$CONFIG"
fi

cat "$CONFIG"
