#!/bin/bash

details=$(hyprctl clients -j | jq -r '.[] | select(.class | test("'"$1"'"; "i"))')
class=$(echo "$details" | jq -r '.class')
workspace=$(echo "$details" | jq -r '.workspace.name')
echo "$class $workspace"

# Launch app and exit if class is not found
if [ -z "$details" ]; then
    $2 &>/dev/null &
    exit 0
fi

cur_workspace=$(hyprctl activeworkspace -j | jq '.id')

# Toggle minimized
if [ "$workspace" = "special:minimized" ]; then
    # Bring to current workspace
    echo "moving to workspace: $cur_workspace"
    hyprctl dispatch movetoworkspacesilent "$cur_workspace", "class:$class"
else
    # Move to special:minimized
    echo "moving to minimized workspace"
    hyprctl dispatch movetoworkspacesilent special:minimized, "class:$class"
fi
