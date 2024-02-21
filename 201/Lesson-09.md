# Linux 201
## Lesson 9: File Size, du, df, top, ps aux, pgrep, kill

Ready the CLI (might not be needed)

```console
cd ~/School/VIP/201
```

#### [VIP/Cheat-Sheets: Resources & Things That Run](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)
#### [VIP/Cheat-Sheets: File Size, Binary, Hexadecimal](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Sizes-Binary-Hex.md)

___

### I. File sizes

i. Watch this video & notice the numbers: [RGB](https://www.youtube.com/watch?v=HX46ILgwTNk)
- Top row: Binary (0–1)
- Mid Row: Decimal (0–9)
- Bottom Row: Hexadecimal (0–F)

ii. bites, etc
- **1 bit** = A single binary digit (`0` or `1`)
- **1 Byte** = 8 bits
- **1 Kilobyte (KB)** = 1,024 Bytes
- **1 Megabyte (MB)** = 1,024 Kilobytes
- **1 Gigabyte (GB)** = 1,024 Megabytes
- **1 Terabyte (TB)** = 1,024 Gigabytes

iii. File sizes (very generic approximation)
- 1 minute of audio is about 10MB for normal files (128 bit)
- 1 picture is about 1MB (1920x1080px, .png; 2560x1600px, .jpg)
  - Learn more about image [pictypes](https://github.com/inkVerb/pictypes/blob/master/README.md)
- 1 hour video is about 1GB (1920x1080)

Learn more about sizes and binary: 

### II. `du` & `df`

*Go to your home directory*

| **1** :$

```console
cd ~/
```

- **`du`: "Disk Usage"**
- **`df`: "Disk Filesystem"**
- **"T": "Type"**
- **"h": "Human"**
- **"s": "Summarize"**

| **2** :$

```console
du -sh *
```

| **3** :$

```console
du -sh School
```

*Note it can tell you the size of just one directory*

*Note the list of each directory's size*

| **4** :$

```console
df -k
```

*Note it listed everything in blocks (1 kilobyte = 1 block)*

| **5** :$

```console
df -h
```

*Note it listed everything human-readable (in megabytes and gigabytes, etc)*

| **6** :$

```console
df -T
```

*Note it also showed the disk types*

### III. `top` & `uptime`

*Now go back to where our 201 directory*

| **7** :$

```console
cd ~/School/VIP/201
```

| **8** :$

```console
top
```

*Notice the realtime process list*

Q (or <kbd>Ctrl</kbd> + <kbd>C</kbd>) *This will CLOSE the top program*

| **9** :$

```console
top -n 1
```

*Notice the `top` list is not realtime:*

- *`-n 1` shows only one "iteration"*
- *`-n 3` shows only three "iterations"*

| **10** :$

```console
top -n 1 -b
```

*Notice `-b` shows everything all the way to the Bottom (not limited by the size of the terminal window, only limited by the `-n 1` iteration option)*

*It might be useful to put it in a file...*

| **11** :$

```console
top -n 1 -b > top.file
```

| **12** :$

```console
gedit top.file
```

*FYI, this is a little program we installed in Lesson 3, a little more colorful than `top`...*

| **13** :$

```console
htop
```

F10 (or Q to Quit)

*For a quick peek:*

| **14** :$

```console
uptime
```

### IV. `ps aux`

| **15** :$

```console
ps aux
```

*Note the list of every running process, but it is not realtime, so you can scroll through it*

Make sure you are NOT using the browser in this command before finishing this lesson!

| **16-C** :$

```console
firefox &
```

| **16-F** :$ (if using Firefox)

```console
chromium-browser &
```

*Note we used `&` to keep it from blocking the terminal*

| **17** :$

```console
ps aux
```

*Scroll to look for that browser's process ID (PID)*

*This uses pipe and grep to find it*

| **18-C** :$

```console
ps aux | grep firefox
```

| **18-F** :$ (if using Firefox)

```console
ps aux | grep chromium-browser
```

*This does the same thing*

### V. `pgrep` & `kill`

| **19-C** :$

```console
pgrep firefox
```

| **19-F** :$ (if using Firefox)

```console
pgrep chromium-browser
```

*Note the PID, it's the number*

| **20** :$ e.g. `kill 71771`

```console
kill PID
```

*Run it again*

| **21-C** :$

```console
firefox &
```

| **21-F** :$ (if using Firefox)

```console
chromium-browser &
```

*Now kill it by process name using `killall`*

| **22-C** :$ 

```console
killall firefox
```

| **22-F** :$ (if using Firefox)

```console
killall chromium-browser
```

*Some processes can only be killed by PID*

*Refer to this cheat-sheet for more about `ps`, `du`, `df` and others:* [VIP/Cheat-Sheets: Resources & Things That Run](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)

___

# The Take

- `du` & `df` output disk and directory size
  - `du` lists directories and size
  - `df` shows more system and "available space" information
  - `df -T` shows same as `df -h` but also with disk types
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

#### [Lesson 10: COMMAND > FILE, pwd, uname, who, w](https://github.com/inkVerb/vip/blob/master/201/Lesson-10.md)
