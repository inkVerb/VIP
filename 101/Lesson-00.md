# Shell 101
## Lesson 0: Terminal Control

___

## Prepare

*<kbd>Scroll Lock</kbd> OR <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd> OR <kbd>F12</kbd>(new terminal)*

| **1** :$

```console
mkdir -p ~/School/VIP/101
```

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

*Note gedit opened*

*In Terminal: <kbd>Ctrl</kbd> + <kbd>Z</kbd>*

*Note gedit won't respond*

| **4** :$

```console
jobs
```

*gedit's job number should be 1*

| **5** :$

```console
fg 1
```

*Note gedit is no longer stopped*

*Terminal: <kbd>Ctrl</kbd> + <kbd>Z</kbd>*

| **6** :$

```console
bg 1
```

| **7** :$

```console
jobs
```

| **8** :$

```console
killall gedit
```

*Note gedit closed*

| **9** :$

```console
jobs
```

*Note the terminal registeres gedit "Terminated"*

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

*Note the terminal is not occupied because we added `&`*

*Run another program, Mines (`gnome-mines`)*

| **13** :$

```console
gnome-mines &
```

| **14** :$

```console
jobs
```

*This is how to kill job number 2:*

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

# The Take

- The terminal can control desktop app sessions, such as gedit and Gnome Mines and others
- **<kbd>Ctrl</kbd> + <kbd>Z</kbd>** and **<kbd>Ctrl</kbd> + <kbd>C</kbd>** manage apps started from their terminal
- We use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> and <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>V</kbd> in the terminal for copy-paste
- Open gedit from the GUI before entering it as a terminal command
- `jobs`, `fg #`, `bg #`, `kill %#`, and `command &` also manage apps started from their terminal
- `killall app-name` will end all sessions "app-name", whether started from the same terminal or not

## Terms for apps

- **stopped** - When an app is told to pause and not respond (via <kbd>Ctrl</kbd> + <kbd>Z</kbd> in the terminal)
- **terminated** - After an app is closed
- **running** - While an app is working and responding normally
- **kill**/**killing** - When an app is forcefully closed, without the app closing itself
  - If you turn off the computer without closing an app, the system "kills" the app
  - "Killing" an app means it does not save its work
  - "Killing" a web browser may cause a "did not close properly... restore session?" dialog the next time it opens
  - "Killing" an app from the terminal should be a last resort if it it crashes and won't respond

___

#### [Lesson 1: gedit, echo & sed](https://github.com/inkVerb/vip/blob/master/101/Lesson-01.md)
