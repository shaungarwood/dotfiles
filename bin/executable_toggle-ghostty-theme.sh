#!/usr/bin/env bash

case "$(uname)" in
    Darwin) LIGHT="Tomorrow" ;;
    *)      LIGHT="tomorrow-readable" ;;  # Linux ghostty's theme catalog uses this id instead
esac
DARK="Tomorrow Night"
CONFIG="$HOME/.config/ghostty/config"
CLAUDE_SETTINGS="$HOME/.claude/settings.json"

current=$(grep -E '^theme[[:space:]]*=' "$CONFIG" | tail -1 | sed -E 's/^[^=]*=[[:space:]]*//; s/[[:space:]]+$//')

if [[ "$current" == "$LIGHT" ]]; then
    next="$DARK"
else
    next="$LIGHT"
fi

tmpfile=$(mktemp)
grep -v -E '^# Colors|^(background|foreground|selection-background|selection-foreground|palette|theme)[[:space:]]*=' "$CONFIG" \
    | awk 'NF {blank=0} !NF {blank++} blank<2' > "$tmpfile"
printf 'theme = %s\n' "$next" >> "$tmpfile"
mv "$tmpfile" "$CONFIG"

if [[ "$(uname)" == "Darwin" ]]; then
    # macOS Ghostty is a native app — no DBus. SIGUSR2 reloads the config.
    pkill -USR2 -x ghostty
else
    gdbus call --session \
        --dest com.mitchellh.ghostty \
        --object-path /com/mitchellh/ghostty \
        --method org.gtk.Actions.Activate \
        "reload-config" "[]" "{}" &>/dev/null
fi

# Keep Claude Code in step. The -ansi variants pull syntax colors from the
# terminal's 16 ANSI colors, so they inherit whichever Tomorrow palette is live.
if [[ "$next" == "$LIGHT" ]]; then
    claude_theme="light-ansi"
else
    claude_theme="dark-ansi"
fi

if [[ -f "$CLAUDE_SETTINGS" ]]; then
    python3 - "$CLAUDE_SETTINGS" "$claude_theme" <<'PY'
import json, os, sys, tempfile

path, theme = sys.argv[1], sys.argv[2]

with open(path) as f:
    data = json.load(f)

if data.get("theme") == theme:
    sys.exit(0)

data["theme"] = theme

# Atomic write so a crash mid-save can't truncate the real settings file.
fd, tmp = tempfile.mkstemp(dir=os.path.dirname(path), suffix=".tmp")
with os.fdopen(fd, "w") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
os.replace(tmp, path)
PY
fi

echo "$next ($claude_theme)"
