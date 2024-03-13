# dotfiles

`sh -c "$(curl -fsLS get.chezmoi.io)" -- init shaungarwood`
`chezmoi apply`

## This is the main command you run
`cm diff`
See what changes chezmoi WOULD make


## Example
➜  ~ echo "hello" > .blahrc
cm diff
cm add .blahrc
cm diff
cm rm .blahrc
cat .blahrc
cat: .blahr: No such file or directory
➜  ~ echo "hello2" >> .blahrc

➜  ~ cm diff
diff --git a/.blahrc b/.blahrc
index 97531f3ba85f8e73481ecbaa4ec51b714f4c28a9..ce013625030ba8dba906f756967f9e9ca394464a 100664
--- a/.blahrc
+++ b/.blahrc
@@ -1,2 +1 @@
 hello
-hello2




## The rest of the commands
`cm -v apply`
Dry run the changes
Seem like maybe it'll warn you about changes before they happen.

`cm cd`
Probably just do this for most everything. Then run git commands.

`cm cd && git pull`
I think this will pull GH repo changes.

I don't wannt do `cm update -v` to pull and apply in one fowl swoop.
