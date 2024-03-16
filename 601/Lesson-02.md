# Linux 601
## Lesson 2: Procesesses & Monitoring

# The Chalk
## Processes
### Definitions
- **program** - written "instruction" saved in an executable file that can be "run" in the operating system
- **process** - a program that is running in the operating system with a PID, using RAM and CPU, etc
  - A process cannot make calls to hardware, but must interact through **system calls** to talk to the kernel, which talks to the hardware
- **setuid program** - marked with an `s` bit in permissions, meaning that the **effective** user may not be the user that executes it
  - Three types of UIDs:
    - `RUID` Real user ID, user that runs the program
    - `EUID` Effective User ID, determins privileges of the process for the kernel
    - `SUID` Saved user ID, referred to if the process needs to change its UID
    - See these for `gedit` (while running) with: `ps -C gedit -o pid,ruid,euid,suid,ruser,user,euser,cmd` (a section on `ps` comes later)
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
- Creating your own setuid program owned by root can cause security problems
- Sometimes, it is vital that a non-root user run programs, merely for reasons like this

### Control
- `ulimit -a` shows the various limits placed on processes
  - Each limit is shown with a flag, such as `-c`, `-d`, `-f`, etc
- `ulimit -u 256512` sets the maximum of user processes to 256,512
- Settings are in `/etc/security/limits.conf`
- **hard limit** - set by `root` (not `sudo`)
- **soft limit** - set by users
- :# `ulimit -H -u 256512` set as a hard limit
- :$ `ulimit -S -u 256512` set as a soft limit

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
- <key>Ctrl</key> + <key>Z</key> will stop a process in the terminal if it has not completed yet
- `jobs` will list all process running that started in the terminal, both **background** and **foreground** that are stopped with <key>Ctrl</key> + <key>Z</key>
- `jobs -l` will give the same list, but also with PIDs

### Future execution
- `at` sets a job to start in the future
- `at now + 3 hours` will open an interactive terminal to enter your command to run three hours in the future
  - When finished, press <key>Ctrl</key> + <key>D</key> to end your command (adding `EOT` as the [heredoc](https://github.com/inkVerb/vip/blob/master/401/Lesson-11.md) delimiter)

### `cron`
- Play around with [crontab guru](https://crontab.guru/) to see how the schedule works
- `MM HH DD MM WD user command (args...)`
  - `[minute] [hour] [date] [month] [weekday] USER COMMAND (arguments - optional)`
  - `*` every value
  - `,` list separator
  - `-` range operator
  - `/` step operator (every `/n` values; eg. every `/2` hours)
  - `cron.d` directory for cron tasks like this
  - Learn more from the [Cron Cheat Sheet](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md) and [401 Lesson 3](https://github.com/inkVerb/vip/blob/master/401/Lesson-03.md)
- `anacron` is an alternative to `cron` that runs jobs with staggered timing
- `chrony` is the [Arch Linux package](https://wiki.archlinux.org/title/Chrony) for `cron` task functionality (not native)
- `cron.d/` files must have `0644` permissions

### Process States
- Running - normal, using CPU, executing
- Waiting/Sleeping - on hold until it finishes a task or receives data
- Stopped - suspended, probably using <key>Ctrl</key> + <key>Z</key>, able to be analyzed before resuming
- Zombie - finished, but still has a PID lingering along with a space in the "process table"

### Execution Modes
- User mode - most programs
- System/kernel mode - a program that gives the CPU full access to hardware
  - Used for things like accessing disk or running a program 

### Daemons
- Background processes that only operate when needed
- Often start at boot
- May often end with `d` in the name
  - `systemd`
  - `httpd`
  - `sshd`
  - `crond`
- Good for security

### Process Priority
- Processes have **priority** from the CPU
  - These are seen with `PRI` in `htop` and `PR` in `top`
- Priority ranges from `-20` thru `19` (high number is lower priority)
- Set priority when running a program with `nice`
  - `nice -n -10 gedit` - `gedit` will run with a semi-high priority of `-10`
- Change priority of a running process with `renice`
  - `renice 10 -p 1555` - The process with PID `1555` will change to a semi-low priority of `10`

## Monitoring Processes
- There are several tools for monitoring processes:
  - `top` processes
  - `htop` processes more human-readable
  - `free` RAM and swap use
  - `ps` detailed, customizable info on processes
  - `pstree` processes in a tree showing parents
  - `uptime` how long the system has been running, users logged on, and load
  - `mpstat` for multi-core processors
  - `numastat` NUMA (Non-Uniform Memory Architecture)
  - `sar` system activity
  - `strace` system calls made by a given process
  - The `/proc/` root folder is also useful if you know how what you are looking for

### `ps`
- Types of `ps` options
  - Unix options **must** start with `-`
  - BSD options **must not** start with `-`
  - GNU options **must** start with `--`
- Examples
  - `ps aux`
  - `ps -elLf`
    - `ps -elf` shows parent PIDs as PPIDs
  - `ps -C gedit`
    - `ps -C gedit -o pid,ruid,euid,suid,ruser,user,euser,cmd`
    - `cmd` - command
    - `pid` - PID
    - `cputime` - Total CPU time
    - `pmem` - RAM use ratio to total RAM

### `pstree`
- Visual geneology of multi-thread processes
- Examples
  - `pstree -aAp`
  - `pstree -aAp $(pgrep gedit)`
  - `pstree -aAps 1555`

### `/proc/`
- Every processes is listed in `/proc/` by PID
  - Inside `/proc/SOME_PID/task/` contains folders of child processes by PID
  - Not every process will have a folder directly in `/proc/`
- Much of the information that process monitoring tools use simply comes by reading text information from `/proc/`
- `/proc/self` links to the current running process
  - `ls -l /proc/self` shows the PID that as its symlink

### `dd`
- `dd` can be used as a dummy process to test system IDs, etc
  - `dd if=/dev/zero of=/dev/null`
  - `dd if=/dev/urandom of=/dev/null status=progress`
    - Optionally add `status=progress`
    - `/dev/zero` and `/dev/urandom` are both valid `if=` sources
  - `dd if=/dev/urandom | pv | dd of=/dev/null` (requires the `pv` 'pipe viewer' package)
- Use <key>Ctrl</key> + <key>Z</key> and `jobs -l` and `kill` to play around with this process

## Memory
- `/proc/` info locations:
  - `/proc/sys/vm/`
  - `/proc/meminfo` - RAM
  - `/proc/swaps` - Swap
- Memory tools from `procps`
  - `free` basic RAM usage
  - `vmstat` shows virtual memory use and info
  - `pmap` maps processes in memory
- Examples
  - `vmstat 1 5` (display `5` iterations every `1` second)
  - `vmstat -a 1 3` (`-a` for activity)
  - `vmstat -a -SM 1 3`
  - `vmstat -p /dev/sda1 1 3`

### OOM Killer (Out of Memory)
- Linux allows memory to "overcommit"
  - If a process requests a large block of RAM, but will likely only use a small amount, Linux allows it
  - This depends on the **badness* seen in `/proc/PID/oom_score`
- Setting: `/proc/sys/vm/overcommit_memory` (a simple digit)
  - `0` default - permit overcommittment
    - Rejects overcomits that are obviously a problem
    - `root` users get more memory than normal users
  - `1` - always overcommit
  - `2` - never overcomit
    - Ratio of RAM to swap set in: `/proc/sys/vm/overcommit_ratio` (default `50`)

___


# The Keys
*Practice commands for SysAdmins who already know what these mean*

```console
cd /usr/bin
ls -l | grep rws
find . -perm -u+s
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

ulimit -a
cat /etc/security/limits.conf
ulimit -a
su
ulimit -H -u 256512
exit
ulimit -S -u 64128

jobs -l
gedit &
fg %1
# Ctrl + Z
bg %1
kill %1

cd /etc
sudo find . -name "cron*"
find . -name "cron*"
top
htop
free
uptime
mpstat
numstat
sar
strace

ls /proc
dd if=/dev/urandom | pv | dd of=/dev/null
# Ctrl + C
dd if=/dev/zero | pv | dd of=/dev/null
# Ctrl + C
gedit &
dd if=/dev/zero of=/dev/null &
jobs
ps aux | grep gedit
ps aux | grep dd
pgrep gedit
pgrep dd
ps -elLf
ps -elf
pstree
pstree -aAp
pstree -aAp $(pgrep gedit)
pgrep dd
pstree -aAp 5555 # some PID for dd
pstree -aAp 1 # PID for init
free
pgrep dd
jobs
kill %1
jobs
kill %2
pgrep dd

vmstat
vmstat -a
vmstat 1 5
vmstat -a 1 4
vmstat -p /dev/sda1 1 3

sudo cat <<EOF > /etc/cron.d/chores
0/15 * * * 2 root /usr/bin/echo "Every Tuesday, every 15 minutes from 00 minutes"
15 12 * * * root /usr/bin/echo "Every day at 12:15 PM"
22 4 14 * * root /usr/bin/echo "The 14th of every month at 4:22 PM"
0 3 1 6,9 * root /usr/bin/echo "June 1 and September 1 at 3:00 AM"
EOF
sudo chmod 0644 /etc/cron.d/chores
```

___

#### [Lesson 3: Users & Groups](https://github.com/inkVerb/vip/blob/master/601/Lesson-03.md)