# Shell 401
## Lesson 3: Cron Daemon

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

Cron tasks are processes (usually in a Shell script) that are automatically run by the system on a regular basis.

`cd /etc`

`ls` *(Scroll up to find the cron directories.*

#### Regular scheduled jobs

`cd cron.daily/`

`ls -l`

The system will automatically run cron scripts on its own scheduled basis in three cron directories:
- Daily: `/etc/cron.daily/`
- Weekly: `/etc/cron.weekly/`
- Monthly: `/etc/cron.monthly/`

**Instructions:**
1. Each file here is a simple BASH or Shell script.
2. File Permissions: `rwxr-xr-x` set with: `chmod 755 CRON_FILE_NAME`

#### Custom scheduled jobs

`cd cron.d/`

`ls -l`

To have more control of the time a cron task will run, put generic cron files here:
- Cron directory: `/etc/cron.d/`

**Instructions:**
1. Each cron file has one to-be-run Shell script *per line* with cron schedule settings (below).
2. File Permissions: `rw-r--r--` set with: `chmod 644 CRON_FILE_NAME`
3. If creating the file by using `echo` use single 'quotes' since double "quotes" will change the meaning of some characters, though you may never see the difference in the text file.
4. The Shell script listed at the end of the line *must be executable*, probably using: `chmod ug+x SCRIPT_FILE`

*(Many developers don't like it when system admins put files here.)*

#### `crontab`

The favorite way for a system admin to set up a custom cron task is using the `crontab` command.

This will edit the file `/etc/crontab`, which is managed by the system.

**Instructions:**
1. The crontab file has one to-be-run Shell script *per line* with cron schedule settings (below).
2. The Shell script listed at the end of the line *must be executable*, probably using: `chmod ug+x SCRIPT_FILE`

*The first time you run* `crontab` *you will be asked to choose an editor, that's normal.*

#### Cron schedule format

Format of a cron line:

`[minute] [hour] [date_of_the_month] [month] [day_of_the_week] [Shell_command]`

*An astric* **\*** *will run at all times for that setting.*

Examples of a cron line:

**Everyday at 3:00 pm:**
```shell
0 15 * * * /path/to/script
```

**Everyday Monday at 9:37 am:**
```shell
37 9 * * mon /path/to/script
```

**21st of every month at 6 pm:**
```shell
0 18 21 * * /path/to/script
```

**Every hour at 15 minuts & 45 minutes past the hour:** *Yes, you can do multiple.*
```shell
15,45 * * * * /path/to/script
```

**Everyday at 1 am & 1 pm:** *Yes, you can do multiple.*
```shell
0 1,13 * * * /path/to/script
```

**Everyday minute of every day:**
```shell
* * * * * /path/to/script
```

**Everyday 15 minutes:**
```shell
*/15 * * * * /path/to/script
```

**Everyday 6 hours:**
```shell
0 */6 * * * /path/to/script
```

**Everyday January, May, and August on the first day at midnight:** *Yes, you can do multiple months.*
```shell
0 0 1 jan,may,aug * /path/to/script
```

**Everyday March on every minute of every day:** *Yes, you can do multiple months.*
```shell
* * * mar * /path/to/script
```

**Three tasks, every Friday at 7 am:** *Yes, you can do multiple scripts.*
```shell
0 7 * * fri /path/to/script1; /path/to/script2; /path/to/script3
```

**Monthly:** `@monthly` *isn't alone!*
```shell
@monthly /path/to/script
```

**Wildcard stamps:**
- `@yearly` = `0 0 1 1 *`
- `@monthly` = `0 0 1 * *`
- `@weekly` = `0 0 * * mon`
- `@daily` = `0 0 * * *`
- `@hourly` = `0 * * * *`
- `@reboot` = at every system startup

#### [Lesson 4: MySQL & systemctl](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-04.md)
