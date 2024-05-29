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
      sudo apt-get install -y \
        ripgrep \
        shred \ # unclear if this works
        htop \
        visidata
      ;;
  esac
fi
