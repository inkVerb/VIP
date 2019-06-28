# Cron Schedule Format

Learn more about using cron tasks in: **[Shell 401 Lesson 3: Cron Daemon](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-03.md)**

Format of a cron line:

`[minute] [hour] [date_of_the_month] [month] [day_of_the_week] (user) [Shell_command]`

*An astric* **\*** *will run at all times for that setting.*

Examples of a cron line:

**Everyday at 3:00 pm by user "jim":**
```shell
0 15 * * * jim /path/to/script
```

*All the cron tasks below will run as user "root" because a user is not specified...*

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
