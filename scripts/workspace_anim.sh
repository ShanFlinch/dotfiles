#!/bin/bash

TARGET=$1
WINDOW_COUNT=$(hyprctl workspaces -j | jq ".[] | select(.id == $TARGET) | .windows")

hyprctl keyword animation "workspacesIn, 1, 2, linear, slide"
if [ -z "$WINDOW_COUNT" ] || [ "$WINDOW_COUNT" -eq 0 ]; then
    hyprctl keyword animation "workspacesOut, 1, 2, linear, slide"
else
    hyprctl keyword animation "workspacesOut, 1, 2.5, instant, fade"
fi
hyprctl dispatch workspace $TARGET
