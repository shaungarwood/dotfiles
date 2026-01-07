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
      packages=("ripgrep" "shred" "htop" "visidata" "pass")
      for pkg in "${packages[@]}"; do
        echo "Installing $pkg..."
        INSTALL_COMMAND="sudo apt-get install -y"
        if [ "$pkg" == "pass" ]; then
          INSTALL_COMMAND+=" --no-install-recommends"
        fi
        # We have do this silly thing because there is NO way to continue the script if a package fails to install
        $INSTALL_COMMAND "$pkg" || {
          echo "Warning: $pkg could not be installed. Continuing..."
        }
      done
      echo "All installations attempted. Continuing with the script..."
      ;;
  esac
fi
