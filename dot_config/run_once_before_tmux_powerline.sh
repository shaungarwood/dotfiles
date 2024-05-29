#!/usr/bin/env bash

OS=$(uname)

case $OS in
  "Darwin")
    brew install \
      bc\
      curl\
      grep\
      jq
    ;;

  "Linux")
    sudo apt-get update
    sudo apt-get install -y \
      bc\
      curl\
      grep\
      jq
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
