# Display Manager: greetd + nwg-hello

## What's installed
- greetd (was already active, running agreety text login)
- nwg-hello (GTK3 graphical greeter, built from source)

## Install steps

### 1. APT dependencies
```sh
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0 gir1.2-gtklayershell-0.1 \
  gnome-themes-extra git python3-build python3-installer python3-wheel \
  python3-setuptools python-is-python3
```

### 2. pip dependencies (required — apt modules not importable)
```sh
sudo pip install build installer --break-system-packages
```

### 3. Clone and install nwg-hello
```sh
git clone https://github.com/nwg-piotr/nwg-hello /tmp/nwg-hello
cd /tmp/nwg-hello
sudo env PATH="/usr/bin:/usr/local/bin:/usr/sbin:/sbin:/bin" ./install.sh
```

### 4. Create greeter user
```sh
sudo useradd -m -G video greeter
```

### 5. Update /etc/greetd/config.toml
```toml
[terminal]
vt = 7

[default_session]
command = "sway -c /etc/nwg-hello/sway-config"
user = "greeter"
```

### 6. Restart greetd
```sh
sudo systemctl restart greetd
```

## Notes
- nwg-hello runs inside a minimal sway instance (its own sway-config at /etc/nwg-hello/sway-config)
- `user = "greeter"` is required by nwg-hello — do not change to `_greetd`
- sway.desktop session available at /usr/share/wayland-sessions/sway.desktop
- `python-is-python3` needed because install.sh calls `python` not `python3`
- `pip install build installer` needed because apt versions aren't importable as modules
