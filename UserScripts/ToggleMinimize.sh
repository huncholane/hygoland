#!/bin/bash

details=$(hyprctl clients | grep -i "$1" -B 2 -A 15)
class=$(echo "$details" | grep -oP '(?<=class: ).*')

# Launch hubstaff and exit if not open
if [ -z "$details" ]; then
  /home/huncho/Hubstaff/HubstaffClient.bin.x86_64 &>/dev/null &
  exit 0
fi

cur_workspace=$(hyprctl activeworkspace -j | jq '.id')

# Toggle minimized
if echo "$details" | grep -q "special:minimized"; then
  # Bring to current workspace
  echo "moving to workspace: $cur_workspace"
  hyprctl dispatch movetoworkspace "$cur_workspace", "class:$class"
else
  # Move to special:minimized
  echo "moving to minimized workspace"
  hyprctl dispatch movetoworkspacesilent special:minimized, "class:$class"
fi
