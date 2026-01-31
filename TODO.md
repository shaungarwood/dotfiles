# TODO

## Package Management

### Mise Evaluation
Evaluate mise as asdf replacement: https://mise.jdx.dev/getting-started.html
- Compare performance/ease vs asdf
- Candidate packages: neovim, tmux, lazygit, tldr, ripgrep, bitwarden

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

## Cleanup

### Aliases
Remove/template GUI-specific aliases (veracrypt, rails stuff)

### Random Packages
- Python: yt-dlp
- Font: font-dejavu-sans-mono-for-powerline
- Tools: chromium, zulu11, mitmproxy
