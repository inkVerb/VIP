# Linux 101
## Lesson 3: Arguments & Variables Review

Ready the CLI

```console
cd ~/School/VIP/101
```

___

| **1** :$

```console
gedit how2arg
```

### Arguments (`$1`, `$2`, etc)

*Create `how2arg` as this:*

| **how2arg** :

```sh
#!/bin/sh

echo "These were your line arguments:
\$0: $0
\$1: $1
\$2: $2
\$3: $3"

# For $10 and above, use: ${10}
```

| **2** :$

```console
ls
```

| **3** :$

```console
chmod ug+x how2arg
```

| **4** :$

```console
ls
```

| **5** :$

```console
./how2arg a b abcd
```

*This displayed the **arguments***

*Note how `\` "**backslash**" will "**quote**" the character after (`$`) so that it does not "work" inside the script*

| **6** :$

```console
./how2arg one two three
```

*In Terminal: <kbd>Up</kbd>*

*This shows the previous command*

### Multiple Lines with `\`

*Note how `\` quote before a **new line** will prevent that line from finalizing the terminal command*

| **7** :$
```sh
./how2arg \
one \
two \
three
```

*In Terminal: <kbd>Up</kbd>*

*This shows the previous command, but it all appears on one line*

### Multiple Words `"`with quoted arguments`"`

*Use a **quoted argument** for the third argument...*

| **8** :$

```console
./how2arg one 2nd "third word"
```

| **9** :$
```sh
./how2arg \
first \
2nd \
"third line"
```

### `$@` is "all arguments" *(everything after `$0`)*

*Knowing this could save your life and explain life's meaning later on...*

| **10** :$

```console
gedit allarg
```

*Create allarg as this:*

| **allarg** :

```sh
#!/bin/sh

echo $@
```

| **11** :$

```console
ls
```

| **12** :$

```console
chmod ug+x allarg
```

| **13** :$

```console
ls
```

| **14** :$

```console
./allarg
```

| **15** :$

```console
./allarg 1 2 3 4 5 6 7 8 9
```

| **16** :$

```console
./allarg I like to eat bananas in the morning, with eggs, over easy that is.
```

*This `@` means "everything" in web DNS, arrays ([Linux 301](https://github.com/inkVerb/vip/blob/master/301/README.md)), and many other things*

### Terms: Variable, Argument, Constant
```sh
$vari : variable
$shoe : variable

$VARI : constant variable (do not change)
$USER : environment constant variable (may change when you log out)

$1    : argument variable 1
${10} : argument variable 10
$10   : argument variable 1 followed by the number 0
```

**Variable**: Something starting with `$` that equals some other "value", can be different each time running a command or script

**Value**: What a "variable" equals

**Argument**: Variable set from the command line

**Constant**: Variable that do not change

*We will look at* ***constants*** *more in [401 Lesson 5](https://github.com/inkVerb/vip/blob/master/401/Lesson-05.md#viii-readonly-variables-constants)*

### Environment Constants

*These are "environment constants" that can always be called in the terminal or a script...*

| **17** :$

```console
printenv
```

| **18** :$

```console
echo $USER
```

| **19** :$

```console
printenv USER
```

*...two ways to do the same thing*

| **20** :$

```console
echo $DESKTOP_SESSION
```

| **21** :$

```console
printenv DESKTOP_SESSION
```

| **22** :$

```console
echo $PWD
```

| **23** :$

```console
printenv PWD
```

*Here is a little trick, just for the PWD (Present Working Directory)... ;-)*

| **24** :$

```console
pwd
```

| **25** :$

```console
./how2arg $PWD $DESKTOP_SESSION VIP
```

| **26** :$

```console
./how2arg $USER USER rocks
```

___

# Glossary
- **script arguments** - the space-separated CLI options that become `$1`, `$2`, etc inside the script
- **backslash** - `\` is the quote character in Shell and can quote `$` or a new line, etc
- **constant** - a vaiable whose value cannot change
- **environment** - the processes and constants used by the system to operate, the foundation of using the operating system
- **new line** - moving from the end of one line to the next line, in file contents or in terminal commands;
  - Not the same as a paragraph break, which has text styling to add extra line spacing
  - In HTML, `<br>` is a "line break" that renders following text on a new line while `<p>...</p>` will render paragraph breaks before and after
- **PWD** - Present Working Directory - the directory being used in the terminal
- **quote** - prevent a coding character from "working" as code, but only its letter
- **quoted argument** - An argument using "quotation marks" that has many words, but acts as a single argument
  - 'Single quotes' and "double quotes" both work, but they might behave differently
- **user** - the login account that "runs" commands and processes; everything on a computer is run by a "user" 
- **value** - what a variable equals, what it is used as when a command or script is executed
- **variable** - something inside the CLI or script that could have any different value each time it is used

# The Take
- Arguments (`$1`, `$2`, and `$3`, etc) work in order after their command
- `$0` is the argument for the command that was run in the terminal
- Terminal commands may be continued to multiple lines using `\` (this helps organize stuff)
- **Up** & **Down** in the terminal cycle through previous commands
- Arguments that contain spaces must be wrapped with 'single' or "double" quotes
- `$@` includes all arguments; `@` often means "everything" in computer code
- Two kinds of **variables**:
  - **Arguments** are variables set from the command line (`$1`, `$2`, and `$3`, etc)
  - **Constants** are variables that do not change (`$SHOE`, `$USER`, and `$PWD`, etc)
- Your environment (login session) has several constants
- These "environment constants" that can be called anytime in the terminal and in scripts
- In the terminal `echo $ENVIRONMENT_CONST` = `printenv ENVIRONMENT_CONST`
- `pwd` = `printenv PWD` = `echo $PWD`
  - This shows the full, current location used by the terminal, AKA the "Present Working Directory"
- Variables (environment constants also) can be used in a command
- Variables used as arguments will pass their "value" as the argument
- We will look at **constants**  more in [401 Lesson 5](https://github.com/inkVerb/vip/blob/master/401/Lesson-05.md#viii-readonly-variables-constants)
___

#### [Lesson 4: Setting Variables & Setting Files](https://github.com/inkVerb/vip/blob/master/101/Lesson-04.md)
