#!/bin/bash

REPO_URL="https://github.com/CompanyCam/shaun-garwood-notes.git"
DIR="$HOME/repo/notes"

mkdir -p "$DIR"
git clone "$REPO_URL" "$DIR"
