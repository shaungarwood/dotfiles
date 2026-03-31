---
name: daily
description: Create or update today's daily note in the Obsidian vault, rolling over unchecked tasks from the most recent previous daily note.
---

Create or update today's daily note in the Obsidian vault at `/Users/shaungarwood/repos/shaun-garwood-notes`.

## Step 1 — Determine today's date

Get today's date in `YYYY-MM-DD` format.

## Step 2 — Find the most recent previous daily

Do NOT assume "yesterday". Instead:
1. List all files in `daily/` — they are named `YYYY-MM-DD.md`
2. Find the most recent one with a date strictly before today
3. This handles weekends, skipped days, and gaps correctly

## Step 3 — Roll over unchecked items

Read the previous daily note.
Extract ALL unchecked items — lines matching `- [ ]` — from any section (including low priority).
Do NOT roll over checked items (`- [x]`).

## Step 4 — Infer tags from previous daily

Scan the previous daily's task content for topic signals and build a tag list for today's note.
Examples: if tasks mention "datadog" → add `datadog` tag; "rubyconf" → `rubyconf`; "lightning talk" → `lightning-talk`.
Always include `daily` and `todo`. Keep tags lowercase, hyphenated.

## Step 5 — Check if today's note exists

- **Exists**: prepend rolled-over items under `### 🔄 Rolled Over` inside `## ✅ Today's Tasks`, update `updated:` and `tags:`, then stop.
- **Doesn't exist**: create it fresh using the template below.

## Step 6 — Add new items

If the user passed new todo items in the `/daily` invocation, append them under `### 🆕 New Today`.

## Template for a new daily note

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [daily, todo, <inferred tags>]
status: active
---

> 🎯 Go heads down. It's the only way you'll get anything done.

## ✅ Today's Tasks

### 🔄 Rolled Over
<!-- delete section if nothing rolled over -->
- [ ] <rolled over item>

### 🆕 New Today


### 🔽 Low Priority


## 📝 Notes

```

## Rules
- Filename: `daily/YYYY-MM-DD.md`
- Always update `updated:` when editing
- Roll over ALL unchecked items regardless of section
- After finishing, tell the user: what rolled over, what date it rolled from, and the note path
- End with: **`! nvim daily/YYYY-MM-DD.md`**
