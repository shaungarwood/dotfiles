#!/usr/bin/env bash
# This script is run once before zshrc is sourced

# Install/setup zsh and oh-my-zsh
# if the current shell is not zsh
if [[ $SHELL != *"zsh"* ]]; then
  OS=$(uname)

  case $OS in
    "Darwin")
      # Mac specific commands here
      echo "Running on Mac"
      ;;

    "Linux")
      # Linux specific commands here
      echo "Running on Linux"
      sudo apt-get update
      sudo apt-get install -y curl git gpg gcc make zlib1g-dev libffi-dev libssl-dev libyaml-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev
      sudo apt-get install -y zsh
      ;;
  esac

  # Set zsh as the default shell
  chsh -s $(which zsh)

  # Install oh-my-zsh
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
