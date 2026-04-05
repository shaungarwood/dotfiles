# Waybar

## What's installed
- waybar (via apt)
- Config already exists at ~/.config/waybar/config

## Install
```sh
sudo apt install waybar
```

## Wallpaper
- Variable in sway config points to a symlink: `~/Pictures/Wallpapers/current_wallpaper`
- To change wallpaper: update the symlink, then `swaymsg reload`
  ```sh
  ln -sf ~/Pictures/Wallpapers/newfile.jpg ~/Pictures/Wallpapers/current_wallpaper
  swaymsg reload
  ```

## Notes
- sway config calls `swaybar_command waybar` in the `bar { }` block — this is correct
- swaybar (built into sway) and waybar are NOT the same; configs are incompatible
- waybar config is JSON at ~/.config/waybar/config and ~/.config/waybar/style.css
- Unicode block characters in waybar = missing Nerd Fonts (see nerdfonts.md)
- Reload sway after install: `swaymsg reload`
