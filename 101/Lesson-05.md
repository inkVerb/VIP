# Shell 101
## Lesson 5: Variables from Pipe & Command Substitution

Ready the CLI

```console
cd ~/School/VIP/101
```

___

| **1** :$

```console
gedit applefoo
```

| **2** :$

```console
cat applefoo
```

*Note what `cat` does...*

| **3** :$

```console
cat abcsed
```

| **4** :$

```console
gedit abcsed
```

| **5** :$

```console
gedit abcsed.setting
```

| **6** :$

```console
cat abcsed.setting
```

| **7** :$

```console
gedit abcd
```

| **8** :$

```console
cat abcd
```

*Note what `sed` does...*

| **9** :$

```console
sed -i "s/bar/foo/" applefoo
```

*gedit: Reload applefoo*

*Now, use `sed` without the `-i` ...*
  - *It won't change the file*
  - *It outputs to the terminal*

| **10** :$

```console
sed "s/foo/bar/" applefoo
```

| **11** :$

```console
ls
```

*Now, use `sed` with `-e` and see what happens...*

| **12** :$

```console
sed -e "s/foo/bar/g" applefoo > newapplefoo
```

| **13** :$

```console
ls
```

| **14** :$

```console
cat newapplefoo
```

*Review what `sed` and `cat` do with the next two commands...*

- *Output `sed` search-replace results: (without `-i` or `-e` flags)*

| **15** :$

```console
sed "s/foo/bar/" applefoo
```

- *Output file contents:*

| **16** :$

```console
cat applefoo
```

*Let's visit an old friend...*

| **17** :$

```console
gedit how2arg
```

| **18** :$

```console
./how2arg one two 3
```

| **19** :$

```console
echo $USER
```

| **20** :$

```console
./how2arg one two $USER
```

| **21** :$

```console
./how2arg one two $(cat applefoo)
```

| **22** :$

```console
./how2arg one two Apples like foo.
```

| **23** :$

```console
./how2arg one two "Apples like foo."
```

| **24** :$

```console
./how2arg one two "$(cat applefoo)"
```

*Next "pipe" `|` the output of `cat` into `sed`...*

| **25** :$

```console
cat applefoo | sed "s/foo/bar/"
```

*Put those commands into a kind of variable value; this is called "Command Substitution": `$(Command Substitution)`*

| **26** :$

```console
echo $(cat applefoo | sed "s/foo/bar/")
```

*Now `echo` it to a file...*

| **27** :$

```console
echo $(cat applefoo | sed "s/foo/bar/") > echocatsed_applefoo
```

| **28** :$

```console
gedit echocatsed_applefoo
```

| **29** :$

```console
cat echocatsed_applefoo
```

*This is useful to get your CPU type...*

| **30** :$

```console
hostnamectl
```

*`echo` the command substitution put to put it on one line...*

| **31** :$

```console
echo $(hostnamectl)
```

*`echo` it into a file...*

| **32** :$

```console
echo $(hostnamectl) > hostnamectl_echo
```

| **33** :$

```console
gedit hostnamectl_echo
```

*Note the content is all on one line, this is the result of `echo`*

*You can "substitute" any command for its output using: `$(...)` or `` `...` ``*

*Let's `kill` a desktop app using Command Substitution...*

| **34** :$

```console
gnome-mines &
```

*Get the app's "process ID" (PID)...*

| **35** :$

```console
pgrep gnome-mines
```

*Note the PID number and replace 55555 with that number below:*

| **36** :$

```console
kill 55555
```

*Do it again, note the number changes...*

| **37** :$

```console
gnome-mines &
```

| **38** :$

```console
pgrep gnome-mines
```

| **39** :$

```console
kill 55555
```

*Now, replace the PID number with `$(what gets the number)`, specifically: `$(pgrep gnome-mines)`...*

| **40** :$

```console
gnome-mines &
```

| **41** :$

```console
kill $(pgrep gnome-mines)
```

*...Try it a few more times if you want, always the same, no changing numbers!*

| **42** :$

```console
gedit comboshell
```

*Create comboshell as this:*

| **comboshell** : v01

```sh
#!/bin/sh

myOutput="$(cat $1 | sed "s/$2/$3/g")"

echo "This was the CS output:
$myOutput"

# v01
```

| **43** :$

```console
chmod ug+x comboshell
```

*Watch Command Substitution work...*

| **44** :$

```console
./comboshell applefoo foo bar
```

*Review the contents of abcd...*

| **45** :$

```console
cat abcd
```

*Watch Command Substitution work...*

| **46** :$

```console
./comboshell abcd jjjjjjjjj "Apple likes to say abcdefghi and "
```

| **47** :$

```console
./comboshell abcd j " zz"
```

___

# The Take

## Pipe `|`
- STDIN input is, more or less what you type into the terminal
- "Raw output" is basic text STDOUT output, more or less output in the terminal
- `cat` will dump a file's contents as raw output (STDOUT)
- `sed` *without `-i`* will dump the results as raw output, rather than changing the file
- `sed -e` "exports" the output to a different file with `> outputfile`
- Many commands use a file for their STDIN input "source"
  - The file `cat` uses is the STDIN input "source"
  - The file `sed` changes is the STDIN input "source"
- STDOUT (output) of one command can be sent as STDIN (input) "source" to the next command using a "pipe": `|`
  - Syntax: `command one | command two`

## `$(`Command Substitution`)`
- The output of a command can be treated as an argument or value if wrapped one of two ways:
  - $ and parentheses: `$(Command Substitution)`
  - backticks: `` `Command Substitution` `` (this can be done, but is not standard practice)
  - Both of these are called "**Command Substitution**"
- Command Substitution can set the value of a variable in a Shell script
  - Example: `thisVariable=$(cat somefile)`
- "Quotes" work cleanly inside Command Substitution
  - Example **in a script**:
```shell
variable="$(echo "something here")"
```
  - ...these "quotes" will not be confused as starting and beginning inside `$(CS wrapper)`
  - Using quotes like this is the "correct" way to use Command Substitution to set variables
- And, use it directly, like this:
  - `some-command $(Command Substitution)` (the Command Substitution can be an argument)
  - `some-command $(Command Substitution) > filename` (send STDOUT output into a file)

___

#### [Lesson 6: tee](https://github.com/inkVerb/vip/blob/master/101/Lesson-06.md)
