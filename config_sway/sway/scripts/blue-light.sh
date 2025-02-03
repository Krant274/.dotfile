#!/usr/bin/env bash

if [ ! -f /tmp/gammastep.lock ]; then
  gammastep -l 0:0 -t 4000:4000 -r &
  touch /tmp/gammastep.lock
else
  pkill gammastep && killall gammastep
  rm -f /tmp/gammastep.lock
fi
