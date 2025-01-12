#!/usr/bin/env bash

HYPRLAND_DEVICE="asue120a:00-04f3:319b-touchpad"

if [ -z "$XDG_RUNTIME_DIR" ]; then
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"
fi

export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

enable_touchpad() {
  printf "true" >"$STATUS_FILE"

  dunstify --replace=11112 -a 'no' "Touchpad: Enabled"

  hyprctl keyword "device[$HYPRLAND_DEVICE]:enabled" true
}

disable_touchpad() {
  printf "false" >"$STATUS_FILE"

  dunstify --replace=11112 -a 'no' "Touchpad: Disabled "

  hyprctl keyword "device[$HYPRLAND_DEVICE]:enabled" false
}

notify_cmd() {
  dunstify --replace=11112 -a 'no' --hints=int:value:"Touchpad: " "$(cat "$STATUS_FILE")"
}

if ! [ -f "$STATUS_FILE" ]; then
  enable_touchpad
else
  if [ "$(cat "$STATUS_FILE")" = "true" ]; then
    disable_touchpad
  elif [ "$(cat "$STATUS_FILE")" = "false" ]; then
    enable_touchpad
  fi
fi
