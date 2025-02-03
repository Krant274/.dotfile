#!/usr/bin/env bash

if [ ! -f /tmp/syncthing.lock ]; then
  syncthing serve &
  touch /tmp/syncthing.lock
else
  pkill syncthing && killall syncthing
  rm -f /tmp/syncthing.lock
fi
