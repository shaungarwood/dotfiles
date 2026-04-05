# Nerd Fonts

## What's installed
- 0xProto Nerd Font (includes all Nerd Font icons/glyphs)
- Location: ~/.local/share/fonts/0xProto/

## Install
```sh
mkdir -p ~/.local/share/fonts/0xProto
curl -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/0xProto.zip \
  -o /tmp/0xProto.zip
unzip /tmp/0xProto.zip -d ~/.local/share/fonts/0xProto
fc-cache -fv ~/.local/share/fonts
```

## Config
- kitty: already had `font_family 0xProto Nerd Font` in ~/.config/kitty/looks.conf — just worked
- waybar: font set in ~/.config/waybar/style.css:
  ```css
  * { font-family: "0xProto Nerd Font", FontAwesome, monospace; }
  ```

## Notes
- To install a different nerd font, replace `0xProto` in the URL with the font name (e.g. `JetBrainsMono`, `FiraCode`, `Hack`)
- Full list at https://github.com/ryanoasis/nerd-fonts/releases
- After installing, run `fc-cache -fv ~/.local/share/fonts` to register
