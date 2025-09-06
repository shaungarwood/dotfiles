# TODO Management Command

## Description
Updates local TODO.md file with detailed goal, completed items, and future work.

## Usage
When user says "todo", execute this workflow:

## Process
1. **Read existing TODO.md** in current directory
   - If missing, create new TODO.md using template below
   - **Auto-populate Current Goal** with current context/conversation topic
2. **Check goal status**: "Has the main goal changed?"
3. **Identify future work**: "What next steps or improvements did we discover?"
4. **Gather completed items**: "What have we accomplished in this session?"
5. **Update TODO.md** maintaining this structure:
   ```
   # TODO

   ## Current Goal
   [Main objective description]

   ## In Progress
   - [Current active items]

   ## Up Next
   - [Next steps and improvements]

   ## Completed
   - [Finished items from this session]
   ```
6. **Clean trailing whitespace**: `sed -i 's/[[:space:]]*$//' TODO.md`

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

```

## Notes
- Always preserve existing content when updating
- Add new items, don't replace existing ones
- Use ASCII diagrams when explaining TODO relationships
- Keep updates concise and actionable