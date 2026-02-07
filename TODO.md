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

**Future Evaluation**:
- [ ] Evaluate mise for CLI tools (neovim, tmux, lazygit, tldr, ripgrep, bitwarden, tirith)
  - Verify cross-platform parity (macOS/Linux)
  - Check if mise provides same version flexibility as brew/apt/manual installs
  - Consider: Does mise make these easier to manage than current approach?

### Brew Setup
Install script notes:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
- Same installer for Linux/macOS
- Linux: Install `build-essential` + `brew install gcc`
- Add shellenv to .zshrc

## Application Setup

### Bitwarden
Add install script (needed for API keys)

### Kitty
Ubuntu: Use `apt`, not brew

### Neovim
- Get light theme + alias to switch themes
- Consider switching to brew/mise from PPA
- Add tpope/rails.vim

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
