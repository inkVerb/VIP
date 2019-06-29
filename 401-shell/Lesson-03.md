# Shell 401
## Lesson 3: Cron Daemon & $PATH Variable

`cd ~/School/VIP/shell/401`

- [Cron Schedule Tasks](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md)
___

### I. The `$PATH` Environment Variable

#### What is `$PATH`?

A script or other program ***not*** in the path needs this:
  - `/full/path/to/script` or
  - `./script` (when in the directory of the script)

But, scripts and programs with directories listed in the `$PATH` can be run this way:
  - `script`

| **1** : `printenv`

*Look for "PATH"*

*Get a closer look via terminal and gedit...*

| **2** : `echo $PATH | tee mypath && gedit mypath`

*This is the "$PATH" environment variable, the list of directories where executable files can be run by filename only*

*The $PATH is why commands work as commands, why `echo` isn't `./echo`*

*Note each colon `:` separates a different directory path included in the $PATH*

*Let's use `sed` to resort them to go onto each line*

| **3** : `sed -i "s/:/\n/g" mypath`

*gedit: Reload mypath*

*Let's do it in one command:*

| **4** : `echo $PATH | sed "s/:/\n/g"`

**This nifty little script basically does the same thing with a `do` loop, listing each directory of the $PATH on a new line:**

*Edit the script*

| **5** : `gedit listpath`

*It should look like this:*

```sh
#!/bin/sh

# Set the field separator for the `for` loop to the `:` that separates dirs in the "$PATH"
IFS=:
# If we don't put "$PATH" in "double-quotes", each dir will appear on one line
# Try removing the "double-quotes" from "$PATH" on the line below to see what happens
# Also try changing the "double-quotes" to 'single-quotes' to see what happens
for pdir in $(echo "$PATH"); do
  echo $pdir
done
```

| **6** : `./listpath`

**The point of all this so far:**
- *$PATH contains many directories*
- *Each directory in $PATH is separated by a colon `:`*
- *Files in these directories can be run without entering the entire path.*

#### Running non-`$PATH` scripts

***Using the full path*** *let's run a small script containing this:*

*Edit the script*

| **7** : `gedit iamexec`

*It should look like this:*

```sh
#!/bin/sh
echo "I am executable, but I am not in the \$PATH."
```

*Same script, same location, three different ways to execute...*

1. Relative `/home/` path: `~/...`

| **8** : `~/School/VIP/shell/401/iamexec`

2. "here" path: `./`

| **9** : `./iamexec`

3. "full path" (get with `pwd`)

*Enter the output of this as a new command in the terminal:*

| **10** : `echo "$(pwd)/iamexec"`

*...Something like: `/home/USERNAME/School/VIP/shell/401/iamexec` ...enter it as a command*

**The point of all this so far:**
- *Any file not in a directory listed in $PATH can only be run by including the path to the file, like `./FILE` or `/full/path/to/FILE`*

#### Find a command's full path using `which` & `whereis`

*You can check "`which`" directory of the $PATH a command is located in...*

| **11** : `which cp`

| **12** : `which sed`

| **13** : `which grep`

| **14** : `which gedit`

| **15** : `which firefox`

*Similar, but returns more information: `whereis`*

| **16** : `whereis firefox`

*You should find that these locations generally respect the [File System Hierarchy (FSH)](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-02.md).*

**Add dirs to $PATH:**

*You can add as many extra directories as you want to your user's $PATH...*
- In this file: `~/.bashrc`
- Add a line with: `export PATH=$PATH:/added/dir:/add/another/dir:/add/more/dirs`
- Careful, adding insecure files could be a way to hack your machine, use mindfully and only add directories you ***need***

### II. The `cron` Daemon

*Schedule software to run at regular times*

Cron tasks are processes (usually in a Shell script) that are automatically run by the system on a regular basis

| **17** : `cd /etc`

| **18** : `ls` *(Scroll up to find the `cron` directories)*

#### Normal Schedules

| **19** : `cd cron.daily/`

| **20** : `ls -l`

The system will automatically run `cron` scripts on its own scheduled basis in four `cron` directories:
- Hourly: `/etc/cron.hourly/`
- Daily: `/etc/cron.daily/`
- Weekly: `/etc/cron.weekly/`
- Monthly: `/etc/cron.monthly/`

**Instructions:**
1. Each file here is a simple BASH or Shell script
2. File Permissions: `rwxr-xr-x` set with: `chmod 755 CRON_SCRIPT_NAME`

#### Custom Schedules
To have more control of the time a `cron` task will run, put `cron` files here:
- Cron directory: `/etc/cron.d/`

| **21** : `cd ../cron.d/`

| **22** : `ls -l`

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
2. File Permissions: `rw-r--r--` set with: `chmod 644 CRON_TASK_NAME`
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

#### [Lesson 4: MySQL & systemctl](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-04.md)
