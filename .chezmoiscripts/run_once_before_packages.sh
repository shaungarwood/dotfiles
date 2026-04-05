#!/usr/bin/env bash
# Install essential packages needed by other setup scripts and general system use
# This runs first due to .chezmoiscripts directory (. < d < r in ASCII order)

set -e

OS=$(uname)

case $OS in
  "Darwin")
    echo "macOS: Skipping package installation (assumes Xcode CLI tools installed)"
    # macOS typically has git from Xcode Command Line Tools
    # brew installation handles other dependencies
    ;;

  "Linux")
    echo "Linux: Installing essential packages..."

    # Update package list
    sudo apt-get update

    # Core build/dev tools (needed by other scripts)
    echo "Installing core development tools..."
    sudo apt-get install -y \
      git \
      gpg \
      curl \
      wget \
      ca-certificates \
      build-essential \
      software-properties-common

    # Essential CLI utilities
    echo "Installing CLI utilities..."
    sudo apt-get install -y \
      zsh \
      unzip \
      zip \
      jq \
      ripgrep \
      fd-find \
      htop \
      ncdu \
      tree \
      rsync

    # Network utilities
    echo "Installing network tools..."
    sudo apt-get install -y \
      net-tools \
      dnsutils \
      traceroute \
      netcat-openbsd \
      openssh-client

    # Python essentials (for tooling/scripts)
    echo "Installing Python tools..."
    sudo apt-get install -y \
      python3-pip \
      python3-venv

    echo "✓ All essential packages installed"
    ;;

  *)
    echo "Unknown OS: $OS"
    exit 1
    ;;
esac
