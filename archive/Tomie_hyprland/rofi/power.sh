#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='power'

uptime="`uptime -p | sed -e 's/up //g'`"
host=$(uname -n)

hibernate=''
shutdown=''
reboot=''
lock=''
suspend=''
logout=''
yes="   <span font='Bebas Neue 30'>Yes</span>"
no="   <span font='Bebas Neue 30'>No</span>"

rofi_cmd() {
    rofi -dmenu \
        -p " $USER  $host" \
        -mesg " Uptime: $uptime" \
        -theme ${dir}/${theme}.rasi
}

confirm_cmd() {
    rofi -dmenu \
	-markup-rows \
        -p "Action: $1" \
        -mesg "Are you sure?" \
        -theme-str 'listview {columns: 1; lines: 2; spacing: 8px;}' \
        -theme-str 'element {padding: 4px;}' \
        -theme ${dir}/${theme}.rasi
}

confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd "$1"
}

run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
}

while true; do
    chosen="$(run_rofi)"

    if [[ -z "$chosen" ]]; then
        exit 0
    fi

    case ${chosen} in
        $shutdown)
            selected="$(confirm_exit 'Shutdown')"
            if [[ "$selected" == "$yes" ]]; then
                systemctl poweroff
            fi
            ;;
        $reboot)
            selected="$(confirm_exit 'Reboot')"
            if [[ "$selected" == "$yes" ]]; then
                systemctl reboot
            fi
            ;;
        $hibernate)
            selected="$(confirm_exit 'Hibernate')"
            if [[ "$selected" == "$yes" ]]; then
                systemctl hibernate
            fi
            ;;
        $suspend)
            selected="$(confirm_exit 'Sleep')"
            if [[ "$selected" == "$yes" ]]; then
                systemctl suspend
            fi
            ;;
        $logout)
            selected="$(confirm_exit 'Logout')"
            if [[ "$selected" == "$yes" ]]; then
                command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit
            fi
            ;;
        $lock)
            hyprlock
            exit 0 # Exit after locking
            ;;
    esac
done
