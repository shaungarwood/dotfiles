---
name: daily
description: Create or update today's daily note in the Obsidian vault, rolling over unchecked tasks from the most recent previous daily note.
---

Create or update today's daily note in the Obsidian vault at `/Users/shaungarwood/repos/shaun-garwood-notes`.

## Step 0 — Detect future date intent

Before anything else, check if the invocation contains a date phrase like:
- "next thursday", "next monday", etc.
- "tomorrow", "this friday"
- Any day name or relative date expression

If a future date phrase is detected:
1. Resolve it to a concrete `YYYY-MM-DD` (e.g. "next thursday" → find the next Thursday from today)
2. Extract any todo item(s) from the invocation
3. If the target file exists: append item(s) under `### 🆕 New Today`, update `updated:`
4. If it doesn't exist: create it fresh using the template below (skip rollover — leave `### 🔄 Rolled Over` section out), add item(s) under `### 🆕 New Today`
5. Tell the user what date was resolved, what was added, and the note path
6. End with **`! nvim daily/YYYY-MM-DD.md`** using the resolved date
7. **Stop here — do not continue to the steps below**

## Step 1 — Determine today's date

Get today's date in `YYYY-MM-DD` format.

## Step 2 — Find the most recent previous daily

Do NOT assume "yesterday". Instead:
1. Run `ls daily/ | sort` (NOT Glob — Glob sorts by modification time, not filename, which gives wrong results)
2. From the sorted list, find the most recent filename with a date strictly before today
3. This handles weekends, skipped days, and gaps correctly

## Step 3 — Roll over unchecked items

Read the previous daily note.
Extract ALL unchecked items — lines matching `- [ ]` — from any section (including low priority).
Do NOT roll over checked items (`- [x]`).
Do NOT roll over items from the `### 🔁 Weekly` section — these are managed separately and reset each week.

## Step 4 — Infer tags from previous daily

Scan only the **checked items** (`- [x]`) from the previous daily for topic signals and build a tag list for today's note.
Examples: if completed tasks mention "datadog" → add `datadog` tag; "rubyconf" → `rubyconf`; "lightning talk" → `lightning-talk`.
Always include `daily` and `todo`. Keep tags lowercase, hyphenated.
Do NOT infer tags from unchecked/rolled-over items.

## Step 5 — Check for weekly task injection

1. Determine the Monday of the current ISO week (Mon–Sun)
2. Check if any daily notes exist in `daily/` with dates between that Monday and yesterday (inclusive)
3. If **no prior notes exist this week** → this is the first note of the week:
   - Read `recurring/weekly.md`
   - Extract all `- [ ]` items from that file
   - These will be placed under `### 🔁 Weekly` in today's note (see template)
4. If prior notes already exist this week → skip weekly injection

## Step 6 — Check if today's note exists

- **Exists**: update the note:
  - Prepend rolled-over items under `### 🔄 Rolled Over` inside `## ✅ Today's Tasks`
  - If weekly injection is due (Step 5), add `### 🔁 Weekly` section after `### 🔄 Rolled Over`
  - Update `updated:` and `tags:`
  - Then stop.
- **Doesn't exist**: create it fresh using the template below.

## Step 7 — Add new items

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

### 🔁 Weekly
<!-- delete section if not first note of the week -->
- [ ] <weekly task>

### 🆕 New Today


### 🔽 Low Priority


## 📝 Notes

```

## Rules
- Filename: `daily/YYYY-MM-DD.md`
- Always update `updated:` when editing
- Roll over ALL unchecked items regardless of section, EXCEPT items from `### 🔁 Weekly`
- Weekly tasks reset fresh each week — do not carry them over day-to-day
- After finishing, tell the user: what rolled over, what date it rolled from, whether weekly tasks were injected, and the note path
- End with: **`! nvim daily/YYYY-MM-DD.md`**
