---
name: flashcard
description: Convert a question/answer pair, a topic to brainstorm cards for, or a markdown file full of Q&A pairs, into Obsidian Spaced Repetition flashcard syntax, creating a new deck note or merging into an existing one in the Work vault's flashcards/ dir. Usage: /flashcard <question> :: <answer> or /flashcard <topic> [N cards] [deck-name] or /flashcard <path/to/notes.md> [deck-name]
---

Convert flashcard content into [Obsidian Spaced Repetition](https://stephenmwangi.com/obsidian-spaced-repetition/)
syntax and write it into a deck note.

**Vault**: `~/vaults/cocam notes`. **Target dir**: `~/vaults/cocam notes/flashcards/` — always.

This is a normal conversation, not a one-shot call — for topic mode or any
multi-card batch, draft → get feedback → revise before writing (Step 5). Only
skip that for a single inline card the user already typed out in full.

Card syntax:
```
Single-line basic:          Question::Answer
Single-line bidirectional:  Side A:::Side B          (2 cards, opt-in only — Step 6)
Multi-line basic:           Question line(s)
                             ?
                             Answer line(s)
Multi-line bidirectional:   Side A line(s)
                             ??
                             Side B line(s)
Cloze:                      Sentence with ==hidden text== in it
```
Every deck gets one inline tag near the top, applying to all cards below it:
`#flashcards/<deck-name>`.

## Step 1 — Mode

- **Inline card**: a fully-formed Q/A, via `::`, two args, or `Q: ... A: ...`.
- **Topic mode**: a bare topic/description (`/flashcard rails callbacks`) — draft
  cards from your own knowledge + conversation context.
- **File mode**: a path to an existing file — parse it (Step 2).

If none fit, ask rather than guess.

## Step 2 — Parse Q&A pairs (file mode)

Recognize `Q:`/`A:` blocks, `## Question` headers with the answer as body text,
`- Question :: Answer` bullets, or definition-list style — mixed formats in one
file are fine. Skip anything that can't be confidently split and flag it in the
summary. If the *whole file* doesn't match any recognizable pattern, show 2-3
example lines and confirm the format with the user before writing anything.

## Step 3 — Draft cards (topic mode)

Default to 5-8 well-scoped cards (one fact per card), unless the user
specifies a count. If "core points" isn't obvious for a broad topic, ask what
angle/depth they want before drafting.

## Step 4 — Target deck + file

**Deck name**: from an explicit arg, else infer from the topic/title/filename
(slugified). If nothing reasonable comes up, ask — don't invent one.
**File**: `~/vaults/cocam notes/flashcards/<deck-name-slugified>.md`, one file per deck.

## Step 5 — Review before writing

Show drafted cards in actual target syntax before writing — required for
topic mode and any file-mode batch of more than ~3 cards. Note skipped
duplicates/unparseable items, and iterate on feedback until approved.

## Step 6 — Card syntax choice

Default **single-line basic**. Switch to **multi-line** if either side has a
newline or a literal `::`/`?` that would confuse the parser. **Bidirectional**
(`:::`/`??`) only when the user asks or the pair is a true symmetric mapping
(term↔definition) — don't default to it for open-ended Q&A. **Cloze** only for
a standalone fact/statement, not a Q/A pair, or if explicitly requested.

## Step 7 — Merge or create

**New file**: frontmatter per the vault's Note Format Standard, then the deck
tag, then the cards:
```markdown
---
created: <today, ISO 8601>
updated: <today, ISO 8601>
tags: [flashcards]
status: active
---

#flashcards/<deck-name>

<cards>
```

**Existing file**: read it first. Append new cards at the end (blank line
separator), bump `updated:`. Never touch existing cards or the deck tag —
each accumulates a scheduling comment (review date/interval/ease) that
reordering or editing would disturb. Dedupe against existing questions before
adding; skip and mention duplicates instead of adding a second copy.

## Step 8 — Formatting

Never let a single-line card contain the separator it's using (`::`/`:::`) —
fall back to multi-line. Leave a blank line after every card (multi-line
cards need one to terminate the answer).

## Step 9 — Confirm

```
Added N card(s) to deck "<name>" in <path>
(skipped: <question snippet> — duplicate)        ← only if any skipped
(skipped: <text snippet> — couldn't parse)       ← only if any unparseable
```
No import step — Obsidian Spaced Repetition picks up new cards on save.
