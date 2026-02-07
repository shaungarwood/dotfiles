#!/usr/bin/env bash
# Clean up asdf installation (replaced by mise)
# Reference: https://asdf-vm.com/manage/core.html#uninstall

set -e

# Only run if mise is installed (confirming migration is complete)
if ! command -v mise >/dev/null 2>&1; then
  echo "Skipping asdf cleanup: mise not installed yet"
  exit 0
fi

# Check if asdf exists
if [ ! -d "$HOME/.asdf" ]; then
  echo "No asdf installation found. Nothing to clean up."
  exit 0
fi

echo "mise is installed. Cleaning up asdf..."

# Remove asdf directory
if [ -d "$HOME/.asdf" ]; then
  echo "Removing ~/.asdf directory..."
  rm -rf "$HOME/.asdf"
fi

# Remove asdf data directory
if [ -d "$HOME/.asdf" ]; then
  rm -rf "$HOME/.asdf"
fi

# Note: .zshrc has already been updated to use mise via template

echo "asdf cleanup complete!"
echo "Note: Restart your shell or run: exec zsh"
