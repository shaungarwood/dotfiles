#!/usr/bin/env bash
# Install xxf custom Oh-My-Zsh theme for remote hosts

set -e

# Create custom themes directory if it doesn't exist
mkdir -p ~/.oh-my-zsh/custom/themes/

# Download xxf theme from GitHub
curl -fsSL https://raw.githubusercontent.com/xfanwu/oh-my-zsh-custom-xxf/master/themes/xxf.zsh-theme \
  -o ~/.oh-my-zsh/custom/themes/xxf.zsh-theme

echo "xxf theme installed"
