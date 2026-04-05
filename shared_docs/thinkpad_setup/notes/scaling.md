# Display Scaling / DPI

## Display info
- Output: eDP-1 (BOE 0x07C9)
- Resolution: 1920x1080 @ 60Hz
- Size: 14" (~157 PPI)

## Config
Added to ~/.config/sway/config:
```
output eDP-1 scale 1.25
```

Effective resolution at 1.25: 1536x864

## Scale options considered
- 1.0 → 1920x1080 effective (too small)
- 1.25 → 1536x864 effective (chosen — looks great)
- 1.5 → 1280x720 effective (too coarse)

## Notes
- No additional GTK/Firefox/kitty font scaling needed at 1.25 — sway handles it at the compositor level for Wayland-native apps
- If non-Wayland apps look small, may need `GDK_SCALE` or per-app tweaks later
