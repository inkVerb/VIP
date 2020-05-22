# Resources & Things That Run

## I. `ps`
- This lists running processes on the system, including user, PID (process ID number), location of the process, time, CPU load, RAM use, and more.
- The `-` hyphen matters with flags!
- Examples of output information:
  - `ps` only about itself
  - `ps u` processes run by the current user
    - `u` = list users
  - `ps -u User` processes run by a specific user
  - `ps x -u User` processes run by a specific user with extra information
    - `x` = extra details
  - `ps x -Hu User` (pr `ps x -H -u User`) same as above, but organized in a tree
    - `-H` = tree
  - `ps aux` all processes on the system with user and detailed info
    - `a u x` in any order
    - `a` = all of yourself
  - `ps -A u` everything everywhere, including users
    - `-A` = `-e` = ALL of everything everywhere
  - `ps -A ux` (pr `ps -A u x`) same as above, plus extra details  
  - `ps aux | grep firefox` limits results to `firefox` processes
    - Can be used with most other apps, it `gedit`, `vlc`, etc

Also see: [Shell 201 Lesson 9](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-09.md)
___

## II. `pgrep`
- This lists only PIDs for a process
- This is useful to get a PID so you can kill it from the terminal with `kill PID`
- Usage: `pgrep Process`
- Examples:
  - `pgrep gedit`
  - `pgrep vlc`
  - `pgrep apache2`
  - `pgrep chromium` (`chromium-browser` won't work for Chromium, FYI)
  - `pgrep chrome`

Also see: [Shell 201 Lesson 9](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-09.md)
___

## III. `df` & `du`
### `df` shows more system and "available space" information
- `df -h` lists numbers with "human-readable" numbers
- `df -k` lists numbers with "human-readable" numbers

### `du` lists directories and size
- `du` all by itself lists everything
- `du DIRECTORY` lists only the argued directory
- `du *` lists *all* present directories
- `du` output kilobytes and all subdirectories by default
- `-h` lists in "human-readble" numbers
- `-s` does *not* list subdirectories

Also see: [Shell 201 Lesson 9](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-09.md)
___

## IV. `systemctl` vs `service`
- These manage "services" on the system, such as a webserver or mysql
- Many apps can be set up to run as a service, such as a Node.js app
### `service`
- `service` is widely considered outdated as of 2018
- Syntax: `service Process Action`
- Examples: (with `apache2`, could be anything, `postfix`, `dovcecot`, etc)
    - `service apache2 start` *start the process*
    - `service apache2 restart` *restart the process (kill, don't wait)*
    - `service apache2 reload` *"gracefully" reload (wait to close)*
    - `service apache2 stop` *stops the service (somewhat harsh)*
    - `service apache2 graceful-stop` *"gracefully" stop (wait to close)*
    - `service apache2 status` *view status information and possible errors*

### `systemctl`
- `systemctl` is widely considered standard as of 2018
- Syntax: `service Action Process`
- Examples: (with `apache2`, could be anything, `postfix`, `dovcecot`, etc)
    - `systemctl start apache2` *start the process*
    - `systemctl restart apache2` *restart the process (kill, don't wait)*
    - `systemctl reload apache2` *"gracefully" reload (wait to close)*
    - `systemctl stop apache2` *stops the service (somewhat harsh)*
    - ~~`systemctl graceful-stop apache2`~~ **no such thing!**
    - `systemctl status apache2` *view status information and possible errors*

Also see: [Shell 401 Lesson 4](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-04.md)

___

## V. `dpkg`
- This manages Debian packages
- This is not commonly used in Linux tutorials or Q&A/forums because most Debian machines use Aptitude (`apt`) to manage debian packages (uses `dpkg` [and does a whole lot more](https://askubuntu.com/a/309121/880404))
- Sometimes you will see `dpkg` in tutorials or Q&A/forums
- Common flags:
  - `-i` install
  - `-r` remove (uninstall)
  - `-p` remove package *and* any settings files
  - `-l` list all installed packages
  - `-L` list the location of an installed package
  - `-c` check (view) contents of a package
  - `-s` see whether a package is installed or not
  - `-R --install` install from a directory
  - `--unpack` "unpack" (decompress) the package, but do *not* install it
  - `--licence` see the license information for a package
- Examples of use:
  - `dpkg -i some-file-prolly-downloaded-version_555.1.89+annoy_64.deb` install a package
  - `dpkg -i package.deb` same as above, but named by an awesome developer who likes to keep things simple
  - `dpkg -r package-name` uninstall the package `package-name`
  - `dpkg -p package-name` uninstall and remove settings for `package-name`
  - `dpkg -s package-name` see whether `package-name` is installed or not
  - `dpkg -l` list all installed packages

___

## VI. `logger` & `journalctl`
- Keeping and reading logs can be helpful in troubleshooting
- Flags may be combined (`-p` & `-r` might become `-rp`, but flags with options can create confusion)

### Available priorities & facilities
#### Priorities: (use either text or the number)
- `0` = `emerg` (emergency, system unusable)
- `1` = `alert` (alert, take immediate action)
- `2` = `crit` (critical)
- `3` = `err` (error)
- `4` = `warn` (warning)
- `5` = `notice` (notice, normal but significant)
- `6` = `info` (information)
- `7` = `debug` (debug, so much info that only geeks & developers are interested)

#### Facilities:
- `0` = `kern` (kernel)
- `1` = `user`
- `2` = `mail`
- `3` = `daemon`
- `4` = `auth` (authorization)
- `5` = `syslog` (messages originating from `syslogd`)
- `6` = `lpr` (line printer)
- `7` = `news` (network news subsystem)
- `8` = `uucp` (UUCP)
- `9` = `cron` (clock daemon)
- `10` = `authpriv` (security/authorization)
- `11` = `ftp`
- `12` = `ntp`
- `13` = `audit`
- `14` = `console`
- `15` = `cron2` (clock daemon)
*Below are custom (local) facilities, probably defined by the developer (you)*
- `16` = `local0`
- `17` = `local1`
- `18` = `local2`
- `19` = `local3`
- `20` = `local4`
- `21` = `local5`
- `22` = `local6`
- `23` = `local7`

### `logger` makes log entries
- Syntax: `logger FLAGS OPTIONS`
- Common flags:
  - `-t TAG` tag, input any text to use a tag
  - `-p PRIORITY` priority, sets the "facility" and "priority significance"
- Examples:
  - `logger "My log message."`
  - `logger -t sometag "My log message."`
  - `logger -p info "My log message."` = `logger -p 6 "My log message."`
  - `logger -p mail.err "My mail error message."` = `logger -p mail.3 "My mail error message."`

### `journalctl` reads logs
- Syntax: `journalctl FLAGS OPTIONS "Message for log entry"`
- Common flags & "options":
  - `-t TAG` tag, search a tag
  - `-p PRIORITY` priority, search "priority significance"
    - **Syntax:** `-p Facility.Priority` (see key below)
  - `-r` reverse order, to view most recent log entries first
  - `-f` follow most recent entries *(Ctrl + C to close)*
  - `-o OPTION` option
    - `verbose` outputs about a page per entry, rather than one line per entry
    - `short-full` less info, but includes time
    - `cat` only shows the message of the log entry
- Examples:
  - `journalctl -o verbose`
  - `journalctl -r -o verbose` = `journalctl -ro verbose`
  - `journalctl -r -p 6` = `journalctl -rp 6`
  - `journalctl -f`
  - `journalctl -t sometag`

*Learn more for read-only system logs* [https://ops.tips/gists/redirect-all-outputs-of-a-bash-script-to-a-file/]

Also see: [Shell 301 Lesson 6](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-06.md)

___

## VII. `date`
- `date` outputs time information
- Syntax: `date +Options`
- Options can be combined with other characters
- Examples:
  - `date +%Y_%m_%d_%T`
  - `date +%Y/%m/%d_%T`
  - `date +%Y/%m/%d_%H:%M:%S`
  - `date +%Y-%m-%d.%H-%M-%S`

### Common format arguments
- `+%D` MM/DD/YY
- `+%F` YYYY-MM-DD
- `+%T` HH:mm:SS
- `+%Y` YYYY
- `+%b` Mon
- `+%B` Month
- `+%m` MM
- `+%d` DD
- `+%a` Dy
- `+%A` Day
- `+%H` HH
- `+%M` mm (minute)
- `+%S` SS (seconds)

*Read more options here:* [https://www.computerhope.com/unix/udate.htm]

Also see: [Shell 301 Lesson 8](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-08.md)
___

## VIII. `pwgen`
- `pwgen` creates sets of random characters, usually useful as passwords
- Syntax: `pwgen Arguments`
- `pwgen` normal produces a large number of random character sets and needs `-1` not to
- Flags can be combined
- Examples:
  - `pwgen -1 10 -0` one set, ten characters, no numerals
  - `pwgen -1y 15` one set, at least 1 special character, fifteen characters

### Common arguments
- `-1` Only 1 character set
- `-y` Include at least 1 special character
- `-n` Include at least 1 numeral
- `-0` No numerals
- `-c` Include at least 1 capital letter
- `-A` No caps
- `-s` "Secure" hard-to-memorize set (not recommended)
- `-v` No vowels (not recommended)
- Number of characters:
  - Include the number of in the arguments as simple digits
  - `5` five characters
  - `23` twenty-three characters
  - etc

*Read more options here:* [https://linux.die.net/man/1/pwgen]

Also see: [Shell 301 Lesson 8](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-08.md)
