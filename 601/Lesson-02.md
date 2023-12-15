# Linux 601
## Lesson 2: Procesesses & Monitoring

Ready the CLI

```console
cd ~/School/VIP/601
```

___

### I. Section 1

| **1** :$

```console
command 1
```


___

# The Take
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
- **hard limit** - set by `root`
- **soft limit** - set by users
- `ulimit -H -u 256512` set as a hard limit
- `ulimit -S -u 256512` set as a soft limit
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
- [minute] [hour] [day of month] [month] [day of week]
  - `*` every value
  - `,` list separator
  - `-` range operator
  - `/` step operator (every `/n` values; eg. every `/2` hours)
  - `cron.d` directory for cron tasks like this
  - Learn more from the [Cron Cheat Sheet](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Cron.md) and [401 Lesson 3](https://github.com/inkVerb/vip/blob/master/401/Lesson-03.md)
  - `anacron` is an alternative to `cron` that runs jobs with staggered timing
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
  - UNIX options **must** start with `-`
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
- `dd` is a copy process that copies direct data
- It skips some of the file system interaction
- It can be used to create a large empty file, such as for a swap file
- It reads `/dev/urandom` and writes to `/dev/null` unless told to write somewhere else, like a swap file
- Swap creation example: `dd if=/dev/zero of=/var/swap.img bs=2M count=1024` (2 GB empty swap file)
  - `if` input file
  - `of` output file
  - `bs` block size
  - `count` number of blocks
- This can be used as a dummy process to test system IDs, etc
- Use <key>Ctrl</key> + <key>Z</key> and `jobs -l` and `kill` to play around with this process
## Memory
- `/proc/` info locations:
  - `/proc/sys/vm/`
  - `/proc/meminfo`
- Memory tools from `procps`
  - `free` basic RAM usage
  - `vmstat` shows virtual memory use and info
  - `pmap` maps processes in memory
- Examples
  - `vmstat 1 5` (display `5` iterations every `1` second)
  - `vmstat -a 1 3`
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
## Swap
- Info: `/proc/swaps`
- Tools:
  - `mkswap`
  - `swapon`
  - `swapoff`
    - Argue either the swap file/partition or use `-a` for all
- `mkswap` formats both swap partitions and files
  - Those files or partitions should exist first
  - Below is an example of creating a swap file; partitions are addressed in another lesson
- Example: (1G swap file)
```bash
swapoff /var/swap.img
touch /var/swap.img
chmod 600 /var/swap.img
dd if=/dev/zero of=/var/swap.img bs=1M count=1024
mkswap /var/swap.img
swapon /var/swap.img
```

___

#### [Lesson 3: Disk & Partitioning](https://github.com/inkVerb/vip/blob/master/601/Lesson-03.md)