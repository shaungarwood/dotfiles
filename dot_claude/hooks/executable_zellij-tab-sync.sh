#!/usr/bin/env bash
# Keep the zellij tab name in sync with the Claude Code session name.
#
# Claude has no "session renamed" hook, so this gets driven from
# ~/.claude/settings.json:
#
#   statusLine       -> ~/.claude/statusline.sh pipes us its JSON. That payload is
#                       the only one carrying .session_name (set by /rename, and by
#                       the auto-generated title), and it re-renders within ~300ms
#                       of a rename. This is the fast path.
#   SessionStart     -> blanks the tab name so the bar starts lean.
#   UserPromptSubmit -> catch-up for anything the fast path deferred.
#   SessionEnd       -> drops the state file.
#
# zjstatus has no conditionals, so the tab NAME carries the separator: we write
# ":my-session" and the bar renders "{index}{name}" -> "5:my-session". A session
# with no name yet gets a blank tab name, so the bar stays lean: just "5".
#
# The catch: `zellij action rename-tab` renames whatever tab has FOCUS. Do NOT
# assume any Claude event implies focus -- UserPromptSubmit also fires for
# scheduled tasks, remote control, and cross-session messages, so a background
# session can rename a tab the user is looking at. The only sound test is to ask
# zellij which pane is focused and compare it to our own $ZELLIJ_PANE_ID (that is
# exactly the column `zellij action list-clients` reports). If our pane isn't the
# focused one we do nothing and try again on the next render.

set -u

[ -n "${ZELLIJ:-}" ] || exit 0
[ -n "${ZELLIJ_PANE_ID:-}" ] || exit 0
command -v zellij >/dev/null 2>&1 || exit 0
command -v jq >/dev/null 2>&1 || exit 0

json=$(cat)
[ -n "$json" ] || exit 0

# One field per line — @tsv would be wrong here, since bash treats tab as IFS
# whitespace and would collapse empty fields, shifting the values left.
event="" sid="" name=""
{
    read -r event || true
    read -r sid || true
    read -r name || true
} <<EOF
$(printf '%s' "$json" | jq -r '.hook_event_name // "", .session_id // "", .session_name // ""')
EOF

[ -n "$sid" ] || exit 0

state="$HOME/.claude/zellij-tab-sync/$sid"

if [ "$event" = "SessionEnd" ]; then
    rm -f "$state"
    exit 0
fi

# Hook payloads don't carry .session_name — fall back to the session registry,
# which Claude keeps updated with the same name. Skip nameSource "derived": those
# are cwd-plus-random placeholders ("ccapi-copy-ab"), not real titles, and the
# statusLine payload never contains them either.
if [ -z "$name" ]; then
    reg=$(grep -ls "\"sessionId\":\"$sid\"" "$HOME"/.claude/sessions/*.json 2>/dev/null | head -1)
    [ -n "$reg" ] && name=$(jq -r 'if .nameSource == "derived" then "" else .name // "" end' "$reg" 2>/dev/null)
fi

target=""
if [ -n "$name" ]; then
    # Keep the tab bar from blowing out on long auto-generated titles.
    [ ${#name} -gt 28 ] && name="${name:0:27}…"
    target=":$name"
fi

# Already applied? Then we're done, without talking to zellij at all.
prev=$(cat "$state" 2>/dev/null) || prev=""
[ -f "$state" ] && [ "$target" = "$prev" ] && exit 0

# Is OUR pane the focused one? Only then does rename-tab hit our tab.
clients=$(zellij action list-clients 2>/dev/null | awk 'NR > 1 && NF')
[ -n "$clients" ] || exit 0
# With a second client attached, focus is per-client and we can't tell which one
# rename-tab would follow. Refuse to guess.
[ "$(printf '%s\n' "$clients" | wc -l | tr -d ' ')" = 1 ] || exit 0
[ "$(printf '%s\n' "$clients" | awk '{print $2}')" = "terminal_$ZELLIJ_PANE_ID" ] || exit 0

mkdir -p "${state%/*}"
zellij action rename-tab "$target" >/dev/null 2>&1 && printf '%s\n' "$target" >"$state"
exit 0
