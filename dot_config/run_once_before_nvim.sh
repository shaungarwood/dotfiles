#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

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
    sudo DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends neovim
    ;;
esac
