---
name: daily
description: Create or update today's daily note in the Obsidian vault, rolling over unchecked tasks from the most recent previous daily note.
---

Create or update today's daily note in the Obsidian vault at `/Users/shaungarwood/vaults/Work`.

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

## Step 4 — Roll over unchecked items

Read the previous daily note.
Extract ALL unchecked items — lines matching `- [ ]` — from any section (including low priority).
Do NOT roll over checked items (`- [x]`).
Do NOT roll over cancelled items (`- [~]`) — cancelled means done/abandoned, not pending.
Do NOT roll over items from the `### 🔁 Weekly` section — these are managed separately and reset each week.

## Step 5 — Infer tags from previous daily

Scan only the **checked items** (`- [x]`) from the previous daily for topic signals and build a tag list for today's note.
Examples: if completed tasks mention "datadog" → add `datadog` tag; "rubyconf" → `rubyconf`; "lightning talk" → `lightning-talk`.
Always include `daily` and `todo`. Keep tags lowercase, hyphenated.
Do NOT infer tags from unchecked/rolled-over items.

## Step 6 — Check for weekly task injection

1. Determine the Monday of the current ISO week (Mon–Sun)
2. Check if any daily notes exist in `daily/` with dates between that Monday and yesterday (inclusive)
3. If **no prior notes exist this week** → this is the first note of the week:
   - Read `recurring/weekly.md`
   - Extract all `- [ ]` items from that file
   - These will be placed under `### 🔁 Weekly` in today's note (see template)
4. If prior notes already exist this week → skip weekly injection

## Step 6.5 — Sync Active Work from Linear

Pull Shaun's in-flight tickets from the current cycle to populate the `## 🚧 Active Work` section. This is a **live mirror** — always regenerate it from Linear, whether the note is new or already exists.

Use the Linear MCP tools (load via ToolSearch if deferred: `mcp__claude_ai_Linear__list_issues`, `mcp__claude_ai_Linear__list_cycles`):

1. Team is **PLATB** ("Backend Platform"), team ID `e80bbe9b-a14d-4ba3-bed2-dc6ad8a6e1ac`.
2. Confirm the current cycle: `list_cycles` with `type: current`. Note its title and `endsAt` date.
3. List Shaun's issues: `list_issues` with `assignee: "me"`, `team: "PLATB"`. (The `cycle: "current"` filter is unreliable — instead pull all his issues and filter in-code by `cycleId` matching the current cycle's ID.)
4. **Active Work** = issues whose `cycleId` matches the current cycle AND whose status is one of **In Progress**, **In Review**, or **In Testing**. One bullet each: `- **[PLATB-NNN](url)** — <title> · _<status>_`
5. **Mismatch callout** — separately collect issues that are In Progress / In Review / In Testing but whose `cycleId` does NOT match the current cycle (or is null). If any exist, list them under a `> ⚠️` blockquote as "In Progress but not in the current cycle (should be pulled in or stopped)". This enforces the rule that trackable work should live on a current-cycle ticket.
6. Use **plain bullets, not `- [ ]` checkboxes**, so the rollover logic never drags these forward — the section is rebuilt from Linear each run.
7. If Linear is unavailable, leave any existing `## 🚧 Active Work` content in place and note that it couldn't be refreshed.

## Step 7 — Check if today's note exists

- **Exists**: update the note:
  - Regenerate the `## 🚧 Active Work` section from Step 6.5 (replace its contents wholesale)
  - Prepend rolled-over items under `### 🔄 Rolled Over` inside `## ✅ Today's Tasks`
  - If weekly injection is due (Step 6), add `### 🔁 Weekly` section after `### 🔄 Rolled Over`
  - Update `updated:` and `tags:`
  - Then stop.
- **Doesn't exist**: create it fresh using the template below.

## Step 8 — Add new items

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

## 🚧 Active Work
<!-- Linear mirror · cycle "<cycle title>" (ends YYYY-MM-DD) · assigned to me, In Progress / In Review / In Testing. Regenerated by /daily, not rolled over. -->
- **[PLATB-NNN](url)** — <title> · _<status>_

<!-- Only if any exist: In Progress/Review/Testing tickets NOT in the current cycle -->
> ⚠️ In Progress but **not** in the current cycle (should be pulled in or stopped):
> - [PLATB-NNN](url) — <title>

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
- Roll over ALL unchecked items regardless of section, EXCEPT items from `### 🔁 Weekly` or marked `- [~]` (cancelled — don't roll over)
- Weekly tasks reset fresh each week — do not carry them over day-to-day
- `## 🚧 Active Work` is a live Linear mirror: always regenerate it (plain bullets, never `- [ ]`), never roll it over
- After finishing, tell the user: what rolled over, what date it rolled from, whether weekly tasks were injected, the Active Work tickets pulled (plus any cycle mismatches), and the note path
- End with: **`! nvim daily/YYYY-MM-DD.md`**
