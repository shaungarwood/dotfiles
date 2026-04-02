# ThinkPad T14 Setup TODO
_Ubuntu, Sway WM, greetd + nwg-hello login screen, waybar running_

---

## Priority Queue

### ~~1. Sway: waybar~~ DONE
- `sudo apt install waybar` — config already existed at ~/.config/waybar/config
- sway config uses `swaybar_command waybar` in bar block
- Unicode blocks visible = Nerd Fonts not installed yet (see #7)
- Notes: ~/setup/notes/waybar.md

### ~~2. Blue light filter~~ DONE
- `sudo apt install wlsunset`
- sway config: `exec wlsunset -l 39.7 -L -104.9 -t 2000 -T 6500`
- 2000K night (warm/red candlelight), 6500K day (neutral)
- after-resume hook restarts wlsunset on lid open (fixes color reset)
- Notes: ~/setup/notes/wlsunset.md

### 3. Sway: Login screen / display manager
**Problem:** greetd active with `agreety` (text terminal login). User manually starts sway.
**Goal:** greetd + nwg-hello (GTK3 graphical greeter)
**Install steps (for chezmoi docs):**
  - `sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0 gir1.2-gtklayershell-0.1 gnome-themes-extra git python3-build python3-installer python3-wheel python3-setuptools python-is-python3`
  - `sudo pip install build installer --break-system-packages`  ← required, apt modules not importable
  - `git clone https://github.com/nwg-piotr/nwg-hello /tmp/nwg-hello`
  - `cd /tmp/nwg-hello && sudo env PATH="/usr/bin:/usr/local/bin:/usr/sbin:/sbin:/bin" ./install.sh`
  - `sudo useradd -m -G video greeter`
  - Update `/etc/greetd/config.toml` (see below)
  - `sudo systemctl restart greetd`
**greetd config:**
  ```toml
  [terminal]
  vt = 7
  [default_session]
  command = "sway -c /etc/nwg-hello/sway-config"
  user = "greeter"
  ```
**Status:** DONE — notes: ~/setup/notes/display-manager.md

### ~~4. Sway: Fix wallpaper~~ DONE
- Uncommented `output * bg $background fill` in ~/.config/sway/config
- Wallpaper: ~/Pictures/Wallpapers/naval.png

### ~~5. Sway: Scale / DPI~~ DONE
- Display: eDP-1, 1920x1080 @ 60Hz, 14" (~157 PPI)
- `output eDP-1 scale 1.25` added to ~/.config/sway/config
- Wallpaper now uses symlink: ~/Pictures/Wallpapers/current_wallpaper → actual file

### ~~6. Clipboard~~ DONE
- `wl-clipboard` already installed, nvim already has `clipboard=unnamedplus`
- No action needed — was already working

### ~~7. Nerd Fonts~~ DONE
- Downloaded 0xProto Nerd Font from GitHub nerd-fonts releases
- Installed to ~/.local/share/fonts/0xProto/, ran fc-cache
- kitty already had `font_family 0xProto Nerd Font` in looks.conf — just worked
- waybar style.css created with font set

### ~~8. Keyboard volume keys~~ DONE
- Problem: `pactl` not installed — fixed with `sudo apt install pulseaudio-utils`
- Switched from `pactl` to `wpctl` (PipeWire native) for better control
- Increased step from 1% → 5%, capped at 100% with `--limit 1.0`
- Notes: ~/setup/notes/volume-keys.md

### ~~9. Lockscreen wallpaper symlink~~ DONE
- Symlink: ~/Pictures/Wallpapers/current_lockscreen → iced-bentley.png
- sway config updated to `--image ~/Pictures/Wallpapers/current_lockscreen`
- To swap: `ln -sf ~/Pictures/Wallpapers/newimage.png ~/Pictures/Wallpapers/current_lockscreen`

### ~~10. Power profiles~~ DONE
- `power-profiles-daemon` already installed and running
- CLI: `powerprofilesctl set performance / balanced / power-saver`
- Waybar module added: shows PERF/BAL/ECO
- Waybar built from source (v0.15.0) at ~/src/waybar

### ~~11. Lockscreen flash on lid open~~ DONE
- Fix: HandleLidSwitch=ignore, lock-screen.sh (swaylock & → sleep 1 → dpms off → suspend)
- System now properly suspends on lid close
- ⚠️  WARNING: `sudo systemctl restart systemd-logind` KILLS the Wayland session
  — use reboot instead, or `sudo systemctl kill -s HUP systemd-logind`
- ⚠️  CHEZMOI: need to track ~/.local/bin/lock-screen.sh
- Notes: ~/setup/notes/lockscreen.md

### ~~12. Hardware testing~~ PARTIAL
- Speaker: ✓ working
- Mic: ✓ working
- Camera: broken — known T14 Gen 1 Linux issue (see #13)

### 13. Camera fix — T14 Gen 1
**Problem:** IR camera (Windows Hello) hijacks /dev/video0, RGB webcam not appearing.
**BIOS:** Updated to latest via fwupd — camera fix not included (driver-level issue)
**Status:** LOW PRIORITY — may need udev rule workaround

### ~~14. Tailscale~~ DONE
- Manual install via noble repo (auto-detect script fails on this Ubuntu version)
- Script: ~/setup/install-tailscale.sh
- Connected with `sudo tailscale up --auth-key=...`

### ~~15. Tirith~~ DONE (removed)
- Uninstalled: couldn't disable just the curl|pipe rule without losing other features
- Removed from ~/.zshrc and ~/.config/mise/config.toml
- Also fixed: empty-Enter flash was tirith + zsh-syntax-highlighting widget conflict

### ~~16. Battery health test~~ DONE
- Capacity: 85.7% (43.69 Wh of 51 Wh design), 97 cycles — healthy

### ~~17. Fingerprint scanner~~ DONE
- Enrolled: `sudo fprintd-enroll -U csw`
- PAM enabled via `sudo pam-auth-update`

### ~~18. Login screen wallpaper~~ DONE
- sway-config: `output * bg /etc/nwg-hello/current_login_wallpaper fill`
- Symlink at /etc/nwg-hello/current_login_wallpaper → /etc/nwg-hello/login_wallpaper.jpeg
- **BUG:** symlink currently points into /home/csw/ which greeter can't read (home dir is 750)
- **Fix:** `sudo cp ~/Pictures/Wallpapers/mushrooms.jpeg /etc/nwg-hello/login_wallpaper.jpeg`
         `sudo ln -sf /etc/nwg-hello/login_wallpaper.jpeg /etc/nwg-hello/current_login_wallpaper`
- To swap in future: `sudo cp ~/Pictures/Wallpapers/newimage.jpg /etc/nwg-hello/login_wallpaper.jpeg`
- See also: ~/Pictures/Wallpapers/README.md

### ~~19. WiFi / Bluetooth managers~~ DONE
- WiFi: ronema (rofi-network-manager) — keybind Alt+N
- Bluetooth: bluetui — run `bluetui` in terminal (no keybind, conflicts)
- nm-applet --indicator — auto-starts with sway, shows tray icon
- ronema installed to ~/.local/bin/ronema
- bluetui binary at ~/.local/bin/bluetui (v0.8.1)

### 20. Waybar: custom theme/layout
**Goal:** Design a fresh custom waybar config inspired by r/unixporn configs.
**Current state:** Arrows removed, clean default colored-block style. Backups saved at:
  - ~/.config/waybar/config.powerline-attempt
  - ~/.config/waybar/style.css.powerline-attempt
**Status:** LOW PRIORITY — revisit when inspired

### ~~21. Revisit scaling~~ WON'T DO

### ~~22. TLP power management~~ DONE
- Replaced `power-profiles-daemon` (disabled + removed from waybar) with `tlp`
- Battery thresholds: START 75% / STOP 90% (BAT0)
- TLP enabled: `sudo systemctl enable --now tlp`
- Waybar power-profiles-daemon module removed (takes effect on next reboot)
- 1.25 fractional scaling looks fine, not worth per-app font maintenance

---

## Ongoing: Chezmoi Documentation
For each item completed, add a notes file to `~/setup/notes/`:
- `notes/waybar.md` ✓
- `notes/display-manager.md` ✓
- `notes/scaling.md` ✓
- `notes/wlsunset.md` ✓
- `notes/nerdfonts.md` ✓
- `notes/volume-keys.md` ✓
- `notes/lockscreen.md` ✓

### Chezmoi: files needing explicit tracking
- `~/.local/bin/lock-screen.sh` ← `chezmoi add ~/.local/bin/lock-screen.sh`

---

## System State
- OS: Ubuntu 24.04 Noble (ThinkPad T14 Gen 1 Intel)
- WM: Sway (launched via greetd + nwg-hello) ✓
- Display: eDP-1, 1920x1080, scale 1.25 ✓
- Bar: waybar v0.15.0 (built from source at ~/src/waybar) ✓
- Wallpaper: symlink ~/Pictures/Wallpapers/current_wallpaper ✓
- Lockscreen: symlink ~/Pictures/Wallpapers/current_lockscreen → iced-bentley.png ✓
- Login wallpaper: /etc/nwg-hello/current_login_wallpaper → login_wallpaper.jpeg ✓
- Blue light: wlsunset 2000K night / 6500K day, restarts on resume ✓
- Audio: PipeWire + pipewire-pulse, volume keys working (wpctl, 5% steps) ✓
- Fonts: 0xProto Nerd Font installed ✓
- Suspend: systemctl suspend on lid close ✓
- WiFi manager: ronema (Alt+N), nm-applet tray ✓
- Bluetooth: bluetui (run manually) ✓
- Tailscale: installed and connected ✓
- Fingerprint: enrolled, PAM enabled ✓
- BIOS: Updated to latest via fwupd ✓
- Terminal: kitty (~/.local/kitty.app/bin/kitty)
- Shell: zsh (unlimited history)
- chezmoi: ~/.config/chezmoi
