#!/usr/bin/env bash

# This script is called from a keybinding in ghostty terminal
# See ~/.config/ghostty/config

if ! command -v cliclick &> /dev/null; then
    echo "cliclick could not be found. Please install it to use this script."
    exit 1
fi

cliclick t:"nvim +1000000 " kd:shift,ctrl t:";" ku:shift,ctrl kp:return
