#!/usr/bin/env bash

NPM_CONFIG_PREFIX=~/.joplin-bin npm install -g joplin
sudo ln -s ~/.joplin-bin/bin/joplin /usr/bin/joplin

joplin config editor nvim
joplin config sync.target 7
