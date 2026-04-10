---
name: career-note
description: Quickly capture a win, piece of feedback, or accomplishment to career/captures.md for use at review time. Usage: /career-note <note>
---

Append a timestamped career capture to the running log at
`/Users/shaungarwood/repos/shaun-garwood-notes/career/captures.md`.

## Step 1 — Get the note text

The argument to `/career-note` is the capture text. Take it as-is — don't rewrite or clean it up.
If no argument was provided, ask: "What do you want to capture?"

## Step 2 — Categorize (optional, lightweight)

If the note clearly fits a category, tag it inline:
- `[win]` — shipped something, solved a hard problem, got recognition
- `[feedback]` — something someone said about your work (positive or constructive)
- `[initiative]` — you started or drove something proactively
- `[growth]` — learned something, stretched into new territory

If it's ambiguous, skip the tag — don't overthink it.

## Step 3 — Check if captures.md exists

**File exists:** append the entry (see format below), update `updated:` in frontmatter.

**File doesn't exist:** create it first:

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [career, captures]
status: active
---

# Career Captures

Running log of wins, feedback, and accomplishments. Referenced at self-review time.

---

```

Then append the entry.

## Entry format

```
- YYYY-MM-DD [tag]: <note text>
```

Examples:
```
- 2026-03-30 [win]: shipped datadog error routing — reduced alert noise by ~60%
- 2026-03-30 [feedback]: Harold mentioned I'm the go-to person for oncall triage
- 2026-03-30 [initiative]: started platform office hours to make the team more approachable
```

## Step 4 — Confirm

Reply with exactly what was appended, e.g.:
> ✅ Captured: `2026-03-30 [win]: shipped datadog error routing...`

No need to show the full file. Keep it fast.

## Rules
- Append only — never edit or delete existing entries
- Always update `updated:` in frontmatter after appending
- Keep the note text exactly as the user gave it (no paraphrasing)
- Dates are ISO 8601: `YYYY-MM-DD`
