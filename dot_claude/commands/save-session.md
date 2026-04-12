# Save Session Command

## Description
Creates a named `resume-<topic>.sh` script in the current directory that resumes this exact session.

## Usage
`/save-session` — writes a named resume script for the current session.

## Process
1. Find the current session ID — most recently modified `.jsonl` file under the matching project directory in `~/.claude/projects/`
2. Infer a short topic slug from the current conversation (2-3 words, kebab-case, e.g. `laptop-setup`, `wifi-debugging`, `waybar-config`)
3. Get the current working directory
4. Write `resume-<topic>.sh` to the current directory:
```bash
#!/bin/bash
cd /current/working/directory
claude --resume <session-id>
```
5. `chmod +x resume-<topic>.sh`
6. Tell the user the filename and that they can run it to get back to this session
