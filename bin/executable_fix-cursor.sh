#!/bin/bash
# Fix frozen cursor on Ubuntu/Sway
# Usage: Run from TTY (Ctrl+Alt+F2) if GUI is frozen

echo "=== Cursor/Input Fix Script ==="
echo ""

# Method 1: Reload input devices (least disruptive)
echo "[1/4] Reloading input device drivers..."
sudo modprobe -r psmouse && sudo modprobe psmouse
sudo modprobe -r hid_generic && sudo modprobe hid_generic

# Method 2: Restart input services
echo "[2/4] Restarting input services..."
sudo systemctl restart systemd-udevd

# Method 3: Reload Sway (if accessible)
echo "[3/4] Attempting to reload Sway..."
if pgrep -x sway > /dev/null; then
    swaymsg reload 2>/dev/null || echo "  Sway reload failed (may need TTY access)"
fi

# Method 4: Nuclear option - restart display manager
echo "[4/4] Display manager restart available if needed"
echo "  Run manually: sudo systemctl restart gdm3"
echo "  (or: sudo systemctl restart lightdm)"
echo ""
echo "=== If cursor still frozen ==="
echo "1. Switch to TTY: Ctrl+Alt+F2"
echo "2. Login and run: sudo systemctl restart gdm3"
echo "3. Or reboot: sudo reboot"
