---
name: nvim-debug
description: Debug nvim errors by opening files headlessly, capturing LSP/plugin notifications, running linters, then fixing what's broken. Usage: /nvim-debug [file1] [file2]
---

Debug nvim errors for the specified files (or find them in the project). Captures nvim notifications/messages, LSP errors, and linter output, then fixes the issues.

## Step 1 — Identify target files

If files were passed as arguments to `/nvim-debug`, use those.

Otherwise, look for files in the current project:
- Find the most recently modified `.rb` file: `find . -name "*.rb" -not -path "*/\.*" | head -5`
- Find the most recently modified `.md` file: `find . -name "*.md" -not -path "*/\.*" | head -5`

If no project files are found and no args given, default to these temp files (create them):
- `/tmp/nvim_debug_test.rb` — a minimal ruby snippet: `def hello; puts "hello"; end`
- `/tmp/nvim_debug_test.md` — a minimal markdown: `# Test\n\nHello world.`

Tell the user which files you're debugging before proceeding.

## Step 2 — Run nvim headlessly and capture messages

For each target file, run nvim headlessly and capture `:messages` output (startup errors, LSP spawn failures, plugin errors, etc.):

```bash
nvim --headless <file> \
  -c "lua vim.defer_fn(function()
    local msgs = vim.fn.execute('messages')
    local f = io.open('/tmp/nvim_debug_msgs.txt', 'w')
    if f then f:write(msgs); f:close() end
    vim.cmd('qa!')
  end, 3000)" 2>/tmp/nvim_debug_stderr.txt
```

Collect:
- `/tmp/nvim_debug_msgs.txt` — nvim `:messages` output
- `/tmp/nvim_debug_stderr.txt` — raw stderr (often the same errors, sometimes more)

Deduplicate and parse these into a list of issues. Look for patterns like:
- `Spawning language server ... failed` → LSP not installed
- `Error in ... lua` → plugin/config Lua error
- `E123:` style vim errors → config/command errors
- `require(...)` failures → missing plugin or module

## Step 3 — Capture LSP diagnostics (if LSP might be running)

If Step 2 showed LSP *did* spawn (no spawn failure), run a second headless pass with a longer delay to collect per-buffer diagnostics:

```bash
nvim --headless <file> \
  -c "lua vim.defer_fn(function()
    local d = vim.diagnostic.get(0)
    local lines = {}
    for _,v in ipairs(d) do
      local sev = ({ 'ERROR', 'WARN', 'INFO', 'HINT' })[v.severity] or '?'
      table.insert(lines, string.format('line %d col %d [%s]: %s', v.lnum+1, v.col+1, sev, v.message))
    end
    local f = io.open('/tmp/nvim_debug_diags.txt', 'w')
    if f then f:write(table.concat(lines, '\n')); f:close() end
    vim.cmd('qa!')
  end, 6000)" 2>/dev/null
```

Read `/tmp/nvim_debug_diags.txt`.

## Step 4 — Run standalone linters

Run file-type appropriate checkers directly (these don't need nvim):

**Ruby files (`.rb`):**
```bash
ruby -c <file>           # syntax check (always available if ruby is in PATH)
rubocop <file>           # if available
standardrb <file>        # if available
```

**Markdown files (`.md`):**
```bash
markdownlint <file>      # if available
```

Only run tools that exist (`which rubocop`, etc.). Skip silently if not found — don't error out.

## Step 5 — Analyze and triage

Consolidate all errors from Steps 2–4. Group them:

1. **LSP/tooling not installed** — e.g., `ruby-lsp` missing, `solargraph` missing
2. **Nvim config/plugin errors** — Lua errors, missing modules
3. **File-level errors** — syntax errors, linting violations in the actual files
4. **Warnings / hints** — lower priority

For each group, note the root cause and whether it's fixable (some things like "install ruby-lsp" require user action, others like syntax errors can be fixed directly).

## Step 6 — Fix what can be fixed

Work through fixable errors:

**File-level errors (syntax, style):**
- Read the file
- Apply the fix using Edit
- Re-run the linter to confirm fixed

**Nvim config errors (Lua errors, missing plugin setup):**
- Identify the relevant config file in `~/.config/nvim/lua/`
- Read it
- Apply the fix
- Note: test by re-running the headless nvim pass from Step 2

**Do NOT fix:**
- LSP tools that need to be installed (report these to the user with install instructions)
- Things outside your ability to determine root cause for

## Step 7 — Report

Give a summary like:

```
Files debugged: foo.rb, README.md

Issues found:
  [FIXED]   foo.rb:12 — undefined method `baz` (syntax error)
  [FIXED]   nvim config — ruby_lsp on_attach references deprecated API
  [ACTION]  ruby-lsp not installed → run: gem install ruby-lsp

No more fixable errors.
```

Clean up temp files: `rm -f /tmp/nvim_debug_msgs.txt /tmp/nvim_debug_stderr.txt /tmp/nvim_debug_diags.txt`

## Rules

- Always run the headless nvim pass — real nvim messages are the most accurate source of truth for notification-style errors
- Prefer fixing errors in source files over workarounds
- Never modify nvim config unless the error clearly originates there
- If an error is ambiguous, report it and ask rather than guessing
- `ruby -c` for syntax is cheap and always worth running for `.rb` files
- If nvim errors on startup before even loading the file, report that first — it may block everything else
