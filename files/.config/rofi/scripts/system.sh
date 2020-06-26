#!/bin/bash

ROFI_DIR="~/.config/rofi"

cmd_rofi="rofi -dmenu -theme $ROFI_DIR/themes/menu-system.rasi"

lock=""
suspend="鈴"
shutdown=""
log_out=""
reboot=""

options="$lock\n$suspend\n$log_out\n$shutdown\n$reboot"

chosen="$(echo -e $options | $cmd_rofi -p "")"

case $chosen in
	$lock)
		i3lock
		;;
	$suspend)
		systemctl suspend
		;;
	$log_out)
		echo logout
		;;
	$shutdown)
		systemctl poweroff
		;;
	$reboot)
		systemctl reboot
		;;
esac
