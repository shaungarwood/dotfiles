#!/usr/bin/env bash

LIGHT="Tomorrow"
DARK="Tomorrow Night"
CONFIG="$HOME/.config/ghostty/config"

current=$(grep -E '^theme\s*=' "$CONFIG" | tail -1 | sed 's/.*=\s*//')

if [[ "$current" == "$LIGHT" ]]; then
    next="$DARK"
else
    next="$LIGHT"
fi

tmpfile=$(mktemp)
grep -v -E '^# Colors|^background\s*=|^foreground\s*=|^selection-background\s*=|^selection-foreground\s*=|^palette\s*=|^theme\s*=' "$CONFIG" > "$tmpfile"
printf '\ntheme = %s\n' "$next" >> "$tmpfile"
mv "$tmpfile" "$CONFIG"

gdbus call --session \
    --dest com.mitchellh.ghostty \
    --object-path /com/mitchellh/ghostty \
    --method org.gtk.Actions.Activate \
    "reload-config" "[]" "{}" &>/dev/null

echo "$next"
