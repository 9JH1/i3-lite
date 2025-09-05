#!/bin/bash

current_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
new_workspace=$(echo "$current_workspace" | tr ':' '\n' | head -n 1)

new_name=$($HOME/.config/i3/src/dmenu.sh "Rename Workspace $new_workspace:")

new_workspace=$(echo "$new_workspace:$new_name")
i3-msg "rename workspace \"$current_workspace\" to \"$new_workspace\""
