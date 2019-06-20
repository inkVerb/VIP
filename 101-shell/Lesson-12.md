# Shell 101
## Lesson 12: grep with Special Characters

`cd ~/School/VIP/shell/101`

___

*Special characters with `grep` need `-F`*

| **1** : `grep -R "$" *`

*Note it found everything*

| **2** : `grep -F "$" *`

*Note the directory error, combine flags into one*

| **3** : `grep -RF "$" *`

| **4** : `grep -RF "@" *`

| **5** : `grep -RF "!" *`

*So far everything works*

| **6** : `grep -RF "!!" *`

*But, that didn't work, why?*

| **7** : `ls -l`

| **8** : `!!`

| **9** : `echo "Hello Apple pie."`

| **10** : `!!`

*In scripts, `!!` means "whatever the last command was, watch..."*

| **11** : `grep -RF "!!" *`

*Sometimes, special characters can only be "canceled" with 'single quotes'*

| **12** : `grep -RF '!!' *`

*...'single quotes' can behave differently in `grep` and most other commands*

___

# The Take

- `grep` handles special characters differently
- `grep` uses `-F` to ignore special characters
- The double exclamation `!!` means "the last command" almost everywhere in Shell, not only in `grep`
- `!!` might only be ignored as an operator if used with 'single' quotes: `'!!'`
- Using 'single' quotes rather than "double" quotes means some special characters don't need to be quoted to prevent them from "operating"

___

# Done! Have a cookie: ### #

Oh, what's this?

| **13** : `cowsay Moo! or something`

Don't have it yet?

| **14** : `sudo apt install cowsay`

___

## Next: [Shell 201: Files](https://github.com/inkVerb/VIP/blob/master/201-shell/README.md)
