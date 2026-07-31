#!/usr/bin/env bash
# Install the swamp CLI - deterministic automation for AI agents
# https://swamp-club.com

set -e

# Pin the destination instead of letting install.sh guess. Its fallback order is
# ~/.local/bin, then ~/bin, then ~/.swamp/bin -- and it only picks the first two
# if they are already on PATH. chezmoi runs scripts in a non-login bash shell,
# where dot_zshrc's path+=("$HOME/.local/bin") has not been sourced, so the
# guess lands on ~/.swamp/bin and then tries `sudo ln -s` into /usr/local/bin.
# That would block a non-interactive apply on a sudo password prompt.
DEST="$HOME/.local/bin"

if command -v swamp >/dev/null 2>&1; then
  echo "swamp is already installed: $(swamp --version)"
  exit 0
fi

if [ -x "$DEST/swamp" ]; then
  echo "swamp is already installed at $DEST/swamp: $("$DEST/swamp" --version)"
  exit 0
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "Warning: curl not found, skipping swamp install"
  exit 0
fi

echo "Installing swamp to $DEST..."
mkdir -p "$DEST"

# install.sh only prompts for `swamp auth login` when it has a tty, so piping it
# to sh here installs the binary and leaves auth alone. Auth stays manual and
# per-machine on purpose: a token would have to live in ~/.config/zsh/secrets.zsh,
# which is untracked because this repo is public, so it could not ride along here
# anyway.
#
# Not fatal: swamp needs glibc on Linux and only ships darwin/linux on
# x86_64/aarch64, so a musl or oddball host should warn rather than abort the
# whole apply.
if ! curl -fsSL https://swamp-club.com/install.sh | sh -s -- --destination="$DEST"; then
  echo "Warning: swamp install failed, continuing anyway"
  exit 0
fi

echo "swamp installed: $("$DEST/swamp" --version)"

if ! "$DEST/swamp" auth status >/dev/null 2>&1; then
  echo
  echo "swamp is installed but not authenticated. Run once on this machine:"
  echo "    swamp auth login"
  echo "  ...or, on a headless host with no browser:"
  echo "    swamp auth login --username <you> --no-browser"
fi
