#!/usr/bin/env bash

set -e  # Exit on error

echo "Installing Docker on Linux..."
echo ""

# Remove old versions
echo "→ Removing old Docker versions..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

# Install prerequisites
echo "→ Installing prerequisites..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker's GPG key
echo "→ Adding Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo "→ Adding Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
echo "→ Installing Docker Engine..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker service
echo "→ Starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Add user to docker group (if not already)
if ! groups | grep -q docker; then
    echo "→ Adding user to docker group..."
    sudo usermod -aG docker $USER
fi

echo ""
echo "✓ Docker installed successfully!"
echo ""

# Verify
if docker --version &>/dev/null; then
    echo "Docker version:"
    docker --version
    docker compose version
    echo ""
    echo "✓ Docker is working!"
else
    echo "⚠️  Docker group not active yet. Run: newgrp docker"
fi

echo ""
echo "Installation complete!"
