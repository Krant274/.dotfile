#!/usr/bin/env bash

#use  'swaymsg -t get_inputs' to get  id

if [ ! -f /tmp/touchpad.lock ]; then
  dunstify --replace=11112 -a 'no' "Touchpad: Disabled"
  swaymsg input "1267:12699:ASUE120A:00_04F3:319B_Touchpad" events disabled &
  touch /tmp/touchpad.lock
else
  dunstify --replace=11112 -a 'no' "Touchpad: Enabled"
  swaymsg input "1267:12699:ASUE120A:00_04F3:319B_Touchpad" events enabled &
  rm -f /tmp/touchpad.lock
fi
