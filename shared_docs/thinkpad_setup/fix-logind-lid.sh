#!/bin/bash
# ThinkPad T14 Gen 1 (Intel) — Ubuntu 24.04 Noble
# Tell systemd-logind to ignore lid events — let sway handle them exclusively.
# This prevents logind from racing with sway/swaylock on lid close/open.
#
# WARNING: `sudo systemctl restart systemd-logind` KILLS the active Wayland session.
# Use reboot instead, or: sudo systemctl kill -s HUP systemd-logind

sudo sed -i 's/^#*HandleLidSwitch=.*/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
sudo sed -i 's/^#*HandleLidSwitchExternalPower=.*/HandleLidSwitchExternalPower=ignore/' /etc/systemd/logind.conf

# Apply without reboot
sudo systemctl kill -s HUP systemd-logind

echo "Done. logind will no longer handle lid events."
grep "HandleLidSwitch" /etc/systemd/logind.conf
