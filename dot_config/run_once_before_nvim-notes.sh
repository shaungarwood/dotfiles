#!/bin/bash

REPO_URL="https://github.com/CompanyCam/shaun-garwood-notes.git"
DIR="$HOME/repo/notes"

if [ ! -d "$DIR" ]; then
  mkdir -p "$DIR"
  git clone "$REPO_URL" "$DIR"
else
  echo "Directory $DIR already exists."
fi
