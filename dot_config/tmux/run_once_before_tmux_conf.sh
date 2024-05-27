#!/usr/bin/env bash
# This script is run once before tmux.conf is sourced.

OS=$(uname)

case $OS in
  "Darwin")
    # Mac specific commands here
    echo "Running on Mac"
    brew install tmux
    ;;

  "Linux")
    # Linux specific commands here
    echo "Running on Linux"
    sudo apt-get update
    sudo apt-get install -y tmux
    ;;
esac

PLUGINS_DIR=~/.config/tmux/plugins/tpm
if [ ! -d "$PLUGINS_DIR" ]; then
  mkdir -p $PLUGINS_DIR

  # Install Tmux Plugin Manager
  if [ ! -d "$PLUGINS_DIR/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
  fi
fi
