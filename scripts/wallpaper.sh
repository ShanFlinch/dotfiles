#!/bin/bash


BRIGHT_WALL="$HOME/.config/rice/tomie/wallpaper1.jpg"
DIM_WALL="$HOME/.config/rice/tomie/wallpaper2.jpg"


update_wallpaper() {

    WINDOW_COUNT=$(hyprctl activeworkspace -j | jq '.windows')

    if [ "$WINDOW_COUNT" -eq 0 ]; then
        swww img "$DIM_WALL" --transition-type simple --transition-fps 60 --transition-step 8
    else
        swww img "$BRIGHT_WALL" --transition-type simple --transition-fps 60 --transition-step 16
    fi
}

update_wallpaper

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    if [[ "$line" == "workspace"* ]] || [[ "$line" == "openwindow"* ]] || [[ "$line" == "closewindow"* ]]; then
        update_wallpaper
    fi
done
