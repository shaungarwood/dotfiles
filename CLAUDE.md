# Claude Context: Chezmoi Dotfiles Repository

## Repository Purpose
This is a **chezmoi-managed dotfiles repository** for cross-platform configuration management across personal and work machines. It provides templated configurations with environment-specific customization.

## Repository Structure
```
chezmoi/
├── .chezmoidata.toml        # Host classification data
├── TODO.md                  # Project task tracking
├── README.md                # Setup commands & workflows
├── bin/                     # Custom utility scripts
├── dot_config/              # Application configurations
│   ├── nvim/               # Primary editor (multiple setups)
│   ├── nvim-minimal/       # Lightweight nvim config
│   ├── nvim-notes/         # Note-taking nvim setup
│   ├── tmux/               # Terminal multiplexer
│   ├── kitty/              # Terminal emulator
│   ├── ghostty/            # Alternative terminal
│   ├── lazygit/            # Git TUI
│   ├── sway/               # Linux window manager
│   ├── waybar/             # Linux status bar
│   └── opencode/           # VS Code settings
├── dot_aliases.tmpl         # Shell aliases (templated)
├── dot_zshrc.tmpl          # Zsh configuration (templated)
├── dot_gitconfig.tmpl      # Git config (templated)
├── dot_asdfrc              # Runtime version manager
└── run_once_before_*.sh    # Installation/setup scripts
```

## Environment Configuration
**Host Categories (.chezmoidata.toml):**
- **Personal**: `solid-study`, `distressed-phase`
- **Personal Remote**: `greasy-gold`
- **Work**: `Shauns-MacBook-Pro.local`, `Mac`, `Shauns-MacBook-Pro`

## Key Technologies & Patterns

### Core Tools
- **chezmoi**: Dotfiles manager with templating engine
- **tmpl files**: Environment-specific configurations
- **run_once_before_*.sh**: Automated setup scripts per application
- **brew**: Cross-platform package manager
- **asdf**: Runtime version management (considering **mise** migration)

### Development Environment
```
Editor Stack:
nvim (primary) → tmux → kitty/ghostty → sway/waybar (Linux)
                                      ↘ macOS (work)

Git Workflow:
lazygit (TUI) + templated .gitconfig per environment
```

### Configuration Management Philosophy
- **Template-driven**: `.tmpl` files with host-specific variables
- **Automated setup**: `run_once_before_*` scripts handle dependencies
- **Multi-environment**: Personal/work/remote-specific configurations
- **Cross-platform**: Linux (sway) + macOS compatibility

## Current Development Focus
From TODO.md analysis:
- **Tool Migration**: asdf → mise evaluation
- **Terminal Setup**: kitty installation & configuration
- **Theme Management**: nvim light/dark theme switching
- **SSH Configuration**: Multi-environment SSH config management
- **Package Management**: brew-based installation standardization

## Maintenance Instructions for Claude

### When to Update This File
**ASK FOR CONFIRMATION** before making changes to this file. Update when:
- New applications are added to dot_config/
- Host categories change in .chezmoidata.toml
- Major workflow or tool changes occur
- Repository structure significantly changes

### Update Process
1. Analyze repository changes: `git log --oneline -10` and `git diff HEAD~5`
2. Check for new files: `find . -name "dot_*" -newer CLAUDE.md`
3. Review TODO.md changes for new focus areas
4. **Request permission**: "I notice changes to [specific areas]. Should I update CLAUDE.md?"
5. Update relevant sections maintaining current structure

### Key Sections to Maintain
- Repository Structure (ASCII tree)
- Environment Configuration (host categories)
- Current Development Focus (from TODO.md)
- Technology stack and patterns

**Remember**: Always confirm with user before modifying this file.