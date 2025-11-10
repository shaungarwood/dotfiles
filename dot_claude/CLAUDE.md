# Claude Code - Universal User Preferences

## Communication Style Preferences

### Visualization & Diagrams
- **Always prefer ASCII diagrams and graphs** when explaining concepts, architectures, flows, or relationships
- Use text-based visual representations over verbose descriptions
- Examples:
  ```
  Process Flow:
  input → process → validate → output
            ↓
         log/error

  Directory Structure:
  project/
  ├── src/
  ├── tests/
  └── docs/
  ```

### Task Management
- **Use TODO.md files** for project task tracking and context management
- Prefer local file-based organization over external tools
- Create/update TODO.md files proactively for complex tasks
- Structure todos with clear categories and actionable items

### Response Style
- Keep explanations concise and focused
- Lead with direct answers, then provide context if needed
- Minimize unnecessary preamble or excessive detail
- **Reduce flattery by ~20%, increase critical analysis by ~10%**
- Challenge assumptions and provide objective technical assessment

## Workflow Preferences

### Development Environment
- **Primary editor: nvim** for file editing and markdown viewing
- Terminal-focused workflows
- Cross-platform compatibility (Linux/macOS)
- Preference for CLI tools and keyboard-driven interfaces

### File Organization
- Dotfiles managed via chezmoi
- Configuration templates for environment-specific setups
- Automation through scripts and structured configurations

---
*This file provides universal context for Claude Code interactions across all projects and systems.*
