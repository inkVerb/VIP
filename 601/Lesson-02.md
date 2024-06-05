# Linux 601
## Lesson 2: Procesesses & Monitoring

# The Chalk
## Processes
### Definitions
- **builtin** - a command that does not need a specific program in `/sbin/` or `/usr/bin/`, but is "built-in" as part of the shell
  - ie: `echo`, `cd`, `kill`, `ulimit`, `exit`, `exec`, `time`, `eval`, `printf`, `jobs`, `bg`, `fg`, `getopts`, `history`, `pwd`, `type`, `read`, `return`, `export`, `shift`, `unset`, `wait`, `source`, `case`, `if`, `true`, `false`, `for`, `while`, `until`, `continue`
  - See with: `type echo`, `type cd`, `type kill`, etc
  - More on shells in ([Lesson 3: Users & Groups](https://github.com/inkVerb/vip/blob/master/601/Lesson-03.md))
  - All non-builtin commands are **programs**
- **program** - written "instruction" saved in an executable file that can be "run" in the operating system
- **process** - a program that is running in the operating system with a PID, using RAM and CPU, etc
  - A process cannot make calls to hardware, but must interact through **system calls** to talk to the kernel, which talks to the hardware
- **setuid program** - marked with an `s` bit in permissions, meaning that the **effective** user/group *is the **owner** of the file*, not the user that executes it
  - Three types of UIDs:
    - `RUID` Real User ID, user that runs the program
    - `EUID` Effective User ID, determins privileges of the process for the kernel
    - `SUID` Saved User ID, referred to if the process needs to change its UID
    - ie: see these for a text editor (while running) :$
      - `ps -C gedit` (Gnome)
      - `ps -C gedit -o cmd,pid,uid,ruid,euid,suid,user,ruser,euser,suser`
      - `ps -C mousepad` (Xfce)
      - `ps -C mousepad -o cmd,pid,uid,ruid,euid,suid,user,ruser,euser,suser`
      - A section on `ps` comes later in this lesson
  - Make a file a setuid with: `chmod u+s newprogram`
    - Then, `ls -l` will list permissions: `-rwSr--r--` or `-rwsr-xr-x` with an `s` or `S` where the `x` would normally be
    - Examples of setuid programs in `/usr/bin/`:
      - `chsh`
      - `crontab`
      - `gpasswd`
      - `mount`
      - `passwd`
      - `su`
      - `sudo`
      - `umount`
      - `unix_chkpwd`
    - Find all in `/usr/bin/` with :$ `find /usr/bin/ -perm -u+s`
- Creating your own setuid program owned by root can cause security problems
- Sometimes, it is vital that a non-root user run programs, merely for reasons like this

### Process Creation
- The first user process is `init` with PID `1`
- Linux systems constantly create new processes by **forking** existing processes, sometimes called **fork and exec**
- When a process is orphaned, it is adopted by `init`

### Command Shell Terminal
- A terminal is a simulator that interprets commands sent to the system
- Commands in the terminal become processes
- While a terminal-created process is working, the terminal command prompt is inaccessible
- After a terminal process dies with `exit` in its program, the terminal restarts and displays a prompt for the next command
- A command can be run in the background by adding `&` to the end of a command, then the process does not depend on the terminal
  - This runs the process in the **background**
  - Without `&` at the end of the command, the terminal process runs in the **foreground**
- <kbd>Ctrl</kbd> + <kbd>Z</kbd> will stop a process in the terminal if it has not completed yet
- `jobs` will list all process running that started in the terminal, both **background** and **foreground** that are stopped with <kbd>Ctrl</kbd> + <kbd>Z</kbd>
- `jobs -l` will give the same list, but also with PIDs

### `ps` Process Snapshot (PS)
- Types of `ps` options
  - Unix options **must** start with `-`
  - BSD options **must not** start with `-`
  - GNU options **must** start with `--`
- `pgrep` finds the PID for a process, shortening the work of `ps | grep [some-command]`
- Examples :$
  - `ps aux`
    - `ps aux | grep gedit` (GNOME)
    - `pgrep gedit` (GNOME)
    - `ps aux | grep gedit` (Xfce)
    - `pgrep gedit` (Xfce)
  - `ps -elLf`
    - `ps -elf` shows parent PIDs as PPIDs
  - `ps -C gedit`
    - `ps -C gedit -o cmd,pid,cputime,pmem`
    - `-C gedit` isolates the command `gedit` to retrieve information for
    - `cmd` - command
    - `pid` - PID
    - `cputime` - Total CPU time
    - `pmem` - RAM use ratio to total RAM

### `pstree` PS Tree
- Visual geneology of multi-thread processes
- Examples :$
  - `pstree -aAp`
  - `pstree -aAp 1` - PID for `init`
  - `pstree -aAp $(pgrep gedit)` (GNOME)
  - `pstree -aAp $(pgrep mousepad)` (Xfce)
  - `pstree -aAps 1555`
- A desktop GUI often outputs much more than a web server with `pstree`

### `/proc/`
- Every processes is listed in `/proc/` by PID
  - Inside `/proc/SOME_PID/task/` contains folders of child processes by PID
  - Not every process will have a folder directly in `/proc/`
- Much of the information that process monitoring tools use simply comes by reading text information from `/proc/`
- `/proc/self` links to the current running process
  - `ls -l /proc/self` shows the PID that as its symlink

#### Test with `dd`
- `dd` can be used as a dummy process to test system IDs, etc :$
  - `dd if=/dev/zero of=/dev/null`
  - `dd if=/dev/urandom of=/dev/null status=progress`
    - Optionally add `status=progress`
    - `/dev/zero` and `/dev/urandom` are both valid `if=` sources
  - `dd if=/dev/urandom | pv | dd of=/dev/null` (requires the `pv` 'pipe viewer' package)
- Use <kbd>Ctrl</kbd> + <kbd>Z</kbd> and `jobs -l` and `kill` to play around with this process
- Start a `dd` test for `ps` examination :$
  - `dd if=/dev/zero of=/dev/null &`
  - `ps aux | grep dd`
  - `ps -C dd -o cmd,pid,cputime,pmem,uid,ruid,euid,suid,user,ruser,euser,suser`

### Process Limit Control
- Process limit tettings are in `/etc/security/limits.conf`
  - This file contains documentation and is the "proper" way to limit the number of processes
- `ulimit` is a shell built-in that can change the number of processes *for the current shell*
  - `ulimit` only works for the shell in which it is executed
  - `ulimit -a` shows the various limits placed on processes
    - Each limit is shown with a flag, such as `-c`, `-d`, `-f`, etc
  - `ulimit -u 256512` sets the maximum of user processes to 256,512
  - **hard limit** - set by `root` (not `sudo`)
  - **soft limit** - set by users
  - :# `ulimit -H -u 256512` set as a hard limit
  - :$ `ulimit -S -u 256512` set as a soft limit

| **`/etc/security/limits.conf`** : (`nproc` - max number of processes)

```
#<domain>      <type>  <item>         <value>
#

#*               soft    core            0
#*               hard    rss             10000
#@student        hard    nproc           20
#@faculty        soft    nproc           20
#@faculty        hard    nproc           50
#ftp             hard    nproc           0
#@student        -       maxlogins       4
userjohn         hard    nproc           5125
userjohn         soft    nproc           4012
```

### Process States
- Managed with `jobs`
- Running - normal, using CPU, executing
- Waiting/Sleeping - on hold until it finishes a task or receives data
- Stopped - suspended, probably using <kbd>Ctrl</kbd> + <kbd>Z</kbd>, able to be analyzed before resuming
- Zombie - finished, but still has a PID lingering along with a space in the "process table"

### Execution Modes
- User mode - most programs
- System/kernel mode - a program that gives the CPU full access to hardware
  - Used for things like accessing disk or running a program 

### Daemons
- Background processes that only operate when needed
- Often start at boot
- Good for security
- May often end with `d` in the name
  - `systemd`
  - `httpd`
  - `sshd`
  - `crond`

### Process Priority & `nice`
- Processes have **priority** from the CPU
- `nice` can set this priority at execution
- Lower number = higher priority
  - Priority ranges from `-20` thru `19` (high number is lower priority)
  - (Sometimes priority is `0`-`39` and `nice` value is `-20`-`19`)
- See priority and `nice` values:
  - `htop`:
    - `PRI` - priority
    - `NI` - `nice` value
  - `top`:
    - `PR` - priority
    - `NI` - `nice` value
    - `-n 1` = only one iteration
  - Priority: `PRI` in `htop` and `PR` in `top`
- Set priority when running a program with `nice`
  - `nice -n -10 gedit`
  - `nice --10 gedit` (same)
    - `gedit` will run with a semi-high `nice` priority of `-10`
    - `-n` can be replaced with a dash `-` and no space
    - `nice -n 9 gedit` (priority of `9`)
    - `nice -9 gedit` (same)
- Change priority of a running process with `renice`
  - `renice -n 10 -p 1555`
  - `renice 10 1555` (same)
    - The process with PID `1555` will change to a semi-low priority of `10`
    - `-n` is optional, but the priority after and may be relative or absolute depending on environment variable `POSIXLY_CORRECT`
    - `-p` is optional, but the PID after is necessary even without it

## Memory
- `/proc/` info locations:
  - `/proc/meminfo` - RAM
  - `/proc/swaps` - Swap
  - `/proc/sys/vm/` - Virtual RAM
  - `/proc/sys/vm/overcommit_memory` - Overcomit setting (default `0`, see OOM below)

### Memory tools from `procps` package
- `free` basic RAM and swap use
- `pmap` maps processes in memory
  - `pmap -x [PID]`
- `vmstat` shows virtual memory use and info
  - `vmstat 1 5` (display `5` iterations every `1` second)
  - `vmstat -a 1 3` (`-a` for activity)
  - `vmstat -a -SM 1 3`
  - `vmstat -p /dev/sda1 1 3`

### Other Processes Monitoring Tools
- There are several tools for monitoring processes: (some are redundant)
  - `top` processes
  - `htop` processes more human-readable
  - `free` basic RAM and swap use
  - `ps` detailed, customizable info on processes
  - `pstree` processes in a tree showing parents
  - `uptime` how long the system has been running, users logged on, and load
  - `mpstat` for multi-core processors
  - `numastat` NUMA (Non-Uniform Memory Architecture)
  - `sar` system activity
  - `strace` system calls made by a given process
  - The `/proc/` root folder is also useful if you know how what you are looking for

### OOM Killer (Out of Memory)
- Linux allows memory to "overcommit"
  - If a process requests a large block of RAM, but will likely only use a small amount, Linux allows it
  - This depends on the *badness* seen in `/proc/PID/oom_score`
- Setting: `/proc/sys/vm/overcommit_memory` (a simple digit)
  - `0` - default - permit overcommittment
    - Rejects overcomits that are obviously a problem
    - `root` users get more memory than normal users
  - `1` - always overcommit
  - `2` - never overcomit
- Ratio of RAM to swap set in: `/proc/sys/vm/overcommit_ratio` (default `50`)

## Task Scheduling
### `at` Future Execution
- `at` sets a job to start in the future
- Requirements:
  - Install the `at` package
  - `atd` service must be running :#
    - `systemctl start atd`
- Interactive :$ (opens interactive terminal for set or relative time in future)
  - `at 22:00`
  - `at now + 3 hours`
  - `at now + 1 minute`
  - `at now + 1 day`
  - `at now + 1 week`
  - `at now + 1 month`
  - `at now + 1 year`
  - When finished, press <kbd>Ctrl</kbd> + <kbd>D</kbd> to end your command (showing `<EOT>` as the [heredoc](https://github.com/inkVerb/vip/blob/master/401/Lesson-11.md) delimiter)
- Plain command examples :$
  - `at 22:00 -f /path/to/command/or/script`
  - `echo "echo 'hello world'" | at 22:00`
  - `echo "cat fish" | at 23:00`
  - `echo "uptime" | at 01:24`

### `cron`
- Schedule tasks
- Play around with [crontab guru](https://crontab.guru/) to see how the schedule works
- `MM HH DD MM WD user command (args...)`
  - `[minute] [hour] [date] [month] [weekday] [user] [command] (arguments - optional)`
  - `*` every value
  - `,` list separator
  - `-` range operator
  - `/` step operator (every `/n` values; eg. every `/2` hours)
  - `cron.d` directory for cron tasks like this
  - Learn more from the [Cron Cheat Sheet](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md) and [401 Lesson 3](https://github.com/inkVerb/vip/blob/master/401/Lesson-03.md)
- `anacron` is an alternative to `cron` that runs jobs with staggered timing
- `chrony` is the [Arch Linux package](https://wiki.archlinux.org/title/Chrony) for `cron` task functionality (not native)
- `cron.d/` files must have `0644` permissions

___


# The Keys
*Practice commands for SysAdmins who already know what these mean*

```console
find /usr/bin -perm -u+s
cd /usr/bin
ls -l | grep rws

find . -perm -u+x
find . -perm -u+s
find . -perm -u+x | wc -l
find . -perm -u+s | wc -l

ls -l chsh
ls -l crontab
ls -l gpasswd
ls -l mount
ls -l passwd
ls -l su
ls -l sudo
ls -l mount
ls -l umount
ls -l unix_chipwd

# Choose gedit for GNOME or mousepad for Xfce
gedit &&
ps -C gedit
ps -C gedit -o cmd,pid,uid,ruid,euid,suid,user,ruser,euser,suser
ps -C gedit -o cmd,pid,cputime,pmem
pgrep gedit
pstree -aAp $(pgrep gedit)
killall gedit

mousepad &&
ps -C mousepad
ps -C mousepad -o cmd,pid,uid,ruid,euid,suid,user,ruser,euser,suser
ps -C mousepad -o cmd,pid,cputime,pmem
pgrep mousepad
pstree -aAp $(pgrep mousepad)
killall mousepad

pstree -aAp

ls /proc
cd /proc
ls -l
dd if=/dev/urandom | pv | dd of=/dev/null
# Ctrl + C
dd if=/dev/zero | pv | dd of=/dev/null
# Ctrl + C
gedit &     # Choose one
mousepad &  # Choose one
dd if=/dev/zero of=/dev/null &
jobs -l
ps -C dd
ps -C dd -o cmd,pid,cputime,pmem,uid,ruid,euid,suid,user,ruser,euser,suser
ps aux | grep gedit     # Choose one
ps aux | grep mousepad  # Choose one
ps aux | grep dd
pgrep dd
ps -elLf
ps -elf
pstree
pstree -aAp
pstree -aAp 1 # PID for init
pgrep dd
pstree -aAp 5555 # some PID for dd
free
pgrep dd
jobs
kill %1
free
jobs
kill %2
free
pgrep dd

ulimit -a
cat /etc/security/limits.conf
ulimit -a
su
ulimit -H -u 256512
exit
ulimit -S -u 64128

jobs -l
gedit &     # Choose one
mousepad &  # Choose one
jobs -l
fg %1
# Ctrl + Z
bg %1
jobs -l
kill %1
jobs -l

cd /proc
ls
cd sys/vm
ls
cat overcommit_memory
cat overcommit_ratio

free
pmap -x 5555
vmstat
vmstat -a
vmstat 1 5
vmstat -a 1 4
vmstat -p /dev/sda1 1 3

top
top -n 1
htop
uptime
mpstat
numstat
sar
strace

echo "echo 'hello world'" | at 23:00
at 14:09 -f somescript
# End each with Ctrl + D
at now + 3 hours
at now + 1 week
at 22:56

cd /etc
sudo find . -name "cron*"
find . -name "cron*"

su

cat <<EOF > /etc/cron.d/chores
0/15 * * * 2 root /usr/bin/echo "Every Tuesday, every 15 minutes from 00 minutes"
15 12 * * * root /usr/bin/echo "Every day at 12:15 PM"
22 4 14 * * root /usr/bin/echo "The 14th of every month at 4:22 AM"
0 3 1 6,9 * root /usr/bin/echo "June 1 and September 1 at 3:00 AM"
EOF

exit

sudo chmod 0644 /etc/cron.d/chores

sudo rm /etc/cron.d/chores
```

___

#### [Lesson 3: Users & Groups](https://github.com/inkVerb/vip/blob/master/601/Lesson-03.md)