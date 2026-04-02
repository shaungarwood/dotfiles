# Volume Keys

## Problem
- Sway config had `pactl` bindings but `pactl` wasn't installed
- Also: 1% steps, no cap on max volume (could go past 100%)

## Fix

### 1. Install pulseaudio-utils (provides pactl, useful for other things)
```sh
sudo apt install pulseaudio-utils
```

### 2. Switch to wpctl (PipeWire native, already installed)
Updated ~/.config/sway/config:
```
bindsym XF86AudioRaiseVolume exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0'
bindsym XF86AudioLowerVolume exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'
bindsym XF86AudioMute exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'
```

## Notes
- `wpctl` is part of WirePlumber (PipeWire session manager) — no extra install needed
- `--limit 1.0` caps volume at 100% (prevents distortion)
- Audio stack: PipeWire + pipewire-pulse (PulseAudio compatibility layer) — both running
- `pactl` still works for querying (e.g. `pactl info`, `pactl list sinks`) via pipewire-pulse
