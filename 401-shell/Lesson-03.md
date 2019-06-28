# Shell 401
## Lesson 3: Cron Daemon

___

## Schedule software to run at a regular time

Cron tasks are processes (usually in a Shell script) that are automatically run by the system on a regular basis.

| **1** : `cd /etc`

| **2** : `ls` *(Scroll up to find the cron directories)*

### Normal Schedules

| **3** : `cd cron.daily/`

| **4** : `ls -l`

The system will automatically run cron scripts on its own scheduled basis in four cron directories:
- Hourly: `/etc/cron.hourly/`
- Daily: `/etc/cron.daily/`
- Weekly: `/etc/cron.weekly/`
- Monthly: `/etc/cron.monthly/`

**Instructions:**
1. Each file here is a simple BASH or Shell script.
2. File Permissions: `rwxr-xr-x` set with: `chmod 755 CRON_FILE_NAME`

### Custom Schedules
To have more control of the time a cron task will run, put cron files here:
- Cron directory: `/etc/cron.d/`

| **5** : `cd ../cron.d/`

| **6** : `ls -l`

Cron files (like these) contain simple lines that look like this:

```shell
0 5 * * * /path/to/script
```

Or, maybe with a user, such as "jim":

```shell
0 5 * * * jim /path/to/script
```

*All cron tasks are run as the "root" user unless specified otherwise*

**Instructions:**
1. Each cron file has one to-be-run Shell script *per line* with cron schedule settings (below).
2. File Permissions: `rw-r--r--` set with: `chmod 644 CRON_FILE_NAME`
3. If creating the file by using `echo` use single 'quotes' since double "quotes" will change the meaning of some characters, though you may never see the difference in the text file.
4. The Shell script listed at the end of the line *must be executable*, probably using: `chmod ug+x SCRIPT_FILE`

*(Many developers don't like it when system admins put files here.)*

### Managing jobs with `crontab`

The favorite way for a system admin to set up a custom cron task is using the `crontab` command.

This will edit the file `/etc/crontab`, which is managed by the system.

Crontab entries follow the same format as the files in `cd cron.d/` (see *Cron file schedule format* below)

**Instructions:**
1. The 'crontab' file has one to-be-run Shell script *per line* with cron schedule settings (below).
2. The Shell script listed at the end of the line *must be executable*, probably using: `chmod ug+x SCRIPT_FILE`
3. The first time you run `crontab` you will be asked to choose an editor, that's normal.
4. `crontab` records are usually kept here: `/var/spool/cron/crontabs/USERNAME`, don't touch!

### Cron File Schedule Format

Format of a cron line:

`[minute] [hour] [date_of_the_month] [month] [day_of_the_week] (user) [Shell_command]`

Example of a cron line:

**Everyday at 3:00 pm, run by user "john":**
```shell
0 15 * * * john /path/to/script
```

*An astric* **\*** *will run at all times for that setting.*

*Refer to this cheat-sheet for more about cron scheduling:* [VIP/Cheet-Sheets: Cron Schedule Format](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md)

___

# The Take

- The system used "cron" to run programs on a given schedule
- All cron tasks run as the "root" user unless stated otherwise
- A cron setting looks like a lot like:
  - `0 5 * * * /path/to/program`
  - `* * 4 * * jim /path/to/program`
  - The numbers and asterisks in these represent minutes, hours, dates, months, and weekdays (in that order)
- Many regular cron schedules are in `/etc/cron-SOMETHING`
  - `/etc/cron.hourly/`
  - `/etc/cron.daily/`
  - `/etc/cron.weekly/`
  - `/etc/cron.monthly/`
  - `/etc/cron.d/`
  - `/etc/crontab` *(file, not a directory)*
- `crontab` is the "proper" way for a user to set up a regular cron task from the terminal
- Cron files are very finicky about location, permissions, and using `'single quotes'` to `echo` contents into their files
  - Permissions requirements can be different for cron files in different locations!
  - Usually, cron files in `/etc/cron.SOMEDIR/` directories need to be `644`
- Follow cron structure carefully and don't be sloppy!

___

#### [Lesson 4: MySQL & systemctl](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-04.md)
