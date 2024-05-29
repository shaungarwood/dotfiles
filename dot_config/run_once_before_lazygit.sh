#!/usr/bin/env bash

if command -v lazygit > /dev/null 2>&1; then
    echo "lazygit is already installed. Exiting."
    exit 0
fi

OS=$(uname)

case $OS in
  "Darwin")
    brew install jesseduffield/lazygit/lazygit
    ;;

  "Linux")
    sudo apt-get update
    sudo apt-get install -y \
      curl \
      tar

    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    ;;
esac
