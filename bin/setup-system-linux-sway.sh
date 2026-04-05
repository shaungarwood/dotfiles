#!/bin/bash
# System-level setup for Linux/Sway machines (requires sudo)
# Run this manually after `chezmoi apply` on a new GUI machine.
# These are /etc/ changes that chezmoi cannot manage directly.

set -e

echo "==> Setting up system-level Sway configuration..."

# ── logind: let Sway handle lid events, not systemd-logind ──────────────────
sudo sed -i 's/^#*HandleLidSwitch=.*/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
sudo sed -i 's/^#*HandleLidSwitchExternalPower=.*/HandleLidSwitchExternalPower=ignore/' /etc/systemd/logind.conf
echo "  logind: HandleLidSwitch=ignore"

# ── greetd + nwg-hello login screen ─────────────────────────────────────────
# Install nwg-hello dependencies (source build required — not in apt)
# See ~/setup/notes/display-manager.md for full install steps

# greetd PAM: password-only (no fprintd) so fingerprint device stays free for sudo
sudo tee /etc/pam.d/greetd > /dev/null << 'EOF'
#%PAM-1.0
auth    required    pam_unix.so
auth    optional    pam_gnome_keyring.so
account required    pam_unix.so
session required    pam_unix.so
session optional    pam_gnome_keyring.so auto_start
EOF
echo "  PAM: greetd password-only (fingerprint reserved for sudo)"

# swaylock PAM: password-only (avoids 6-8s delay from fprintd timeout)
sudo tee /etc/pam.d/swaylock > /dev/null << 'EOF'
#%PAM-1.0
auth    required    pam_unix.so
account required    pam_unix.so
EOF
echo "  PAM: swaylock password-only (fast unlock)"

# ── nwg-hello login wallpaper ────────────────────────────────────────────────
# nwg-hello CSS sets the background, not sway's output bg.
# Wallpaper file must live in /etc/nwg-hello/ (greeter user can't read /home/).
# To set wallpaper: sudo cp ~/Pictures/Wallpapers/image.jpg /etc/nwg-hello/login_wallpaper.jpeg
echo ""
echo "  NOTE: Login wallpaper must be manually copied:"
echo "    sudo cp ~/Pictures/Wallpapers/yourimage.jpg /etc/nwg-hello/login_wallpaper.jpeg"
echo "    sudo ln -sf /etc/nwg-hello/login_wallpaper.jpeg /etc/nwg-hello/current_login_wallpaper"
echo "    Then update /etc/nwg-hello/nwg-hello-default.css background-image URL"
echo "    See ~/Pictures/Wallpapers/README.md for details"

echo ""
echo "==> Done. Reboot to apply logind changes."
