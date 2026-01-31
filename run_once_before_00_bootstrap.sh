#!/usr/bin/env bash
# Bootstrap: Install essential dependencies needed by other setup scripts
# This runs first due to 00_ prefix (alphabetical ordering)

set -e

OS=$(uname)

case $OS in
  "Darwin")
    echo "macOS: Skipping bootstrap (assumes Xcode CLI tools installed)"
    # macOS typically has git from Xcode Command Line Tools
    # brew installation handles other dependencies
    ;;

  "Linux")
    echo "Linux: Installing bootstrap dependencies..."

    # Update package list
    sudo apt-get update

    # Install essential tools needed by other scripts
    sudo apt-get install -y \
      git \
      curl \
      wget \
      ca-certificates \
      build-essential \
      software-properties-common

    echo "Bootstrap dependencies installed"
    ;;

  *)
    echo "Unknown OS: $OS"
    exit 1
    ;;
esac
