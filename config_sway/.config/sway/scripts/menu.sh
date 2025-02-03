#!/usr/bin/env bash

# get current status
stats() {
  # Blue light filter
  [ -f /tmp/redshift.lock ] && bluelight_stat='On' || bluelight_stat='Off'

  # Syncthing stats
  [ -f /tmp/syncthing.lock ] && syncthing_stat='On' || syncthing_stat='Off'
}

stats

rofi_cmd() {
  rofi -dmenu -p "Menu" -theme "$HOME/.config/rofi/theme_mini.rasi"
}

apps='Apps'
screenshot='Screenshot'
power='Power'
blue_light="Blue Light Filter: $bluelight_stat"
syncthing="Syncthing: $syncthing_stat"
close='Close menu'

run_rofi() {
  echo -e "$apps\n$screenshot\n$blue_light\n$syncthing\n$power\n$close" | rofi_cmd
}

chosen="$(run_rofi)"
case ${chosen} in
"$apps") rofi -show drun -theme "$HOME/.config/rofi/theme.rasi" ;;
"$screenshot") "$HOME"/.config/sway/scripts/screenshot.sh ;;
"$power") "$HOME"/.config/sway/scripts/powermenu.sh ;;
"$blue_light") "$HOME"/.config/sway/scripts/blue-light.sh ;;
"$syncthing") "$HOME"/.config/sway/scripts/syncthing.sh ;;
esac
