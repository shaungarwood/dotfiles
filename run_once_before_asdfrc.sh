#!/usr/bin/env bash

if [[ $(uname) == "Darwin" ]]; then
  echo "Exiting because this script is not meant to be run on MacOS"
  exit 0
fi

# Install dependencies for Linux
# I'm guessing Mac already has what it needs
if [[ $(uname) == "Linux" ]]; then
  sudo apt-get update
  sudo apt-get install -y gcc make zlib1g-dev libssl-dev libffi-dev
fi

# Install asdf
if ! command -v asdf >/dev/null; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.18.0
  cd ~/.asdf
  
  # Build the Go-based asdf (requires Go)
  if command -v go >/dev/null; then
    make
    cp ./asdf ./bin/asdf
  else
    # If no Go available, install old version first to bootstrap golang
    git checkout v0.14.0
    source ~/.asdf/asdf.sh
    asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
    asdf install golang latest
    asdf global golang latest
    echo "golang $(asdf current golang | awk '{print $2}')" >> ~/.asdf/.tool-versions
    
    # Now build the new version
    git checkout v0.18.0
    ~/.asdf/installs/golang/*/go/bin/go build -ldflags='-s' -o=./asdf ./cmd/asdf
    cp ./asdf ./bin/asdf
  fi
  cd -
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
