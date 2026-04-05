#!/usr/bin/env bash
set -e

HOSTNAME=$(tailscale status --json | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['Self']['DNSName'].rstrip('.'))")
CERT_DIR="$HOME/.config/zellij/certs"
CERT_FILE="$CERT_DIR/local.crt"
KEY_FILE="$CERT_DIR/local.key"
ZELLIJ_CONFIG="$HOME/.config/zellij/config.kdl"

mkdir -p "$CERT_DIR"

# Get cert (requires sudo or tailscale operator set)
# To avoid sudo in future: sudo tailscale set --operator=$USER
sudo tailscale cert \
  --cert-file "$CERT_FILE" \
  --key-file "$KEY_FILE" \
  "$HOSTNAME"

echo "Cert written to $CERT_DIR"
echo "Restart zellij — web UI will be at: https://$HOSTNAME:8082"
