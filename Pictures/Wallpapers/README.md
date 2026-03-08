# Wallpapers

Wallpapers are set via symlinks so you can swap images without editing config files.

## Symlinks

| Symlink                  | Used by                        | Location                              |
|--------------------------|--------------------------------|---------------------------------------|
| `current_wallpaper`      | Sway desktop background        | `~/.config/sway/config`               |
| `current_lockscreen`     | swaylock (lock screen)         | `~/.local/bin/lock-screen.sh`         |
| `current_login_wallpaper`| nwg-hello CSS background       | `/etc/nwg-hello/nwg-hello-default.css` |

## How to swap wallpapers

### Desktop wallpaper
```sh
ln -sf ~/Pictures/Wallpapers/newimage.jpg ~/Pictures/Wallpapers/current_wallpaper
swaymsg reload
```

### Lock screen wallpaper
```sh
ln -sf ~/Pictures/Wallpapers/newimage.jpg ~/Pictures/Wallpapers/current_lockscreen
# takes effect immediately on next lock
```

### Login screen wallpaper
nwg-hello renders its own GTK CSS background (not sway's output background).
The wallpaper is set in the CSS and the file lives in /etc/nwg-hello/:
```sh
sudo cp ~/Pictures/Wallpapers/newimage.jpg /etc/nwg-hello/login_wallpaper.jpeg
# takes effect on next logout/reboot
```
The CSS at `/etc/nwg-hello/nwg-hello-default.css` references `/etc/nwg-hello/login_wallpaper.jpeg`.
