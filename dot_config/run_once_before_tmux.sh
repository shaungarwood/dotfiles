#!/usr/bin/env bash

OS=$(uname)

case $OS in
  "Darwin")
    brew install tmux
    ;;

  "Linux")
    sudo apt-get update
    sudo apt-get install -y tmux
    ;;
esac
