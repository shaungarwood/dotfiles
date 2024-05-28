# dotfiles

`sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --interactive shaungarwood`

## This is the main command you run
`chezmoi diff`
See what changes chezmoi WOULD make

`chezmoi apply -v`
Applies the changes and tells you about it 


## The rest of the commands
`chezmoi cd && git pull`

I don't wannt do `cm update -v` to pull and apply in one fowl swoop.
