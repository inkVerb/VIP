# Shell 101
## Lesson 12: grep with Special Characters

Ready the CLI

```console
cd ~/School/VIP/101
```

___

*Special characters with `grep` need `-F`*

| **1** :$

```console
grep -R "$" *
```

*Note it found everything*

| **2** :$

```console
grep -F "$" *
```

*Note the directory error, combine flags into one*

| **3** :$

```console
grep -RF "$" *
```

| **4** :$

```console
grep -RF "@" *
```

| **5** :$

```console
grep -RF "!" *
```

*So far everything works*

| **6** :$

```console
grep -RF "!!" *
```

*But, that didn't work, why?*

| **7** :$

```console
ls
```

| **8** :$

```console
!!
```

| **9** :$

```console
echo "Hello Apple pie."
```

| **10** :$

```console
!!
```

*In scripts, `!!` means "whatever the last command was, watch..."*

| **11** :$

```console
grep -RF "!!" *
```

*Sometimes, special characters can only be "escaped" with 'single quotes'*

| **12** :$

```console
grep -RF '!!' *
```

*...'single quotes' can behave differently in `grep` and most other commands*

___

# The Take

- `grep` handles special characters differently
- `grep` uses `-F` to ignore special characters
- The double exclamation `!!` means "the last command" almost everywhere in Shell, not only in `grep`
- `!!` might only be ignored as an operator if used with 'single' quotes: `'!!'`
- Using 'single' quotes rather than "double" quotes means some special characters don't need to be quoted to prevent them from "operating"


Tip: Test `sed` with `grep`

*Sometimes `sed` can be complicated; one type-o can cause disaster!*

*If you want to run a `sed` command to change many files, run a test first...*

For example, across many files, change this...

```xml
Alan eats pineapples and pears.
```

...into this...


```xml
Alan eats pineapples.
```

| **Firstly test** :$ (No `-i`, no changes; `| grep` filters the output from the entirity of every file)

```console
sed 's/ and pears//' * | grep "Alan eats pineapples"
```

*If the lines look how you want, then run the `sed` part of the command...*

| **Lastly run** :$ (`-i` will change files)

```console
sed -i "s/ and pears//" *
```

___

# Done! Have a cookie: ### #

Oh, what's this?

| **D1** :$

```console
cowsay Moo! or something
```

Don't have it yet?

| **D2** :$

```console
sudo apt install cowsay
```

___

## Next: [Shell 201: Files](https://github.com/inkVerb/VIP/blob/master/201/README.md)
