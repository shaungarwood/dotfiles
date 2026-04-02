# Lockscreen (swaylock + swayidle)

## Problem
Screen content briefly visible when opening laptop lid — race condition between
display turning on and swaylock rendering.

## Solution
Created a lock script that starts swaylock, waits for it to render, then turns
off the display via DPMS. When the lid opens, display turns on with swaylock
already rendered.

## Files
- `~/.local/bin/lock-screen.sh` — lock script (⚠️ track with chezmoi)
- `~/.config/sway/config` — updated bindswitch and swayidle exec

## lock-screen.sh
```sh
#!/bin/sh
swaylock -f \
  --image ~/Pictures/Wallpapers/current_lockscreen \
  --ignore-empty-password \
  --indicator-radius 200
sleep 0.3
swaymsg "output * dpms off"
```

## Sway config changes
```
set $lock "~/.local/bin/lock-screen.sh"

bindswitch --reload --locked lid:on exec ~/.local/bin/lock-screen.sh
bindswitch --reload --locked lid:off exec swaymsg "output * dpms on"
exec swayidle -w before-sleep 'swaylock -f --image ~/Pictures/Wallpapers/current_lockscreen --ignore-empty-password --indicator-radius 200'
```

## Tuning
- If flash still appears, increase the `sleep 0.3` in lock-screen.sh
- If lock feels slow, decrease it (0.1 minimum)

## Chezmoi
```sh
chezmoi add ~/.local/bin/lock-screen.sh
```
