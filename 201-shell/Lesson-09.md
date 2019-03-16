# Shell 201
## Lesson 9: du, df, top, ps aux, pgrep, kill

`cd ~/School/VIP/shell/201`

___

*Go to your home directory*

| **1** : `cd ~/`

### `du` & `df`

| **2** : `du -sh *`

*Note the list of each directory's size*

| **3** : `df -k`

*Note it listed everything in kilobytes*

| **4** : `df -h`

*Note it listed everything in megabytes and gigabytes, et cetera*

| **5** : `du -sh School`

*Note it can tell you the size of just one directory*

*Now go back to where our 201 directory*

| **6** : `cd ~/School/VIP/shell/201`

### `top` & `uptime`

| **7** : `top`

*Notice the realtime process list*

Q (or Ctrl + C) *This will CLOSE the top program*

| **8** : `top -n 1` Q

*Notice the* `top` *list is not realtime;* `-n 1` *shows only one "iteration",* `-n 3` *would show three*

| **9** : `top -n 1 -b` Q

*Notice* `-b` *shows everything, not limited by the size of the terminal window, only limited by the* `-n 1` *option*

*FYI, this is a little program we installed in Lesson 3, a little more colorful than* `top`

| **10** : `htop`

F10 (or Q to Quit)

*For a quick peek:*

| **11** : `uptime`

### `ps aux`

| **12** : `ps aux`

*Note the list of every running process, but it is not realtime, so you can scroll through it*

Select ONE browser you are NOT using:

| **13** : `firefox &` or `chromium-browser &` or `google-chrome &` or `vivaldi &`

*Note we used* `&`*to keep it from blocking the terminal*

| **14** : `ps aux`

*Scroll to look for that browser's process ID (PID)*

*This uses pipe and grep to find it*

| **15** : `ps aux | grep firefox` or `ps aux | grep chromium-browser` or `ps aux | grep google-chrome` or `ps aux | grep vivaldi`

*This does the same thing*

### `pgrep` & `kill`

| **16** : `pgrep firefox` or `pgrep chromium-browser` or `pgrep google-chrome` or `pgrep vivaldi`

*Note the PID, it's the number*

| **17** : `kill PID` e.g. `kill 71771`

*Run it again*

| **18** : `firefox &` or `chromium-browser &` or `google-chrome &` or `vivaldi &`

*Now kill it by process name using* `killall`

| **19** : `killall firefox` or `killall chromium-browser` or `killall google-chrome` or `killall vivaldi`

*Some processes can only be killed by PID*

*Refer to this cheat-sheet for more about `ps`, `du`, `df` and others:* [VIP/Cheet-Sheets: Resources & Things That Run](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)

___

# The Take

- `du` & `df` output disk and directory size
  - `du` lists directories and size
  - `df` shows more system and "available space" information

___

#### [Lesson 10: COMMAND > FILE, pwd, uname, who, w](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-10.md)
