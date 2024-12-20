#!/usr/bin/env bash

if [[ $SHELL != *"zsh"* ]]; then
  OS=$(uname)

  case $OS in
    "Darwin")
      brew install \
        ripgrep \
        htop \
        visidata
      ;;

    "Linux")
      sudo apt-get update
      sudo apt-get install -y --ignore-missing \
        ripgrep \
        shred \
        htop \
        visidata \
        pass
      ;;
  esac
fi
