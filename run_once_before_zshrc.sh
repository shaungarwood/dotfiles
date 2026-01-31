#!/usr/bin/env bash

# Prevent interactive prompts during package installation
export DEBIAN_FRONTEND=noninteractive
export TZ=America/Denver

# Install zsh if the current shell is not zsh
if [[ $SHELL != *"zsh"* ]]; then
  OS=$(uname)

  case $OS in
    "Darwin")
      # Pretty sure zsh is already installed on Mac
      brew install zsh zsh-syntax-highlighting
      ;;

    "Linux")
      sudo apt-get update
      sudo apt-get install -y \
        curl \
        git \
        gpg \
        gcc \
        make \
        zlib1g-dev \
        libffi-dev \
        libssl-dev \
        libyaml-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        liblzma-dev
      sudo apt-get install -y zsh zsh-syntax-highlighting
      ;;
  esac

  # Set zsh as the default shell
  chsh -s $(which zsh)
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh/" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
