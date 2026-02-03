#!/usr/bin/env bash
set -e

echo "=================================================="
echo "Testing chezmoi installation on headless system"
echo "=================================================="
echo ""

# Setup apt logging to capture what gets installed
export APT_LOG="/tmp/apt-install.log"
sudo touch "$APT_LOG"
sudo chmod 666 "$APT_LOG"

# Wrapper for apt-get to log installations
sudo tee /usr/local/bin/apt-get-wrapper > /dev/null << 'EOF'
#!/bin/bash
echo "[APT-INSTALL] $(date): $@" >> /tmp/apt-install.log
/usr/bin/apt-get.real "$@"
EOF

sudo chmod +x /usr/local/bin/apt-get-wrapper
sudo mv /usr/bin/apt-get /usr/bin/apt-get.real
sudo ln -s /usr/local/bin/apt-get-wrapper /usr/bin/apt-get

echo "Starting chezmoi initialization and apply..."
echo ""

# Initialize and apply chezmoi from the mounted source directory
# This will run all the run_once_before scripts
chezmoi init --apply --source /chezmoi-source -v

echo ""
echo "=================================================="
echo "Installation Complete - Package Analysis"
echo "=================================================="
echo ""

# Analyze what was installed
echo "=== APT Installation Log ==="
cat "$APT_LOG"
echo ""

# Check for GUI-related packages
echo "=== GUI/X11 Packages Check ==="
GUI_PACKAGES=$(dpkg -l | grep -iE 'x11|xorg|wayland|sway|gtk|qt5|mesa|opengl|dri' | awk '{print $2}' || true)

if [ -n "$GUI_PACKAGES" ]; then
    echo "⚠️  WARNING: GUI packages detected:"
    echo "$GUI_PACKAGES"
    echo ""
    echo "Package details:"
    dpkg -l | grep -iE 'x11|xorg|wayland|sway|gtk|qt5|mesa|opengl|dri'
else
    echo "✓ No obvious GUI packages detected"
fi

echo ""
echo "=== Disk Usage ==="
du -sh /var/lib/apt/lists /var/cache/apt || true
df -h /

echo ""
echo "=== Installed Package Count ==="
echo "Total packages: $(dpkg -l | grep ^ii | wc -l)"

# Save logs to output directory if it exists
if [ -d "/output" ]; then
    echo ""
    echo "Saving logs to /output..."
    sudo chown -R $(whoami) /output 2>/dev/null || true
    cp "$APT_LOG" /output/apt-install.log
    dpkg -l > /output/packages-installed.txt
    dpkg -l | grep -iE 'x11|xorg|wayland|sway|gtk|qt5|mesa|opengl|dri' > /output/gui-packages.txt || true
    echo "✓ Logs saved"
fi
