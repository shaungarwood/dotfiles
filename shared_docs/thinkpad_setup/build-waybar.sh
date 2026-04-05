#!/bin/bash
# ThinkPad T14 Gen 1 (Intel) — Ubuntu 24.04 Noble
# Used to build waybar from source because the apt version was too old.
# Reference only — on newer machines, check if `sudo apt install waybar` is sufficient first.

set -e

echo "==> Installing build dependencies..."
sudo apt install -y meson ninja-build clang-tidy gobject-introspection \
  libdbusmenu-gtk3-dev libevdev-dev libfmt-dev libgirepository1.0-dev \
  libgtk-3-dev libgtkmm-3.0-dev libinput-dev libjsoncpp-dev libmpdclient-dev \
  libnl-3-dev libnl-genl-3-dev libpulse-dev libsigc++-2.0-dev libspdlog-dev \
  libwayland-dev scdoc libxkbregistry-dev libgtk-layer-shell-dev \
  libwireplumber-0.4-dev

echo "==> Cloning waybar..."
mkdir -p ~/src
git clone https://github.com/Alexays/Waybar ~/src/waybar

echo "==> Building..."
cd ~/src/waybar
meson setup build
ninja -C build

echo "==> Installing..."
sudo ninja -C build install

echo "==> Done! Waybar version:"
waybar --version
