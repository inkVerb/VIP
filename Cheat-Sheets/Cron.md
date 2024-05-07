# Cron Schedule Tasks

Learn more about using `cron` tasks in: **[Linux 401 Lesson 3: Cron Daemon](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-03.md)**

## I. Proper `cron` task line formatting

`[minute] [hour] [date_of_the_month] [month] [day_of_the_week] (user) [Shell_command]`

*An astric* **\*** *will run at all times for that setting.*

Examples of a `cron` line:

**Everyday at 3:00 pm by user "jim":**
```shell
0 15 * * * jim /path/to/script
```

*All the `cron` tasks below will run as user "root" because a user is not specified...*

**Everyday Monday at 9:37 am:**
```shell
37 9 * * mon root /path/to/script
```

**21st of every month at 6 pm:**
```shell
0 18 21 * * root /path/to/script
```

**Every hour at 15 minuts & 45 minutes past the hour:** *Yes, you can do multiple.*
```shell
15,45 * * * * root /path/to/script
```

**Everyday at 1 am & 1 pm:** *Yes, you can do multiple.*
```shell
0 1,13 * * * root /path/to/script
```

**Everyday minute of every day:**
```shell
* * * * * root /path/to/script
```

**Everyday 15 minutes:**
```shell
*/15 * * * * root /path/to/script
```

**Everyday 6 hours:**
```shell
0 */6 * * * root /path/to/script
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

## II. Ways to run `cron` tasks

### 1. Normal schedules
Put an **executable script** in one of these directories:

- Hourly: `/etc/cron.hourly/`
- Daily: `/etc/cron.daily/`
- Weekly: `/etc/cron.weekly/`
- Monthly: `/etc/cron.monthly/`

**Instructions:**
1. Each file here is a simple BASH or Shell script
2. File Permissions: `rwxr-xr-x` set with: `chmod 755 Cron_Script_Name`

### 2. Custom schedules
Put a **`cron` task file** in this directory:

- Cron directory: `/etc/cron.d/`

**Instructions:**
1. Each `cron` file has one to-be-run Shell script *per line* with `cron` schedule settings (here: [VIP/Cheat-Sheets: Cron Schedule Tasks](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md))
2. File Permissions: `rw-r--r--` set with: `chmod 644 Cron_Task_File`
3. If creating the file by using `echo` use single 'quotes' since double "quotes" will change the meaning of some characters, though you may never see the difference in the text file
4. The Shell script listed at the end of the line *must be executable*, probably `rwxr-xr-x` set with: `chmod 755 Script_Name`

### 3. Per-user `cron` task profiles via `crontab`

Every user gets a `crontab` file

**Before you start:**
1. The `crontab` profile has one to-be-run Shell script *per line* with `cron` schedule line formatting (here: [VIP/Cheat-Sheets: Cron Schedule Tasks](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md))
2. The Shell script listed at the end of the line *must be executable*, probably using: `chmod ug+x Script_Name`
3. The first time you run `crontab` you will be asked to choose an editor, that's normal
4. `crontab` records are usually kept here: `/var/spool/cron/crontabs/Username`, don't touch!
5. This is how most self-important instructors will tell everyone in the known multiverse to run `cron` tasks
  - You don't have to use your `crontab` profile, but if you ask for help with other `cron` methods, expect "ONLY use `crontab` you delinquent!" to be a common answer

**Instructions:**
1. Edit and make entries in your `crontab` profile with:
  - `crontab -e`
2. Use proper `cron` task line formatting (here: [VIP/Cheat-Sheets: Cron Schedule Tasks](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md))

### 4. PHP script as `cron` task

Here is an example of a `cron` task running a .php script every 15 minutes in your web folder on a server:

```shell
15 0 * * * root /usr/bin/php /var/www/html/path/to/file.php
```

**Important note:**
- We use `/usr/bin/php` so a PHP script can work
- This presumes the `php` command is in `/usr/bin/php`; use `which php` to confirm
- Use absolute paths for any `include` or `require` statements in PHP
- Test your PHP script to make sure it will work from the system
  - `php /same/path/as/cron/task/to/script.php`
  - A .php file may work fine in a web browser, but run from the system/terminal/`cron` is different

## III. Troubleshooting

### `cron` is a system-level process, so it is unforgiving
Problems with cron tasks are normal when developing, here are some things to check

### 1. Permissions
1. Scripts must be executable, usually:
  - `rwxr-xr-x` set with: `chmod 755 Script_Name`
  - `rwxrwxr-x` set with: `chmod 775 Script_Name` (less secure, may be needed for groups)
2. `cron` task schedules
  - `rw-r--r--` set with: `chmod 644 Cron_Task_Name`
3. Which files go where - *[II. Ways to Run cron Tasks](#ii-ways-to-run-cron-tasks)*
  - Actual scripts go in directories like: `/etc/cron.hourly/`, `/etc/cron.weekly/`, etc (`755`)
  - `cron` task files go in `cron.d` (`644`)

### 2. `$PATH`
**Remember: a `cron` task automatically restricts the `$PATH` to: `/bin:/usr/bin`**
- If your tasks executes a command outside of that, add a `PATH=...` variable in your script

**For example, this `PATH=` statement pretty much covers it, remove what you don't need**
```shell
`PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin`
14 23 * * * /path/to/script
```

### 3. Characters matter!
1. End with an empty line
  - Each `cron` line must have another line after it (so the cursor can sit below the line somehow)
  - A `cron` schedule line **cannot** be they very, very, final, ultimate last line of the file, either another schedule line after it, or at least an empty line at the end of the file
2. `echo` with `'single quotes'`
  - If creating the `cron` task via `echo`, use `'single quotes'`
  - Examples of how to create a `cron.d` task via echo:

**Do this:**
```shell
echo '*/3 * * * * /my/script/to/run/every/three/minutes
' > /etc/cron.d/threemincron
```
...This is **good** because:
1. It uses 'single quotes' (so `*` won't be a working character)
2. There is a line after the schedule line

**Do NOT do this:**
```shell
echo "*/3 * * * * /my/script/to/run/every/three/minutes" > /etc/cron.d/threemincron
```
...This is **bad** because:
1. It uses "double quotes" (so `*` will become a "working character" and you'll never know it)
2. There is NO line after the schedule line

### 4. Use `journalctl -f` to troubleshoot your `cron` task
Log entries are your friend!

If you have trouble and still can't figure out what in the world is going on, here's an easy way to troubleshoot:

1. Run your `cron` task to run every minute with this schedule: `*/1 * * * *`
**For example:**
```shell
*/1 * * * * root /path/to/my/troubled/script
```

2. Open a separate terminal and run: `journalctl -f`
3. Watch the terminal where you ran `journalctl -f` for log entries
  - Just past the `00` second mark of each minute is when you will probably see the entry
  - Success (white): `...CRON[123456]: (user) CMD (/path/to/my/troubled/script)`
  - Trouble (red): `cron[123456]: Error: error message; while reading /etc/cron.d/troubledtask`
  - Search the Internet for "cron Error: error message" (whatever you get instead of 'error message')

### 5. Year option
- There is a sixth *year* option (without it, just leave it blank)
- Four digit year `1970` - `2099`

**midnight January 1, 2030:**
```shell
0 0 1 1 * 2030 root /path/to/one/year/script
```

### 6. Consider this article on Stack Exchange: Server Fault
[How to fix all of your crontab related woes/problems (Linux)](https://serverfault.com/a/449652/487033)
