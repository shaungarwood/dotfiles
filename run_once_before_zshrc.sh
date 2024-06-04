#!/usr/bin/env bash

# Install zsh if the current shell is not zsh
if [[ $SHELL != *"zsh"* ]]; then
  OS=$(uname)

  case $OS in
    "Darwin")
      # Pretty sure this is already installed on Mac
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
      sudo apt-get install -y zsh
      ;;
  esac

  # Set zsh as the default shell
  chsh -s $(which zsh)
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh/" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
