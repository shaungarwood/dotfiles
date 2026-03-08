# Wallpapers

Wallpapers are set via symlinks so you can swap images without editing config files.

## Symlinks

| Symlink                  | Used by                        | Location                              |
|--------------------------|--------------------------------|---------------------------------------|
| `current_wallpaper`      | Sway desktop background        | `~/.config/sway/config`               |
| `current_lockscreen`     | swaylock (lock screen)         | `~/.local/bin/lock-screen.sh`         |
| `current_login_wallpaper`| nwg-hello (login/greeter)      | `/etc/nwg-hello/current_login_wallpaper` → `/etc/nwg-hello/sway-config` |

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
The login screen runs as the `greeter` user which can't read `~/Pictures/`,
so the symlink lives in `/etc/nwg-hello/` instead:
```sh
sudo ln -sf ~/Pictures/Wallpapers/newimage.jpg /etc/nwg-hello/current_login_wallpaper
# takes effect on next logout/reboot
```
