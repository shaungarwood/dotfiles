#!/usr/bin/env bash
# This script is run once before zshrc is sourced

sudo apt-get update
sudo apt-get install -y zsh curl git gpg

# Set zsh as the default shell
chsh -s $(which zsh)

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
source ~/.asdf/asdf.sh
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

asdf plugin add ruby
asdf install ruby latest
asdf global ruby latest

adsf plugin add python
asdf install python latest
asdf global python latest
