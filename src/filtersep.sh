#!/bin/bash
while IFS= read -r line; do
    if [[ $line =~ ^\[.*\]$ ]]; then
        # Process JSON array lines, removing \ue0b6 from full_text fields
        echo "$line" | jq '[.[] | .full_text = (.full_text | gsub("\ue0b6"; ""))]'
    else
        # Pass through non-JSON lines (like i3status header)
        echo "$line"
    fi
done
