# Blue Light Filter: wlsunset

## What's installed
- wlsunset (Wayland equivalent of redshift)

## Install
```sh
sudo apt install wlsunset
```

## Config
Added to ~/.config/sway/config:
```
exec wlsunset -l 39.7 -L -104.9 -t 2700 -T 6500
```

- `-l 39.7` — latitude (Denver, CO)
- `-L -104.9` — longitude (Denver, CO)
- `-t 2700` — night temperature in Kelvin (warm/red; default 4000)
- `-T 6500` — day temperature in Kelvin (neutral daylight; default 6500)

## Tuning night temp
- 3000K — moderate warm
- 2700K — warm (current setting, incandescent feel)
- 2500K — very red

## Notes
- Classic `redshift` does NOT work on Wayland — use wlsunset or gammastep
- Adjusts automatically based on sunrise/sunset for the given coordinates
