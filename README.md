# dotfiles

`sh -c "$(curl -fsLS get.chezmoi.io)" -- init shaungarwood`

`chezmoi apply`
^ will warn you before overwriting

## This is the main command you run
`chezmoi diff`
See what changes chezmoi WOULD make

## The rest of the commands
`chezmoi cd && git pull`
I think this will pull GH repo changes.

I don't wannt do `cm update -v` to pull and apply in one fowl swoop.
