# Shell 201
## Lesson 9: du, df, top, ps aux, pgrep, kill

Ready the CLI (might not be needed)

`cd ~/School/VIP/201`

#### [VIP/Cheat-Sheets: Resources & Things That Run](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)

___

### File sizes

i. Watch this video & notice the numbers: [RGB](https://www.youtube.com/watch?v=HX46ILgwTNk)
- Top row: Binary (0–1)
- Mid Row: Decimal (0–9)
- Bottom Row: Hexadecimal (0–F)

ii. bites, etc
- **1 bit** = A single binary digit (0 or 1)
- **1 Byte** = 8 bits
- **1 Kilobyte (KB)** = 1,000 Bytes
- **1 Megabyte (MB)** = 1,000 Kilobytes
- **1 Gigabyte (GB)** = 1,000 Megabytes
- **1 Terabyte (TB)** = 1,000 Gigabytes

iii. File sizes (very generic approximation)
- 1 minute of audio is about 10MB for normal files (128 bit)
- 1 picture is about 1MB (1920x1080px, .png; 2560x1600px, .jpg)
  - Learn more about image [pictypes](https://github.com/inkVerb/pictypes/blob/master/README.md)
- 1 hour video is about 1GB (1920x1080)

*Go to your home directory*

| **1** : `cd ~/`

### `du` & `df`

- **`du`: "Disk Usage"**
- **`df`: "Disk Filesystem"**
- **"h": "Human"**
- **"s": "Summarize"**

| **2** : `du -sh *`

*Note the list of each directory's size*

| **3** : `df -k`

*Note it listed everything in kilobytes*

| **4** : `df -h`

*Note it listed everything in megabytes and gigabytes, etc*

| **5** : `du -sh School`

*Note it can tell you the size of just one directory*

*Now go back to where our 201 directory*

| **6** : `cd ~/School/VIP/201`

### `top` & `uptime`

| **7** : `top`

*Notice the realtime process list*

Q (or Ctrl + C) *This will CLOSE the top program*

| **8** : `top -n 1`

*Notice the `top` list is not realtime:*

- *`-n 1` shows only one "iteration"*
- *`-n 3` shows only three "iterations"*

| **9** : `top -n 1 -b`

*Notice `-b` shows everything all the way to the Bottom (not limited by the size of the terminal window, only limited by the `-n 1` iteration option)*

*It might be useful to put it in a file...*

| **10** : `top -n 1 -b > top.file`

| **11** : `gedit top.file`

*FYI, this is a little program we installed in Lesson 3, a little more colorful than `top`...*

| **12** : `htop`

F10 (or Q to Quit)

*For a quick peek:*

| **13** : `uptime`

### `ps aux`

| **14** : `ps aux`

*Note the list of every running process, but it is not realtime, so you can scroll through it*

Make sure you are NOT using Firefox before finishing this lesson!

| **15** : `firefox &`

*Note we used `&` to keep it from blocking the terminal*

| **16** : `ps aux`

*Scroll to look for that browser's process ID (PID)*

*This uses pipe and grep to find it*

| **17** : `ps aux | grep firefox`

*This does the same thing*

### `pgrep` & `kill`

| **18** : `pgrep firefox`

*Note the PID, it's the number*

| **19** : `kill PID` e.g. `kill 71771`

*Run it again*

| **20** : `firefox &`

*Now kill it by process name using `killall`*

| **21** : `killall firefox` or `killall chromium-browser` or `killall google-chrome` or `killall vivaldi`

*Some processes can only be killed by PID*

*Refer to this cheat-sheet for more about `ps`, `du`, `df` and others:* [VIP/Cheat-Sheets: Resources & Things That Run](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)

___

# The Take

- `du` & `df` output disk and directory size
  - `du` lists directories and size
  - `df` shows more system and "available space" information
- "PID" stands for "process ID", it is the ID number used to control a running app
- `ps` outputs information about running processes
  - `ps aux` is probably the most common usage
  - `ps aux | grep PROCESS` helps to find a running process in the `ps aux` output list
- `pgrep` outputs only a processes PID
  - This is useful to kill an app from the terminal via `kill PID`
- See usage and examples here: [VIP/Cheat-Sheets: Resources & Things That Run](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)
- `top` outputs a realtime list of the system's top-biggest processes
  - **Q** will quit
  - `top` will only output what the height of the terminal can display without scrolling
  - `top -n 1` shows only one "itteration", not realtime
  - `top -n 1 -b` same as above, `-b` shows all info regardless of terminal height
- `htop` is like `top`, but prettier and easier to read
  - **F10** will quit, but so will **Q** if **F10** is unavailable
- `uptime` shows only the uptime, which equals the "demigod" status of a Linux guru
- **"human"**: The "h" stands for "human" in many commands, including:
  - `du -sh *`
  - `df -h`
  - `htop`

___

#### [Lesson 10: COMMAND > FILE, pwd, uname, who, w](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-10.md)
