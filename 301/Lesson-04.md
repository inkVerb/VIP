# Linux 301
## Lesson 4: for Applied

Ready the CLI

```console
cd ~/School/VIP/301/one
```

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

*Quick prep first: Make symlinks of this lesson's scripts in the directory we will use*

*Note, we aren't in our usual place; we are here: `~/School/VIP/301/one`*

| **1** :$ *Make sure you include that period at the end!*

```console
ln -sfn ~/School/VIP/301/04-* .
```

### I. Replacing within Variables
*`$Variable` is the same as `${Variable}`, but `${Variable}` can do more...*

```sh
${Variable}Hello
```

| **2** :$

```console
gedit 04-var-form-1
```

| **3** :$

```console
./04-var-form-1 GOOfood
```

| **4** :$

```console
gedit 04-var-form-2
```

| **5** :$

```console
./04-var-form-2 GOOfood
```

| **6** :$

```console
gedit 04-var-form-3
```

| **7** :$

```console
./04-var-form-3 GOOfood
```

*Note `${var%foo}bar` will delete "foo" **from the end**, then append "bar" (like find-replace), if "foo" appears in the variable*

```sh
${Variable%food}
```

| **8** :$

```console
gedit 04-var-form-4
```

| **9** :$

```console
./04-var-form-4 GOOfood
```

| **10** :$

```console
./04-var-form-4 foodGOO
```

*Note:*

- `%` removes from the end of a value
- `#` removes from the beginning of the value
- `//string/` removes within the value (or `//$string/` to remove based on another variable)

```sh
${Variable%food}
${Variable#food}
${Variable//food/}
${Variable//$food/}
```

*In this lesson, we are only looking at removing from the end of a variable, such as changing a file's extension*

| **11** :$

```console
gedit 04-var-form-5
```

| **12** :$

```console
./04-var-form-5 GOOfood
```

*.one %one

| **13** :$

```console
gedit 04-echo-rename-1
```

| **14** :$

```console
ls *.one
```

| **15** :$

```console
./04-echo-rename-1
```

*t.one %t.one

| **16** :$

```console
gedit 04-echo-rename-2
```

| **17** :$

```console
ls *t.one
```

| **18** :$

```console
./04-echo-rename-2
```

### II. Renaming Multiple Files at Once

```sh
for Var in *name; do

mv $Var "${Var%name}newname"

done
```

| **19** :$

```console
ls
```

*t.one --> *T-ONE

| **20** :$

```console
gedit 04-do-mv-1
```

| **21** :$

```console
ls *t.one
```

| **22** :$

```console
./04-do-mv-1
```

| **23** :$

```console
ls
```

*T-ONE --> *t.one

| **24** :$

```console
gedit 04-do-mv-2
```

| **25** :$

```console
ls *T-ONE
```

| **26** :$

```console
./04-do-mv-2
```

| **27** :$

```console
ls
```

*t.one --> *t.THREE

| **28** :$

```console
gedit 04-do-mv-3
```

| **29** :$

```console
ls *t.one
```

| **30** :$

```console
./04-do-mv-3
```

| **31** :$

```console
ls
```

*Make a backup of today's work*

| **32** :$

```console
mkdir -p 04-FOR
```

| **33** :$

```console
cp *THREE* 04-FOR/
```

*Delete*

| **34** :$

```console
gedit 04-do-rm
```

| **35** :$

```console
./04-do-rm
```

*Don't mind the directory error because we want to keep that directory anyway*

| **36** :$

```console
ls
```

### III. Applied: `odt2txt`
*Now, use `odt2txt` in a `for` `...` `do` loop*

| **37** :$ *(Start with a clean slate, just to be sure)*

```console
rm *.txt
```

| **38** :$

```console
ls *.odt && ls *.txt
```

*Note there are only .odt files*

| **39** :$

```console
gedit 04-do-odt2txt
```

| **40** :$

```console
./04-do-odt2txt
```

| **41** :$

```console
ls *.odt && ls *.txt
```

*Note the new .txt files, have a look inside...*

| **42** :$

```console
gedit *.txt
```

*Backup today's work*

| **43** :$

```console
mv *.txt 04-FOR/
```

| **44** :$

```console
ls *.txt
```

*...See all gone*

___

# The Take
## `for` has useful application
- It can list items and modify them
- It can rename, move, or delete files
- It can modify or do complex processes on many files
- It does many things in a short time and with a single command

## Replacement within variables
- `${Var%foo}` will remove "foo" from the end of the value of variable `$Var`
- `${Var%foo}bar` will remove "foo" from the end, then add "bar" to the end the value of variable `$Var`
  - This can be useful to:
    1. Change a string quickly inside a script
    2. Call a known variable based on arguments or a settings file, etc
- See usage and examples here: [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
___

#### [Lesson 5: while, until & case](https://github.com/inkVerb/vip/blob/master/301/Lesson-05.md)
