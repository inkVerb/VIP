# Shell 101
## 0-Rientation: (Orientation) How these lessons work

___

### Formatting & instructions

This is normal text, which may label or tell something, it is rare in these lessons.

*This italics text is a note that helps teach and explain something in a lesson*

*The following is called "preformatted" text, which uses a "monospace" font:* `preformatted monospace text` *`maybe italics all same`*

*Preformatted text indicates computer code. Many websites do this `i am computer code`*

*This note explains code later on this line, but don't enter it in the terminal `read me but not for terminal`*

*When a line begins with a number like this number 257:* | **257** : *enter the `preformatted text` after it into the terminal*

*When using copy-paste to enter a command into the terminal, Ctrl + C will work in a normal window, but use Ctrl + Shift + V to paste into the terminal*

*Copy this code (called 'Command 1') to the clipboard with Ctrl + C, then paste it into the terminal with Ctrl + Shift + V...*

| **1** : `echo i am a command to be entered in the terminal`

*These "command" numbers help keep track of your place in the lesson and clarify which code you should enter into the terminal*

| **2** : `echo i am another terminal command` *This is a very important note specifically about the command just entered*

| **3** : `third terminal command`

*Note those were three terminal commands, but the third one didn't actually work, but you should have entered it anyway just to watch it not work*

`preformatted code like this` *that does not have a number is only for reference, not to be entered into the terminal*

*Let's enter the fourth and final command, which also won't work*

| **4** : `fourth broken command`

*That's the end of the Orientation*

*Now, on to a basic understanding of controlling an app from the terminal...*

### Exploring files

*Nautilus (file explorer), works alongside the terminal*

*Open Nautilus from the GUI*

*(GUI stands for Graphic User Interface, the normal windows of a desktop environment)*

*First, make the directory "School" (if it doesn't already exist)...*

| **5** : `mkdir -p ~/School`

*Change the terminal to that directory*

| **6** : `cd ~/School`

*Open Nautilus file explorer in that directory with: `.`*

| **7** : `nautilus .`

### Creating & updating files

| **8** : `gedit first-file`

*Note that "first-file" is in the title of gedit, the text editor*

*Create first-file as this:*

*(Copy-Paste this into first-file in gedit:)*

**first-file**:

```sh
This is a new file.

# v01
```

*Note the asterisk * in the title of gedit*

*Use Ctrl + S to save the file*

*Note the asterisk * went away and the file "first-file" appeared in Nautilus*

*Update first-file to version 02:*

*After copying the text below via Ctrl + C, in gedit, use Ctrl + A, Ctrl + V, Ctrl + S*

```first-file```:

```sh
This is the same file, but a new version

# v02
```

*Version 2 of first-file should now be saved*

*Let's remove that file since we no longer need it*

| **9** : `rm first-file`

*Note gedit still has the file open*

*Close gedit, but note it asks if you want to save the file: No, don't save*

**Yeah! 0-rientaion is finished! Let's review what we take away from this...**

___

# The Take

- Commands can be entered into the terminal
- Non-commands entered into the terminal will return an error message
- `preformatted` text (AKA `code`) is either a terminal command or part of a program
  - *This is normal for most code-related websites*
- | **1** : `code for terminal` indicates a command to be entered in the terminal
  - *This is not normal for code-related websites, but used for this VIP Linux tutorial*
- Nautilus is the name of the file browser... because we're "under the sea..."
- Gedit is the text editor we will use, gedit? (See what I did there?)
- An asterisk * indicates that the file is not saved
- If a file is deleted while open in gedit, gedit will ask if you want to save before closing

___
#### [Lesson 0: Terminal Control](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-00.md)
