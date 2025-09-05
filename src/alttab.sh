#!/bin/bash

# Check for required dependencies
command -v wmctrl >/dev/null 2>&1 || { echo "Error: wmctrl is not installed."; exit 1; }
command -v xdotool >/dev/null 2>&1 || { echo "Error: xdotool is not installed."; exit 1; }
command -v dmenu >/dev/null 2>&1 || { echo "Error: dmenu is not installed."; exit 1; }

# Get a list of all windows with details
# Format: "window_id | class | title"
windows=$(wmctrl -lx | awk '{
    window_id=$1
    workspace=$2
    class=$3
    title=""
    for(i=5;i<=NF;++i) {
        title = title $i " "
    }
    gsub(/^[ \t]+|[ \t]+$/, "", title) # trim whitespace
    printf "%s | %s | %s\n", window_id, class, title
}')

# Let user pick one using dmenu
# Assuming dmenu.sh is a wrapper that calls dmenu with specific options
if [ -f "$HOME/.config/i3/src/dmenu.sh" ]; then
    selection=$("$HOME/.config/i3/src/dmenu.sh" "Select window" "$windows")
else
    # Fallback to standard dmenu if dmenu.sh is not found
    selection=$(echo "$windows" | dmenu -i -l 10 -p "Select window:")
fi

# If nothing selected, exit
[ -z "$selection" ] && exit 0

# Extract window_id from selection
window_id=$(echo "$selection" | cut -d '|' -f 1 | xargs)

# Validate window_id (basic check for 0x format)
if ! [[ "$window_id" =~ ^0x[0-9a-fA-F]+$ ]]; then
    echo "Error: Invalid window ID: $window_id"
    exit 1
fi

# Switch to the window's workspace and activate it
wmctrl -ia "$window_id" || { echo "Error: Failed to switch to window $window_id"; exit 1; }

# Ensure the window is activated (for some window managers)
xdotool windowactivate "$window_id" 2>/dev/null || { echo "Warning: Failed to activate window $window_id"; }

exit 0
