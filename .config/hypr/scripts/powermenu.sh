#!/usr/bin/env bash

# options
shutdown='Power Off'
reboot='Reboot'
restart_wm='Restart WM'
lock='Lock'
suspend='Suspend'
logout='Log Out'
close='Close'

# consts
uptime="$(uptime -p | sed -e 's/up //g')"

# rofi cmd
rofi_cmd() {
  rofi -dmenu \
    -p "Goodbye $USER!" \
    -theme "$HOME"/.config/rofi/theme_mini.rasi \
    -mesg "Uptime: $uptime"
}

# pass variables to rofi dmenu
run_rofi() {
  echo -e "$lock\n$restart_wm\n$suspend\n$logout\n$reboot\n$shutdown\n$close" | rofi_cmd
}

option_poweroff() {
  if command -v systemctl &>/dev/null; then
    systemctl poweroff
  elif command -v loginctl &>/dev/null; then
    loginctl poweroff
  elif command -v shutdown &>/dev/null; then
    shutdown now
  else
    poweroff
  fi
}

option_reboot() {
  if command -v systemctl &>/dev/null; then
    systemctl reboot
  elif command -v loginctl &>/dev/null; then
    loginctl reboot
  elif command -v shutdown &>/dev/null; then
    shutdown -r now
  else
    reboot
  fi
}

option_suspend() {
  if command -v systemctl &>/dev/null; then
    systemctl suspend
  elif command -v loginctl &>/dev/null; then
    loginctl suspend
  fi
}

# run
chosen="$(run_rofi)"
case "$chosen" in
"$shutdown") option_poweroff ;;
"$reboot") option_reboot ;;
"$restart_wm") hyprctl reload ;;
"$lock") "$HOME"/.config/hypr/scripts/lockscreen.sh ;;
"$suspend") option_suspend ;;
"$logout") pkill -SIGKILL -u $(whoami) ;;
esac
