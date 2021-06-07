# Shell 401
## Lesson 3: Cron Daemon & $PATH Variable

Ready the CLI

`cd ~/School/VIP/401`

- [Cron Schedule Tasks](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md)
___

### I. The `$PATH` Environment Variable

#### What is `$PATH`?

A script or other program ***not*** in the path needs this:
  1. `/full/path/to/script` "full" path
  2. `~/myhome/to/script` "home" path
  3. `./script` "here" path (when in the directory of the script)

But, scripts and programs with directories listed in the `$PATH` can be run this way:
  - `script`

| **1** :$

```console
printenv
```

*Look for "PATH"*

*More specifically...*

| **2** :$

```console
printenv PATH
```

*This is a colon (`:`) -separated list of directories where executable files may be executed from **without entering the /complete/path/to/the/file***

*Let's make this $PATH more readable,  use `sed` to resort them to go onto each line...*

| **3** :$

```console
echo $PATH | sed "s/:/\n/g" | tee mypath && gedit mypath
```

*The $PATH is why commands work as commands, why we can type `echo` instead of `./echo`*

| **4** :$

```console
echo $PATH
```

*Note each colon `:` separates a different directory path included in the $PATH*

*Note this contains many directories from the [File System Hierarchy (FSH) in 201 Lesson 12](https://github.com/inkVerb/vip/blob/master/201/Lesson-12.md)*

**The point of all this so far:**
- *$PATH contains many directories*
- *Each directory in $PATH is separated by a colon `:`*
- *Files in these directories can be run without entering the entire path.*

#### Executing a script or other file outside the `$PATH`

***Using the full path*** *let's run a small script containing this:*

*Edit the script*

| **5** :$

```console
gedit iamexec
```

*It should look like this:*

| **iamexec** :

```sh
#!/bin/sh
echo "I am executable, but I am not in the \$PATH."
```

*Try to run it with only the script filename as the STDIN (input)...*

| **6** :$

```console
iamexec
```

*It won't work because the script file is not located in the $PATH!*

#### Three ways to execute a file outside the `$PATH`

*Same script, same location, three different ways to execute...*

1. "full" path (get with `pwd`)

*Enter the output of this as a new command in the terminal:*

| **7** :$

```console
echo "$(pwd)/iamexec"
```

2. "`/home/`" path: `~/...`

| **8** :$

```console
~/School/VIP/401/iamexec
```

*...or (since `.` = "current directory") this an easier way to do the same thing...*

3. "here" path: `./...`

| **9** :$

```console
./iamexec
```

*...Something like: `/home/USERNAME/School/VIP/shell/401/iamexec` ...enter it as a command*

**The point of all this so far:**
- *Any file not in a directory listed in $PATH can only be run by including the path to the file, like: `./FILE` or `/full/path/to/FILE`*

#### Find a command's full path using `which` & `whereis`

*You can check "`which`" directory of the $PATH a command is located in...*

| **10** :$

```console
which cp
```

| **11** :$

```console
which sed
```

| **12** :$

```console
which grep
```

| **13** :$

```console
which gedit
```

| **14** :$

```console
which firefox
```

*Similar, but returns more information: `whereis`*

| **15** :$

```console
whereis firefox
```

*You should find that these locations generally respect the [File System Hierarchy (FSH)](https://github.com/inkVerb/vip/blob/master/201/Lesson-12.md).*

**Add dirs to $PATH:**

*You can add as many extra directories as you want to your user's $PATH...*
- In this file: `~/.bashrc`
- Add a line with: `export PATH=$PATH:/added/dir:/add/another/dir:/add/more/dirs`
- Careful, adding insecure files could be a way to hack your machine, use mindfully and only add directories you ***need***

### II. The `cron` Daemon

*Schedule software to run at regular times*

Cron tasks are processes (usually in a Shell script) that are automatically run by the system on a regular basis

| **16** :$

```console
cd /etc
```

| **17** :$ *(Scroll up to find the `cron` directories)*

```console
ls
```

#### Normal Schedules

| **18** :$

```console
cd cron.daily/
```

| **19** :$

```console
ls -l
```

The system will automatically run `cron` scripts on its own scheduled basis in four `cron` directories:
- Hourly: `/etc/cron.hourly/`
- Daily: `/etc/cron.daily/`
- Weekly: `/etc/cron.weekly/`
- Monthly: `/etc/cron.monthly/`

**Instructions:**
1. Each file here is a simple BASH or Shell script
2. File Permissions: `rwxr-xr-x` set with: `chmod 755 Cron_Script_Name`

#### Custom Schedules
To have more control of the time a `cron` task will run, put `cron` files here:
- Cron directory: `/etc/cron.d/`

| **20** :$

```console
cd ../cron.d/
```

| **21** :$

```console
ls -l
```

`cron` files (like these) contain simple lines that look like this:

```shell
0 5 * * * /path/to/script
```

Or, maybe with a user, such as "jim":

```shell
0 5 * * * jim /path/to/script
```

*All cron tasks are run as the "root" user unless specified otherwise*

**Instructions:**
1. Each `cron` file has one to-be-run Shell script *per line* with `cron` schedule settings (below & here: [VIP/Cheat-Sheets: Cron Schedule Tasks: I. Proper cron Task Line Formatting](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Cron.md#i-proper-cron-task-line-formatting))
2. File Permissions: `rw-r--r--` set with: `chmod 644 Cron_Task_File`
3. If creating the file by using `echo` use single 'quotes' since double "quotes" will change the meaning of some characters, though you may never see the difference in the text file
4. The Shell script listed at the end of the line *must be executable*, probably `rwxr-xr-x` set with: `chmod 755 SCRIPT_NAME`

*(Many developers don't like it when system admins put files here.)*

#### Managing jobs with `crontab`

The favorite way for a system admin to set up a custom `cron` task is using the `crontab` command

This will edit the file `/etc/crontab`, which is managed by the system

Crontab entries follow the same format as the files in `cd cron.d/` (see *Cron file schedule format* (below & here: [VIP/Cheat-Sheets: Cron Schedule Tasks: I. Proper cron Task Line Formatting](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md#i-proper-cron-task-line-formatting))

**Know this:**
1. The `crontab` profile has one to-be-run Shell script *per line* with `cron` schedule line formatting (below)
2. The Shell script listed at the end of the line *must be executable*, probably using: `chmod ug+x SCRIPT_FILE`
3. The first time you run `crontab` you will be asked to choose an editor, that's normal
4. `crontab` records are usually kept here: `/var/spool/cron/crontabs/USERNAME`, don't touch!
5. This is how most self-important instructors will tell everyone in the known multiverse to run `cron` tasks
  - You don't have to use your `crontab` profile, but if you ask for help with other `cron` methods, expect "ONLY use `crontab` you delinquent!" to be a common answer

**Instructions:**
1. Edit and make entries in your `crontab` profile with:
  - `crontab -e`
2. Use proper `cron` task line formatting (below & here: [VIP/Cheat-Sheets: Cron Schedule Tasks: I. Proper cron Task Line Formatting](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md#i-proper-cron-task-line-formatting))

#### `cron` File Schedule Format

Format of a `cron` line:

`[minute] [hour] [date_of_the_month] [month] [day_of_the_week] (user) [Shell_command]`

Example of a cron line:

**Everyday at 3:00 pm, run by user "john":**
```shell
0 15 * * * john /path/to/script
```

*An astric* **\*** *will run at all times for that setting.*

*Refer to this cheat-sheet for more about `cron` scheduling:* [VIP/Cheat-Sheets: Cron Schedule Tasks: I. Proper cron Task Line Formatting](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md#i-proper-cron-task-line-formatting)

### III. `cron` Problems

`cron` is a system-level process, so it is unforgiving, problems are common

**Consider:**
1. Proper formatting of the task line - *[cheat sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Cron.md#i-proper-cron-task-line-formatting)*
2. File permissions (`cron` task file & the script to run) - *[cheat sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Cron.md#1-permissions)*
3. $PATH declaration inside the `cron` task file - *[cheat sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Cron.md#2-path)*
4. If using `echo` to create the `cron` task file, use 'single quotes' - *[cheat sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Cron.md#3-characters-matter)*
5. Watch `journalctl` for `cron` errors and sear the Internet for solutions - *[cheat sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Cron.md#4-use-journalctl--f-to-troubleshoot-your-cron-task)*

- [VIP/Cheat-Sheets: Cron Schedule Tasks: III. Troubleshooting](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md#iii-troubleshooting)

___

# The Take

## $PATH
- *A script not in the path needs this:*
  - `/full/path/to/script` *or*
  - `./script` *(when in the directory of the script)*
- *But, scripts and programs with directories listed in the `$PATH` can be run this way:*
    - `script`
- The `$PATH` is the list of directories of files that can be executed from the terminal ***without*** entering the full directory path
  - *$PATH contains many directories*
  - *Each directory in $PATH is separated by a colon `:`*
  - *Files in these directories can be run without entering the entire path.*
  - *Any file not in a directory listed in $PATH can only be run by including the path to the file, like `./FILE` or `/full/path/to/FILE`*
- To find the current path, enter: `echo $PATH`
- The `$PATH` is defined for each user in: `~/.bashrc`
- To add a directory to the `$PATH`, put a line in `~/.bashrc` like:
  - `export PATH=$PATH:/ADD/DIR:/ANOTHER/DIR`
- `which COMMAND` outputs the location of the command, somewhere in the FSH

## Cron

- The system used "`cron`" to run programs on a given schedule
- All `cron` tasks run as the "root" user unless stated otherwise
- A `cron` setting looks like a lot like:
  - `0 5 * * * /path/to/program`
  - `* * 4 * * jim /path/to/program`
  - The numbers and asterisks in these represent minutes, hours, dates, months, and weekdays (in that order)
- Many regular `cron` schedules are in `/etc/cron-SOMETHING`
  - `/etc/cron.hourly/`
  - `/etc/cron.daily/`
  - `/etc/cron.weekly/`
  - `/etc/cron.monthly/`
  - `/etc/cron.d/`
  - `/etc/crontab` *(file, not a directory)*
- `crontab` is the "proper" way for a user to set up a regular `cron` task from the terminal
- Cron files are very finicky about location, permissions, and using `'single quotes'` to `echo` contents into their files
  - Permissions requirements can be different for `cron` files in different locations!
  - Usually, `cron` files in `/etc/cron.SOMEDIR/` directories need to be `644`
- Follow `cron` structure carefully and don't be sloppy!
- Refer to this cheat-sheet for more about `cron` scheduling: [VIP/Cheat-Sheets: Cron Schedule Tasks](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md)

___

#### [Lesson 4: MySQL & systemctl](https://github.com/inkVerb/vip/blob/master/401/Lesson-04.md)
