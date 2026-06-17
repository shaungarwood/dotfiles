#!/usr/bin/env bash
# Install essential packages needed by other setup scripts and general system use
# This runs first due to .chezmoiscripts directory (. < d < r in ASCII order)

set -e

OS=$(uname)

case $OS in
  "Darwin")
    echo "macOS: Installing essential packages via brew..."
    if command -v brew >/dev/null 2>&1; then
      brew install mosh
    else
      echo "Warning: Homebrew not found, skipping package installation"
    fi
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
      openssh-client \
      mosh

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
