#!/usr/bin/env bash

# options
option_1="Capture Desktop"
option_2="Capture Area"
option_3="Capture in 5s"
option_4="Capture in 10s"
close='Close menu'

# rofi cmd
rofi_cmd() {
  rofi -dmenu -p "Screenshot" -theme "$HOME/.config/rofi/theme_mini.rasi"
}

# pass variables to rofi dmenu
run_rofi() {
  echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$close" | rofi_cmd
}

# screenshot
time=$(date +%Y%m%d-%H%M%S)
dir="$(xdg-user-dir PICTURES)/Screenshots"
file="Screenshot_$time.png"

# directory
if [[ ! -d "$dir" ]]; then
  mkdir -p "$dir"
fi

# notify and view screenshot
notify_view() {
  notify_cmd_shot='dunstify -u low -h string:x-dunst-stack-tag:screenshot'
  ${notify_cmd_shot} "📋 Copied to clipboard"
  if [[ -e "$dir/$file" ]]; then
    ${notify_cmd_shot} "📷 Screenshot taken"
  else
    ${notify_cmd_shot} "📷 Screenshot deleted"
  fi
}

# copy screenshot to clipboard
copy_shot() {
  tee "$file" | wl-copy
}

# countdown
countdown() {
  for sec in $(seq "$1" -1 1); do
    dunstify -t 1000 -h string:x-dunst-stack-tag:screenshottimer -i /usr/share/archcraft/icons/dunst/timer.png "Taking shot in: $sec"
    sleep 1
  done
}

# take shots
shotnow() {
  cd "$dir" && sleep 0.5 && grim - | copy_shot
  notify_view
}

shot5() {
  countdown '5'
  sleep 1 && cd "$dir" && grim - | copy_shot
  notify_view
}

shot10() {
  countdown '10'
  sleep 1 && cd "$dir" && grim - | copy_shot
  notify_view
}

shotarea() {
  cd "$dir" && grim -g "$(slurp)" - | copy_shot
  notify_view
}

# run
case $1 in
--shotnow) shotnow ;;
--area) shotarea ;;
--delay) shot5 ;;
esac

chosen="$(run_rofi)"
case "$chosen" in
"$option_1") shotnow ;;
"$option_2") shotarea ;;
"$option_3") shot5 ;;
"$option_4") shot10 ;;
esac
