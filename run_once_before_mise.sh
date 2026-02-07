#!/usr/bin/env bash
# Install mise - modern runtime manager (replaces asdf)
# https://mise.jdx.dev/getting-started.html

set -e

OS=$(uname)

# Check if mise is already installed
if command -v mise >/dev/null 2>&1; then
  echo "mise is already installed: $(mise --version)"
  exit 0
fi

echo "Installing mise..."

case $OS in
  "Darwin")
    # macOS: Use brew
    if command -v brew >/dev/null 2>&1; then
      brew install mise
    else
      echo "Error: Homebrew not found. Install brew first."
      exit 1
    fi
    ;;

  "Linux")
    # Linux: Use official installer
    curl https://mise.run | sh

    # Add mise to PATH for this script
    export PATH="$HOME/.local/bin:$PATH"
    ;;

  *)
    echo "Unknown OS: $OS"
    exit 1
    ;;
esac

# Verify installation
if ! command -v mise >/dev/null 2>&1; then
  echo "Error: mise installation failed"
  exit 1
fi

echo "mise installed successfully: $(mise --version)"

# Install language runtimes from config
echo "Installing language runtimes from ~/.config/mise/config.toml..."
mise install

echo "mise setup complete!"
