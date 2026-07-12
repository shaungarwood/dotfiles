# TODO Management Command

## Description
Updates local TODO.md file with active tasks, research notes, decisions, and project context.

## Usage
When user says "todo", execute this workflow:

## Process

1. **Read existing TODO.md** in current directory
   - If missing, create new TODO.md using the full template below
   - Auto-populate all sections from current conversation context

2. **Check for conflicts**
   - Compare existing content against current conversation state
   - If anything in TODO.md contradicts what we just did or decided, **stop and ask the user** before overwriting
   - Example conflicts: a completed item still marked in-progress, a decision recorded differently than what was just discussed, a research note that was superseded

3. **Check goal status**: Has the main goal changed?

4. **Identify future work**: What next steps or improvements did we discover?

5. **Gather completed items**: What have we accomplished in this session?

6. **Check reference sections** — if any of these are missing or empty, populate from conversation:
   - **Project Context**: Why does this project exist? What problem does it solve?
   - **Key Decisions**: Non-obvious choices made and why (the "why" matters more than the "what")
   - **Research Notes**: Confirmed findings, verified facts, gotchas discovered
   - **Dead Ends**: Things tried that didn't work and why, so we don't re-investigate

7. **Update TODO.md** maintaining this structure (preserve existing content, add new items, never delete without user confirmation)

---

## Template for new TODO.md

```markdown
# TODO

## Current Goal
[AUTO-POPULATE: Use current conversation context/topic as the goal]

## In Progress
-

## Up Next
-

## Completed
-

---

## Project Context
[AUTO-POPULATE: Why this project exists, what problem it solves, who it's for]

## Key Decisions
<!-- Record non-obvious choices and the reason behind them -->
<!-- Format: **Decision:** what was chosen — **Why:** the reasoning -->
-

## Research Notes
<!-- Confirmed findings, verified facts, tool recommendations, gotchas -->
<!-- Include source or confidence level where relevant -->
-

## Dead Ends
<!-- Things investigated that didn't pan out, so we don't re-investigate -->
<!-- Format: **What:** description — **Why it didn't work:** reason -->
-
```

---

## Notes
- Always preserve existing content when updating
- Add new items, don't replace existing ones
- **Conflict resolution**: if current conversation state contradicts existing TODO.md content, ask the user which is correct before writing
- Key Decisions entries should capture the *why*, not just the *what* — that's what makes them useful later
- Dead Ends are as valuable as completed items — record them
- Keep tasks concise and actionable; keep reference sections factual and specific
