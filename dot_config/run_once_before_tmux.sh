#!/usr/bin/env bash

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
