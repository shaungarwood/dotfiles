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

# Install asdf
if ! command -v asdf >/dev/null; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
  source ~/.asdf/asdf.sh
fi

# Install nodejs
if ! which node | grep -q 'asdf'; then
  asdf plugin add nodejs
  asdf install nodejs latest
  asdf global nodejs latest
fi

# Install ruby
if ! which ruby | grep -q 'asdf'; then
  asdf plugin add ruby
  asdf install ruby latest
  asdf global ruby latest
fi

# Install python
if ! which python | grep -q 'asdf'; then
  asdf plugin add python
  asdf install python latest
  asdf global python latest
fi
