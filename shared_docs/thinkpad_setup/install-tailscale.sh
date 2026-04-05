#!/bin/bash
# ThinkPad T14 Gen 1 (Intel) — Ubuntu 24.04 Noble
# Install Tailscale manually for Ubuntu 24.04 Noble.
# The official `curl | bash` auto-detect script fails on this Ubuntu version — use this instead.

set -e

# Add signing key
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/tailscale-archive-keyring.gpg

# Add repo
echo "deb [signed-by=/usr/share/keyrings/tailscale-archive-keyring.gpg] \
https://pkgs.tailscale.com/stable/ubuntu noble main" \
  | sudo tee /etc/apt/sources.list.d/tailscale.list

# Install
sudo apt update
sudo apt install -y tailscale

echo ""
echo "Done. To connect:"
echo "  sudo tailscale up"
echo "  tailscale status"
