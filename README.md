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
