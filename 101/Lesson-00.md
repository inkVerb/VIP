# Linux 101
## Lesson 0: Terminal Control

___

Ready the CLI

*<kbd>Scroll Lock</kbd> OR <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd> OR <kbd>F12</kbd> (or new terminal from the desktop menus)*

*Copy and paste this into the **terminal***

| **1** :$

```console
mkdir -p ~/School/VIP/101
```

*Note in the command line above, `mkdir` is the **command** while `mkdir -p ~/School/VIP/101` is the **command line***

*Using the terminal is also called using the **CLI** (as opposed to the **GUI**, which uses the mouse much more)*

| **2** :$

```console
cd ~/School/VIP/101
```

___

### Controlling apps via terminal

| **3** :$

```console
gedit
```

*Note gedit opened on the desktop **GUI***

*gedit can be called a **process***

*Terminal: <kbd>Ctrl</kbd> + <kbd>Z</kbd>*

*Note gedit won't respond*

| **4** :$

```console
jobs
```

*gedit's **job** number should be 1*

| **5** :$

```console
fg 1
```

*Note gedit is no longer **stopped**, it is in the termina's **foreground**, but the terminal is still **occupied***

*Terminal: <kbd>Ctrl</kbd> + <kbd>Z</kbd>*

*Note gedit stopped again*

| **6** :$

```console
bg 1
```

*Note gedit is no longer stopped, nor is the terminal occupied, but gedit runs in the termina's **background***

| **7** :$

```console
jobs
```

*Note the terminal registeres getid "**Running**"*

| **8** :$

```console
killall gedit
```

*Note gedit closed*

| **9** :$

```console
jobs
```

*Note the terminal registeres gedit "**Terminated**"*

| **10** :$

```console
gedit
```

*Terminal: <kbd>Ctrl</kbd> + <kbd>C</kbd>*

*Note gedit closed*

| **11** :$

```console
jobs
```

*Note gedit either does not register or registers "Done"*

| **12** :$

```console
gedit &
```

*Note the terminal is not **occupied** because we added `&`*

*Run another program, Mines (`gnome-mines`)*

| **13** :$

```console
gnome-mines &
```

| **14** :$

```console
jobs
```

*This is how to **kill** job number 2:*

| **15** :$

```console
kill %2
```

*Note Mines closed*

| **16** :$

```console
jobs
```

*Note the terminal registers Mines "Terminated"*

___

# Glossary
- **command** - the first "word" of something entered into the terminal, which then does something
- **command line** - the entire set of "words" entered into the terminal together, which then does something
- **CLI** - Command Line Interface - AKA the terminal - interacting with programs and files by typing commands
- **CLI/GUI** - Command Line Interface / Graphical User Interface - these terms are mutually exclusive and distinguish one from the other
  - *CLI* generally suggests *not GUI*
  - *GUI* generally suggests *not CLI*
- **background** - job is running, not occupying its terminal
- **foreground** - job is running, occypying its terminal
- **GUI** - Graphical User Interface - such as the desktop where software applications can be controlled visually with eye candy
- **job** - a process run from the specific terminal in mention
- **kill** - force a job or process to terminate, not terminating itself
  - If you turn off the computer without closing an app, the system "kills" the app
  - "Killing" an app means it does not save its work
  - "Killing" a web browser may cause a "did not close properly... restore session?" dialog the next time it opens
  - "Killing" an app from the terminal should be a last resort if it it crashes and won't respond
- **occupied** - the terminal is handling a job, so it can't be used
- **process** - a software application (app) operational/running on the system
- **running** - a job is operational on the system and responding normally
- **stopped** - a job is "frozen", but still alive on the system (via <kbd>Ctrl</kbd> + <kbd>Z</kbd> in the terminal)
- **terminal** - the code screen where commands are entered, using input and output
- **terminated** - when a job has been killed

## Terms for desktop apps
- *These are only for the GUI, not the CLI*
- **open** - a window on the desktop starts and can be seen on the desktop
- **resize** - changing the size of an open window on the desktop by clicking and adjusting the edge of the window
- **minimized** - a window cannot be seen, but is still listed on a taskbar, system tray, or with <kbd>Alt</kbd> + <kbd>Tab</kbd> 
- **maximized** - a window takes up the full screen and cannot be resized; on most systems, click the "maximize" button in the corner of the window or double click on the title bar of the window (to maximize) or drag the window down from the top to (to un-maximise)
- **restored** - AKA "un-minimized" or "un-maximized" - a window can be seen on the desktop and can be resized, after having been minimized or maximized
- **full screen** - a window fills the screen and the title bar can't be seen; it cannot be minimized, resotred, or maximized
  - Swith this back and forth with <kbd>F11</kbd> - *this is very useful when focusing on only one desktop application, don't be fraid to use it often*


# The Take
- The terminal can control desktop app sessions, such as gedit and Gnome Mines and others
- **<kbd>Ctrl</kbd> + <kbd>Z</kbd>** and **<kbd>Ctrl</kbd> + <kbd>C</kbd>** manage apps started from their terminal
- We use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> and <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>V</kbd> in the terminal for copy-paste
- Open gedit from the GUI before entering it as a terminal command
- `jobs`, `fg #`, `bg #`, `kill %#`, and `command &` also manage apps started from their terminal
- `killall app-name` will end all sessions of "app-name", whether started from the same terminal or not

___

#### [Lesson 1: gedit, echo & sed](https://github.com/inkVerb/vip/blob/master/101/Lesson-01.md)
