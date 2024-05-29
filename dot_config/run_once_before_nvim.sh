#!/usr/bin/env bash

if command -v nvim > /dev/null 2>&1; then
    echo "nvim is already installed. Exiting."
    exit 0
fi

OS=$(uname)

case $OS in
  "Darwin")
    brew install neovim
    ;;

  "Linux")
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install -y neovim
    ;;
esac
