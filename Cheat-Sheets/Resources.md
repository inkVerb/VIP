# Resources & Things That Run

## I. `ps`
- This lists running processes on the system, including user, PID (process ID number), location of the process, time, CPU load, RAM use, and more.
- The `-` hyphen matters with flags!
- Examples of output information:
  - `ps` only about itself
  - `ps u` processes run by the current user
    - `u` = list users
  - `ps -u USER` processes run by a specific user
  - `ps x -u USER` processes run by a specific user with extra information
    - `x` = extra details
  - `ps x -Hu USER` (pr `ps x -H -u USER`) same as above, but organized in a tree
    - `-H` = tree
  - `ps aux` all processes on the system with user and detailed info
    - `a u x` in any order
    - `a` = all of yourself
  - `ps -A u` everything everywhere, including users
    - `-A` = `-e` = ALL of everything everywhere
  - `ps -A ux` (pr `ps -A u x`) same as above, plus extra details  
  - `ps aux | grep firefox` limits results to `firefox` processes
    - Can be used with most other apps, it `gedit`, `vlc`, etc
## II. `pgrep`
- This lists only PIDs for a process
- Usage: `pgrep PROCESS`
- Examples:
  - `pgrep gedit`
  - `pgrep vlc`
  - `pgrep apache2`
  - `pgrep chromium` (`chromium-browser` won't work for Chromium, FYI)
  - `pgrep chrome`

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

## IV. `systemctl` vs `service`
- These manage "services" on the system, such as a webserver or mysql
- Many apps can be set up to run as a service, such as a Node.js app
### `service`
- `service` is widely considered outdated as of 2018
- Syntax: `service PROCESS ACTION`
- Examples: (with `apache2`, could be anything, `postfix`, `dovcecot`, etc)
    - `service apache2 start` *start the process*
    - `service apache2 restart` *restart the process (kill, don't wait)*
    - `service apache2 reload` *"gracefully" reload (wait to close)*
    - `service apache2 stop` *stops the service (somewhat harsh)*
    - `service apache2 graceful-stop` *"gracefully" stop (wait to close)*
    - `service apache2 status` *view status information and possible errors*

### `systemctl`
- `systemctl` is widely considered standard as of 2018
- Syntax: `service ACTION PROCESS`
- Examples: (with `apache2`, could be anything, `postfix`, `dovcecot`, etc)
    - `systemctl start apache2` *start the process*
    - `systemctl restart apache2` *restart the process (kill, don't wait)*
    - `systemctl reload apache2` *"gracefully" reload (wait to close)*
    - `systemctl stop apache2` *stops the service (somewhat harsh)*
    - ~~`systemctl graceful-stop apache2`~~ **no such thing!**
    - `systemctl status apache2` *view status information and possible errors*

## V. `dpkg`
- This manages Debian packages
- This is not commonly used in Linux tutorials or Q&A/forums because most Debian machines use Aptitude (`apt`) to manage packages
- Sometimes you will see `dpkg` in tutorials or Q&A/forums
- Examples of real use:
  - `dpkg -i some-file-prolly-dl-v_555.1.89+annoy_64.deb` install a package
  - `dpkg -i package.deb` same as above, but named by an awesome developer who likes to things simple
