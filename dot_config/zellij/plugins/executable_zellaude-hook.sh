#!/usr/bin/env bash
# zellaude-hook.sh — Claude Code hook -> zellij notification bridge
# Sends bell + desktop notification on PermissionRequest and Stop events.
#
# Wired up via ~/.claude/settings.json hooks.
# Requires: jq, notify-send (libnotify)

# Exit silently if not inside Zellij
[ -z "$ZELLIJ_SESSION_NAME" ] && exit 0
[ -z "$ZELLIJ_PANE_ID" ] && exit 0

INPUT=$(cat)
HOOK_EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // empty')
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')

[ -z "$HOOK_EVENT" ] && exit 0

notify_user() {
  local title="$1"
  local message="$2"

  # Terminal bell
  printf '\a' > /dev/tty 2>/dev/null || true

  # Rate-limit: one desktop notification per pane per 10 seconds
  local lock="/tmp/zellaude-${ZELLIJ_PANE_ID}-${HOOK_EVENT}"
  local now
  now=$(date +%s)
  local last=0
  [ -f "$lock" ] && last=$(cat "$lock" 2>/dev/null || echo 0)
  if [ $((now - last)) -ge 10 ]; then
    echo "$now" > "$lock"
    notify-send "$title" "$message" &
  fi
}

case "$HOOK_EVENT" in
  PermissionRequest)
    SUFFIX=""
    [ -n "$TOOL_NAME" ] && SUFFIX=" - $TOOL_NAME"
    notify_user "Claude Code" "Permission requested${SUFFIX}"
    ;;
  Stop)
    notify_user "Claude Code" "Agent finished"
    ;;
esac
