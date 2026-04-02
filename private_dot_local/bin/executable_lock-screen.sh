#!/bin/sh
# Start swaylock first, give it time to establish the session lock,
# then turn off display. When lid opens, swaylock surface is already in place.
swaylock -f \
  --image ~/Pictures/Wallpapers/current_lockscreen \
  --ignore-empty-password \
  --indicator-radius 200 &
sleep 1
swaymsg "output * dpms off"
systemctl suspend
