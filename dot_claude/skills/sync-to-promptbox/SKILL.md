---
name: sync-to-promptbox
description: Copy a local Claude skill to the shared promptbox repo (shaung's plugin) for team distribution. Use when the user wants to sync, push, publish, or share a skill to promptbox, or says things like "sync X to promptbox", "push skill to promptbox", "update X in promptbox".
---

# Sync Skill to Promptbox

Copy a local skill from `~/.claude/skills/` to `~/repos/promptbox/shaung/.claude/skills/` so it can be shared with the team.

**Not every skill belongs here.** Skills that hardcode personal paths (the Obsidian
vault, `shaun-garwood-notes`), personal logs (career captures, daily notes), or a
named coworker's Slack/Linear IDs are private by default — confirm with the user
before syncing anything that looks like that, rather than syncing on request alone.

## Steps

### 1. Identify the skill

Match the user's request against `~/.claude/skills/`. If ambiguous, list what's available and ask.

### 2. Copy it, excluding local junk

Skills can carry machine-specific cruft (Python venvs, `__pycache__`, rendered
output) that shouldn't ship. Check the skill's own `.gitignore` if it has one and
honor it; otherwise at minimum exclude `.venv/`, `__pycache__/`, and any obvious
generated artifacts.

```bash
rsync -a --exclude='.venv/' --exclude='__pycache__/' \
  ~/.claude/skills/<skill-name>/ ~/repos/promptbox/shaung/.claude/skills/<skill-name>/
```

### 3. Register it in plugin.json

If this is a new skill (not just an update), add its path to the `skills` array in
`~/repos/promptbox/shaung/.claude-plugin/plugin.json`:

```json
"./.claude/skills/<skill-name>"
```

### 4. Confirm and hand off

List the destination directory and report the file sizes so the user can eyeball
that nothing huge or unexpected came along:

```bash
du -sh ~/repos/promptbox/shaung/.claude/skills/<skill-name>
```

Then stop — do not `git add`/`commit`/`push` promptbox without the user explicitly
asking. Show `git status`/`git diff` in `~/repos/promptbox` and let them decide.
