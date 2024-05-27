#!/usr/bin/env bash
# This script is run once before aliases is sourced

if [[ $SHELL != *"zsh"* ]]; then
  OS=$(uname)

  case $OS in
    "Darwin")
      # Mac specific commands here
      echo "Running on Mac"
      ;;

    "Linux")
      # Linux specific commands here
      echo "Running on Linux"
      sudo apt-get update
      sudo apt-get install -y \
        ripgrep \
        shred \ # unclear if this works
        htop \
        visidata
      ;;
  esac
fi
