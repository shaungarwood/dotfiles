# TODO

## Package Management

### Mise (asdf replacement)
Reference: https://mise.jdx.dev/getting-started.html

**Status**: Language runtimes migrated (nodejs, ruby, python)

**Completed**:
- [x] Create run_once_before_mise.sh installer
- [x] Track mise config file (.config/mise/config.toml)
- [x] Migrate language runtimes from asdf (nodejs, ruby, python)
- [x] Add mise activation to .zshrc template
- [x] Create asdf cleanup script (run_once_after_cleanup_asdf.sh)

**CLI Tools Migration (Recommended)**:
- [ ] Move to mise (strong candidates):
  - [ ] neovim - Version management useful, cross-platform consistency
  - [ ] lazygit - Simpler than manual install
  - [ ] ripgrep - Fast, version pinning available
  - [ ] tldr - Simple tool, mise handles well
- [ ] Keep current approach (don't move):
  - zsh - System shell, must exist before mise loads
  - tmux - System integration better, but mise works if needed
  - bitwarden-cli - System package more secure/trusted

**Benefits of migration:**
- Single config for all machines (identical versions everywhere)
- No OS-specific install scripts needed
- Auto-updates with `mise upgrade`
- Current: neovim from brew (mac) vs ppa (linux) → different versions
- After: neovim from mise registry → identical everywhere

### Brew Setup
Install script notes:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
- Same installer for Linux/macOS
- Linux: Install `build-essential` + `brew install gcc`
- Add shellenv to .zshrc

## Application Setup

### Claude Code
Add native installer to chezmoi setup
- [ ] Create run_once_before_claude_code.sh
- [ ] Use native installer (auto-updates, no Node.js required)
- [ ] Linux/macOS: `curl -fsSL https://claude.ai/install.sh | bash`
- [ ] Don't use mise/npm (npm method deprecated, no auto-updates)

### Bitwarden
Add install script (needed for API keys)

### Kitty
Ubuntu: Use `apt`, not brew

### Neovim
- [ ] Get light theme + alias to switch themes
- [ ] Switch to mise from PPA/brew (cross-platform consistency)
- [ ] Add tpope/rails.vim

### Tmux
Different colors per system/environment

## Configuration

### SSH
Add templated `.ssh/config`
- Different configs per environment (personal/work/remote)
- Consider separate files per host category

### Pry
Can default ~/.pryrc coexist with project-level configs?

## Testing & CI

### GitHub Actions CI/CD
Set up automated testing for chezmoi installs
- Use existing Docker test harness from `test/` directory
- Run on PR/push to catch install errors early
- Test both GUI and headless configurations

## Cleanup

### Aliases
Remove/template GUI-specific aliases (veracrypt, rails stuff)

### Random Packages
- Python: yt-dlp
- Font: font-dejavu-sans-mono-for-powerline
- Tools: chromium, zulu11, mitmproxy
