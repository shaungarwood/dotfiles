# dotfiles


```
  _____     ____
 /      \  |  o |
|        |/ ___\|
|_________/
|_|_| |_|_|
```


Using [chezmoi](https://www.chezmoi.io/) to manage my dotfiles and install/manage applications across my machines.

`sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --interactive shaungarwood`

## Basic Commands
`chezmoi diff [optional file]`
See what changes chezmoi WOULD make.

`chezmoi apply -v [optional file]`
Applies the changes and tells you about it .

`chezmoi cd && git pull`
cd into the chezmoi directory and pull the latest changes.

`chezmoi add [file]`
Add a file (or its latest changes) to chezmoi.

I don't wannt do `cm update -v` to pull and apply in one fowl swoop.

## Managing dotfiles

`chezmoi edit ~/.zshrc`
Edit a file managed by chezmoi. Handy because you don't know if it's a template or not.

`chezmoi add --template ~/.zshrc`
Add a file to chezmoi and use the template engine.

`chezmoi chattr +template ~/.zshrc`
Change a managed chezmoi file to be a template.

### Conditional Configuration (GUI vs. Headless)

This setup can distinguish between GUI and headless machines using a `gui` variable.

- **`.chezmoi.toml.tmpl`**: This file contains a `promptBool` function that makes `chezmoi init --apply --interactive` ask you if the machine has a GUI. The result is stored in the `.gui` template variable.
- **`.chezmoiignore`**: This file uses the `.gui` variable to automatically ignore GUI-specific applications (like Sway, Kitty, etc.) on headless systems.

## Bitwarden Secret Management

Some configuration files (like Crush LLM configs) use Bitwarden to store API keys and secrets securely.

**⚠️ Important:** If Bitwarden is not unlocked, `chezmoi apply` will **fail safely** (existing files won't be modified).

### Setup & Usage

```bash
# Install Bitwarden CLI (one-time)
npm install -g @bitwarden/cli

# Login (one-time per machine)
bw login

# Daily: Unlock and export session (valid for 1 hour)
export BW_SESSION=$(bw unlock --raw)

# Verify it's unlocked
bw status

# Now apply chezmoi
chezmoi apply
```

### Managing Secrets

```bash
# View secrets
bw get item "Crush LLM Secrets"

# Create new secret item
cat << 'EOF' > /tmp/secrets.json
{
  "name": "Item Name",
  "type": 1,
  "login": {"username": "user", "password": ""},
  "fields": [
    {"name": "field_name", "value": "secret_value", "type": 0}
  ]
}
EOF
bw create item $(base64 -w 0 /tmp/secrets.json)
rm /tmp/secrets.json

# Edit secrets (get item, edit JSON, update)
ITEM_ID=$(bw get item "Crush LLM Secrets" | jq -r '.id')
bw get item "$ITEM_ID" > /tmp/item.json
# Edit /tmp/item.json
bw encode < /tmp/item.json | bw edit item "$ITEM_ID"
rm /tmp/item.json

# Sync after changes
bw sync
```
