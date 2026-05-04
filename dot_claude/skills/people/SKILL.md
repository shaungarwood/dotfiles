---
name: people
description: Look up, create, or add notes to a person's file in the vault's people/ directory. Usage: /people <name> or /people <name> <note>
---

Manage notes in the vault's `people/` directory.

Vault path: `/Users/shaungarwood/repos/shaun-garwood-notes`
People dir: `people/`

---

## Step 1 — Parse the invocation

Determine intent from the argument:

- **Lookup**: argument is just a name (1–3 words, no predicate/statement)
  - `/people alice` → find Alice's file, display it
- **Add note**: argument is a name followed by a statement/fact/observation
  - `/people Edmund doesn't drink alcohol` → append note to Edmund's file
- **Create**: lookup finds no match → offer to create (or create automatically if add-note intent)

---

## Step 2 — Find the file

1. Normalize the name: lowercase, hyphens for spaces, drop special chars
   - "Alice" → `alice*.md` (partial match ok for first-name-only)
   - "Walter Ashford" → `walter-ashford.md`
   - "Edmund" → `edmund*.md`
2. List `people/` and find the best match (use Glob)
3. If multiple matches, ask which one

---

## Step 3 — Execute intent

### Lookup
- Read and display the file
- End with: **`! nvim people/<filename>.md`** (the user can run this to open vim)

### Add note
- Read the file (or create it — see template below)
- Append to the `## Notes` section:
  ```
  - YYYY-MM-DD: <note content>
  ```
- If no `## Notes` section exists, add one before appending
- Update `updated:` in frontmatter
- Confirm what was added, then show: **`! nvim people/<filename>.md`**

### Create new file
- Filename: `people/<firstname-lastname>.md` (lowercase, hyphens)
- Use this template:

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [people]
status: active
---

## Context

_Role, team, how you know them._

## Notes

```

- After creating, show: **`! nvim people/<filename>.md`**

---

## Rules

- Always end with the `! nvim` open command — this lets the user drop into vim immediately
- Always update `updated:` when editing an existing file
- `interviews/` is off-limits — never touch it
- If the name is ambiguous (first name only, multiple matches), list the options and ask
- Dates are ISO 8601: `YYYY-MM-DD`
