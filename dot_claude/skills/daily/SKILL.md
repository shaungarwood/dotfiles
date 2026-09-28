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

**Nested/indented sub-items:** evaluate every line by its own checkbox marker, independent of its parent's state. Never copy a parent bullet's block verbatim just because the parent line is still `- [ ]` — re-check each indented child individually and drop any that are `- [x]` or `- [~]`, even if siblings under the same parent are still open. A checked child under an unchecked parent is dropped; the parent and its remaining unchecked children still roll over.

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

## Step 6.6 — Carry forward the Radar section

`## 🧠 Radar` is a persistent, manually-curated list of standing flags, promises, and warnings.

1. Read the previous daily note (found in Step 2) and copy the entire `## 🧠 Radar` section **verbatim** — including the HTML comment and every bullet.
2. It uses **plain bullets, never `- [ ]`**, so Step 4's rollover logic must not touch it. If Step 4 picked up any lines from inside Radar, drop them.
3. Do NOT add, remove, reword, or re-sort Radar items. Shaun deletes them by hand when they stop mattering.
4. Items may carry a trailing date stamp in backticks (`` `2026-08-03` ``) marking when they were added — preserve it.
5. If the previous note has no Radar section, create an empty one from the template.
6. Radar goes directly under the 🎯 quote line, **above** `## 🚧 Active Work`.

Items prefixed `❓` are digest-suggested additions awaiting Shaun's review — carry them forward like any other item.

## Step 6.7 — The Curtis section is not carried forward

`## 👀 Curtis — <date>` is regenerated each morning by the `curtis-digest` skill. Never roll it over, never copy it from the previous note. If today's note already has one, leave it alone.

## Step 7 — Check if today's note exists

- **Exists**: update the note. **Rollover happens at most once per day** — check before prepending:
  - Regenerate the `## 🚧 Active Work` section from Step 6.5 (replace its contents wholesale)
  - **If `### 🔄 Rolled Over` already contains items, rollover has already run today.** Do NOT prepend again — that duplicates every task. Refresh Active Work, update `updated:`, and stop.
  - Only if `### 🔄 Rolled Over` is absent or empty: prepend rolled-over items under it inside `## ✅ Today's Tasks`
  - If weekly injection is due (Step 6) **and** `### 🔁 Weekly` isn't already present, add it after `### 🔄 Rolled Over`
  - Preserve `## 🧠 Radar` and `## 👀 Curtis` exactly as found — never re-carry or regenerate them on an existing note
  - Update `updated:` and `tags:`
  - Then stop.

  This makes a manual `/daily` a safe no-op refresh at any hour, however many times you run it.
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

## 🧠 Radar
<!-- Standing flags. Carried forward verbatim by /daily. Plain bullets — delete by hand when done. -->
<!-- 🎯 promise I made · 🗣️ on the record · 📅 recurring obligation · 🔒 blocker · ⚠️ watch it · 💰 cost · 🔴 on fire · ❓ digest suggestion, unreviewed -->
- <carried forward verbatim from previous note>

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


## 👀 Curtis — YYYY-MM-DD
<!-- Regenerated each morning by the curtis-digest skill. Plain bullets, never rolled over. -->

## 📝 Notes

```

## Rules
- Filename: `daily/YYYY-MM-DD.md`
- Always update `updated:` when editing
- Roll over ALL unchecked items regardless of section, EXCEPT items from `### 🔁 Weekly` or marked `- [~]` (cancelled — don't roll over)
- Nested/indented sub-items are evaluated individually by their own checkbox marker, not by their parent's — never bulk-copy a parent's sub-list without re-checking each child
- Weekly tasks reset fresh each week — do not carry them over day-to-day
- `## 🚧 Active Work` is a live Linear mirror: always regenerate it (plain bullets, never `- [ ]`), never roll it over
- `## 🧠 Radar` is carried forward **verbatim** and never edited by Claude on a `/daily` run
- `## 👀 Curtis` is owned by `curtis-digest` — never carried forward, never touched by `/daily`
- After finishing, tell the user: what rolled over, what date it rolled from, whether weekly tasks were injected, the Active Work tickets pulled (plus any cycle mismatches), and the note path
- End with: **`! nvim daily/YYYY-MM-DD.md`**
