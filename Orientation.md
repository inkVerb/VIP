# Linux 101
## Orientation: How these lessons work

___

### GUI: Graphic User Interface

#### 'GUI' = computer desktop, where you click on pretty pictures to open and use software

### CLI: Command Line Interface

#### 'CLI' = how to work in the terminal

#### 'Script' = CLI commands put into a file to run automatically

### Formatting & instructions

This is normal text, which may label or tell something, it is rare in these lessons

*This italics text is a note that helps teach and explain something in a lesson*

*The following is called "preformatted text", AKA "code text", which uses a "monospace" font:* `preformatted monospace text` *`maybe italics all the same`*

*Below is a file named "`some-file.txt`" and it's contents...*

| **some-file.txt** :

```
I am plain text.
I am the contents of some-file.txt.
I am not a terminal command because I have no dollar sign nor hash sign.
I belong in your text editor where some-file.txt is open.
```

*When using copy-paste to enter a command into the terminal, <kbd>Ctrl</kbd> + <kbd>C</kbd> will work in a normal window, but use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>V</kbd> to paste into the terminal*

| **1** :$

```console
echo i am a command to be entered in the terminal
```

*These "command" numbers help keep track of your place in the lesson and clarify which code you should enter into the terminal*

| **2** :$ *This is a very important note specifically about the command just entered*

```console
echo i am another terminal command
```

| **3** :$

```console
third terminal command
```

*Note those were three terminal commands, but the third one didn't actually work, but you should have entered it anyway just to watch it not work*

`preformatted code like this` *that does not have a number is only for reference, not to be entered into the terminal*

*Let's enter the fourth and final command, which also won't work*

| **4** :$

```console
fourth broken command
```

### Capital and lowercase and ALLCAPS

*Look at this code:*

`code CODE -code foo Something CODE $code code bar $AnotherThing code $CODE mySomeThing`

- `Something`
- `$AnotherThing`
- `mySomeThing`
- `foo`
- `bar`

*...these are all "placeholders" because they mix upper and lower case, their text could be anything*

*...`foo` and `bar` are also normal conventions for demonstrating text that you would replace in your project*

*Everything wtih all caps or all lowercase (`code` or `CODE`) **probably** doesn't change in the Shell language*

*Sometimes, a placeholder example may appear as `your_user_name`, `username`, `ENVIRONMENT_CONSTANT`, etc, which should be somewhat obvious as placeholders*

### Exploring files

*Nautilus (file explorer) works alongside the terminal*

*Before starting a lesson, open Nautilus from the GUI*

*(GUI stands for Graphic User Interface, the normal windows of a desktop environment)*

*First, make the directory "School" (if it doesn't already exist)...*

| **5** :$

```console
mkdir -p ~/School
```

*Change the terminal to that directory*

| **6** :$

```console
cd ~/School
```

*Open Nautilus file explorer in that directory with: `nautilus .`*

| **7** :$

```console
nautilus .
```

### Creating & editing files

*Before starting a lesson, open gedit from the GUI*

| **8** :$

```console
gedit first-file
```

*Note that "`first-file`" is in the title of gedit, the text editor*

*Create `first-file` as this:*

*(Copy-Paste this into `first-file` in gedit:)*

| **first-file** :

```sh
This is a new file.

# v01
```

*Note the asterisk * in the title of gedit*

*Use <kbd>Ctrl</kbd> + <kbd>S</kbd> to save the file*

*Note the asterisk * went away and the file "`first-file`" appeared in Nautilus*

*Update `first-file` to version 02:*

*After copying the text below via <kbd>Ctrl</kbd> + <kbd>C</kbd>, in gedit, use <kbd>Ctrl</kbd> + <kbd>A</kbd>, <kbd>Ctrl</kbd> + <kbd>V</kbd>, <kbd>Ctrl</kbd> + <kbd>S</kbd>*

| **first-file** :

```sh
This is the same file, but a new version

# v02
```

*Version 2 of `first-file` should now be saved*

*Let's remove that file since we no longer need it*

| **9** :$

```console
rm first-file
```

*Note gedit still has the file open*

*Close gedit, but note it asks if you want to save the file: No, don't save*


**Yeah! Orientaion is finished! Let's review what we take away from this...**

___

# The Take

- GUI stands for "Graphic User Interface"
  - *This may also be called "using the desktop"*
- CLI stands for "Command Line Interface"
- CLI commands can be entered into the terminal
  - *This is called "using the CLI"*
- Non-commands entered into the terminal will return an error message
- `preformatted` text (AKA `code`) is ***either*** a terminal command or part of code that belongs in a file
  - *This is normal for most code-related websites*
- | **1** :$ indicates a command to be entered in the terminal

```console
code for terminal
```
- Nautilus is the name of the file browser... because we're "under the sea..."
- Gedit is the text editor we will use, gedit? (See what I did there?)
- An asterisk * in the gedit title indicates that the file has been changed, but not saved
- If a file is deleted while open in gedit, gedit will ask if you want to save before closing

___
#### [Lesson 0: Terminal Control](https://github.com/inkVerb/vip/blob/master/101/Lesson-00.md)
