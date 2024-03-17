# Linux 601
## Lesson 1: Boot & System Init

# The Chalk
## Useful Commands
### Command Info
- `which` command location
- `whereis` command & man-file locations
- `whatis Command_Name` command descriptions (found across system)
- `type Command_Name` command role or purpose
- `whoami` current user
- `pwd` Present Working Directory (PWD)
- `ls | wc -l` number of files in PWD
- `seq 10` print numbers 1-10, one per line (useful for loops)
- `find /etc -type d -iname "*.d"`
- `find . -perm -u+s` (for `s` permissions on **setuid** programs, see [Lesson 2: Procesesses & Monitoring](https://github.com/inkVerb/vip/blob/master/601/Lesson-02.md))

### Machine Information
- `hostname` (machine name)
  - `hostname -i` IP address
- `free` RAM info
- `lsb_release -d` Architecture/ditstro
- `lsmod` enabled modules
- `lscpu` CPU info
- `lsmem` RAM info
- `lsblk` disks
- `lsusb` USB devices
- `lspci` PCI devices
- `sudo dmidecode` system BIOS version
  - `sudo dmidecode -t bios`
  - `sudo dmidecode -t memory`
  - `sudo dmidecode -t system`
  - `sudo dmidecode -t` (for full list of Types)

## Boot Process
1. **BIOS** - Basic Input/Output System
  - Motherboard
  - Executes GPT/MBR
2. **GPT** - GUID Partition Table / (formerly MBR - Master Boot Record)
  - Partitions ([Lesson 7: Disk & Partitioning](https://github.com/inkVerb/vip/blob/master/601/Lesson-07.md))
  - Executes GRUB
3. **GRUB** - Grand Unified Bootloader
  - Menu at boot up
  - Executes **kernel command** (seen at `/proc/cmdline` after boot)
4. **Kernel** - The actual Operating System
  - Executes `/sbin/init`
5. **Init** - Init (via `systemd`)
  - Executes targets (formerly runlevels)
6. **Targets** - Stages of finishing the machine for normal use
  - Executes tools in `/usr/lib/systemd/` by configs in `/lib/systemd/system/`

## GRUB
- The first menu normally seen on bootup, usually with name and logo of your Linux distro
  - If there is only one option, there may be no menu (standard on virtual machines and servers)
- Can boot to either Linux or Windows with various options for each system
- Updating/repairing GRUB is discussed in [Lesson 5: Kernel & Devices](https://github.com/inkVerb/vip/blob/master/601/Lesson-05.md)

### How GRUB works
- Each menu item represents a **kernel command**
  - Also includes kernel commands for booting Windows
- Examine the kernel command for each GRUB menu item:
  1. Highlight an item on the GRUB menu
  2. Press <key>E</key> for "edit"
  - This will show you the kernel config for that menu item, including the **kernel command** (seen at `/proc/cmdline` after boot)
    - Many of these may involve `if` statements, but they all prepare and run the **kernel command**
  - The **kernel command** is descussed at length in [Lesson 5: Kernel & Devices](https://github.com/inkVerb/vip/blob/master/601/Lesson-05.md)
- GRUB is simple, and this is about all that it does: select a **kernel command**
- GRUB has an option for an interactive GRUB prompt with even more options, beyond the scope of this course

## `init`
- `init` (`/sbin/init`) is the first and last program running
  - Coordinates with end of boot process
    - Executed by the kernel *after GRUB runs the **kernel command** (seen at `/proc/cmdline` after boot)*
  - Configures environment
  - Starts processes for login
  - Cooperates with kernel to clean up after terminated processes
  - Is a low level program that needs to be implemented with another system manager
- *The system moves from boot using `init` to a state where a **user** can enter commands*
  - This is why many CLI commands are in `/usr/bin/`

### History of `init` Implementations
- SysVinit in Unix was the original implementation of `init` 
  - Multi-uer mainframe (not personal machines)
  - Single core processor (one thing at a time)
  - Boot and shutdown time didn't matter
  - Booting had **run levels** that moved in clear sequence (nothing simultaneous)
- Upstart was an alternative to SysVinit
  - Developed by Ubuntu in 2006
  - Adopted by Fedora 9 and RHEL 6 in 2008
  - On some embedded and mobile machines
- `systemd` replaced Upstart
  - Fedora in 2011
  - Then RHEL and SUSE
  - Ubunty 16.04
  - Still contains wappers for SysVinit utilities for backwared compatability
  - An exciting human side of its development and Linux-wide implementation
  - All main Linux distros today

### `systemd`
- Advantages over SysVinit and Upstart
  - Boots faster
  - Agressive parallel capability
  - Sockets and D-Bus for devices
  - Actual programs replace shell scripts
  - Tracks processes via cgroups
  - Mount and automount points
  - An elaborate transactional dependency-based service control logic
  - Detailed start/stop function, similar to `cron`
- Uses `.service` files
- Handles user processes without `root` privileges

#### SysVinit Run Levels vs `systemd` Targets
- SysVinit used **run levels**; each run level had to finish before the next was allowed to begin
  - This was because the first processors had only one core and boot rarely happened, so boot speed was obsolete
  - Run levels used shell scripts to run each program
- `systemd` replaced this with **targets**, which can run with some parallel concurrency
  - This is allowed because of multicore processors and our need for speed
  - An actual program runs the 

| SysVinit     | Sys V Name                                                    | systemd target      |
|:-------------|:--------------------------------------------------------------|:--------------------|
| Run level 0  | Halt                                                          | `shutdown.target`   |
| Run level 1  | Singer-user text mode                                         | `rescue.target`     |
| Run level 2  | Not used (user-definable)                                     | ∅                  |
| Run level 3  | Multiuser text mode<br> (networking included)                 | `multi-user.target` |
| Run level 4  | Not used (user-definable)                                     | ∅                  |
| Run level 5  | Multiuser graphical mode<br> (with X-window GUI login screen) | `graphical.target`  |
| Run level 6  | Reboot                                                        | `reboot.target`     |
| Emergency    | ∅                                                            | `emergency.target`  |

#### `systemd` Config Files
- Tools
  - `/lib/systemd/` is a common symlink to `/usr/lib/systemd/`
- User unit configs
  - `/etc/systemd/user/`
  - `~/.config/systemd/user/`

#### System Unit Config `.service` Files
##### Locations

| Unit            | Location                   |
|:----------------|---------------------------:|
| Default         | `/usr/lib/systemd/system/` |
| Default         |     `/lib/systemd/system/` |
| Runtime         |     `/run/systemd/system/` |
| System specific |     `/etc/systemd/system/` |
| User specific   |       `/etc/systemd/user/` |
| User controlled |  `~/.config/systemd/user/` |

- These should have permissions:
  - `rw-r--r--`
  - `chmod 644`

##### Unit Types
- `.automount` - Mountpoints mounted automatically; requires matching `.mount` unit
- `.device` - Devices that need `systemd`
- `.mount` - Mountpoints managed by `systemd`
- `.path` - Matching `.system` unit activates at specified state; `inotify` monitors path changes
- `.scope` - Created by `systemd` for info from bus interfaces
- `.slice` - For Linux Control Group nodes, grants permissions for associated processes
- `.snapshot` - Created by `systemctl snapshot`
- `.service` - Services
- `.socket` - Network or IPC socket
- `.swap` - Matches device or path of its related swap space
- `.target` - For booting stages
- `.timer` - Like a `cron` task; matching unit starts at specified time

##### File Attributes & Settings
- *This is not comprehensive, but most of these are not used in common unit configs*
- *More common sections and attributes tend to come toward the top*
- `[Unit]`
  - `Description=` - Appears at top of `systemctl status`
  - `Documentation=` - `man` references
  - `After=` - Run this unit *after* items here
  - `Before=` - Run this unit *before* items here
  - `Wants=` - These are nice if run before
  - `Requires=` - These must be run before
  - `BindsTo=` - Same as `Requires=`, but also stops with other unit
  - `Conflicts=` - These conflict
  - `Condition___=` prefix - Unmet conditions result in unit skipped gracefully
  - `Assert___=` prefix - Unmet conditions result in failure
- `[Service]` (Type)
  - `Type=` - Type of service
    - `simple` - Default
    - `forking` - Creates child processes
    - `oneshot` - Process is short-lived; `systemd` should wait for this to finish before proceeding
    - `dbus` - Unit will take a D-Bus name
    - `notify` - Unit will issue notification after starting; `systemd` will wait for this before proceeding
    - `idle` - Unit will not run until all jobs are initiated
  - `ExecStart=` - CLI command to start
  - `ExexStartPre=` - Extra commands before starting
  - `ExecStop=` - CLI command to stop
  - `ExecStopPost=` - Extra commands after starting
  - `ExecReload=` - CLI command to reload
  - `EnvironmentFile=` - Path to main config
  - `RestartSec=` - Seconds to wait with `systemctl restart`
  - `TimeoutSec=` - Seconds to wait for `systemctl stop` before killing
  - `RemainAfterExit=` - Considered active even after exit
  - `PIDFile=` - (`Type=forking`) Path to file of PID
  - `BusName=` - (`Type=dbus`) D-Bus name
  - `NotifyAccess=` - (`Type=notify`)
- `[Socket]` (Type)
  - `ListenStream=` - Address for stream socket; TCP needs this
  - `ListenDatagram=` - Address for datagram socket; UDP needs this
  - `ListenSequentialPacket=` - Address for sequential communication with max length datagrams, Unix sockets use this
  - `ListenFIFO=` - Also define a FIFO bugger instead of a socket
  - `Accept=` - Start new service instances per connection? Default `false`
  - `SocketUser=` - Socket owner
  - `SocketGroup=` - Socket group owner
  - `SocketMode=` - Permissions for Unix FIFO buffer
  - `Service=` - Service name, if does not match the `.socket` file name
- `[Install]`
  - `WantedBy=` - Other target that will start this automatically
  - `RequiredBy=` - Like `WantedBy=` Other activation fails without this unit
  - `Alias=` - Other service name that can refer to this
  - `Also=` - Other service started and stopped with this unit
  - `DefaultInstance=` - For template unites; fallback value if template's name not found
- `[Mount]`
  - `What=` - Path of resource
  - `Where=` - Path of mount point
  - `Type=` - Filesystem
  - `Options=` - Mount options
  - `SloppyOptions=` - Boolean, fail if unknown mount option?
  - `DirectoryMode=` - Permissions if system must create parent directory for mount point
  - `TimeoutSec=` - Seconds to wait to determine fail
- `[Automount]` (Corresponds to corresponding `.mount` unit file)
  - `Where=` - Path of resource
  - `DirectoryMode=` - Permissions if system must create parent directory for mount point
- `[Swap]`
  - `What=` - Path of swap space
  - `Priority=` - Integer, priority vs other swap spaces
  - `Options=` - Mount options
  - `TimeoutSec=` - Seconds to wait to determine fail
- `[Path]`
  - `PathExists=` - Activate unit if this path exists
  - `PathExistsGlob=` - Activate unit if glob exists
  - `PathChanged=` - Watch for changes in this file; activate if changed file closes
  - `PathModified=` - Watch for changes in this file; activate if changed file closes or writes
  - `DirectoryNotEmpty=` - Activate when directory is no longer empty
  - `Unit=` - Unit to activate when `PathExists=` condition is met; otherwise `systemd` will look for a `.service` file
  - `MakeDirectory=` - Create parent directory for a watched path
  - `DirectoryMode=` - Permissions if using `MakeDirectory=`
- `[Timer]`
  - `OnActiveSec=` - Seconds until activated relative to `.timer` unit activation
  - `OnBootSec=` - Seconds until activated after system boot
  - `OnStartupSec=` - Seconds until activated after `systemd` starts
  - `OnUnitActiveSec=` - Seconds until activated after associated unit started
  - `OnUnitInactiveSec=` - Seconds until activated after associated unit marked inactive 
  - `OnCalendar=` - Absolute start time, not relative
  - `AccuracySec=` - Timer accuracy in seconds; default is 1 minute
  - `Unit=` - Associated unit to active; otherwise `systemd` will look for a `.service` file
  - `Persistent=` - If timer triggered while inactive, trigger when timer becomes active
  - `WakeSystem=` - Wake system from suspend if timer triggers during suspend
- `[Slice]`
  - No attributes, but other resource management definitions

##### Examples Files

**/usr/lib/systemd/system/dddummy.service** : (dummy process running `dd`)

```
[Unit]
Description=dd dry process

[Service]
ExecStart=/usr/bin/dd if=/dev/urandom of=/dev/null

[Install]
WantedBy=multi-user.target
```

| **/usr/lib/systemd/system/sshd.service** :

```
[Unit]
Description=OpenSSH Daemon
Wants=sshdgenkeys.service
After=sshdgenkeys.service
After=network.target

[Service]
ExecStart=/usr/bin/sshd -D
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=always

[Install]
WantedBy=multi-user.target
```

| **/lib/systemd/system/dbus.service** :

```
[Unit]
Description=D-Bus System Message Bus
Documentation=man:dbus-broker-launch(1)
DefaultDependencies=false
After=dbus.socket
Before=basic.target shutdown.target
Requires=dbus.socket
Conflicts=shutdown.target

[Service]
Type=notify
Sockets=dbus.socket
OOMScoreAdjust=-900
LimitNOFILE=16384
ProtectSystem=full
PrivateTmp=true
PrivateDevices=true
ExecStart=/usr/bin/dbus-broker-launch --scope system --audit
ExecReload=/usr/bin/busctl call org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus ReloadConfig
```

### The `systemctl` Tool
*The main utility for managing services*
- `systemctl` is at `/usr/bin/systemctl`
- Some require `root` permissions, some don't

#### Using `systemctl`
- Listing units:#
  - `systemctl` - All that `systemctl` controls
    - On a LAMP server, you will see services like:
      - `httpd.service`
      - `mariadb.service`
      - `php-fpm.service`
  - `systemctl list-units -t service` - Only running services
  - `systemctl list-units -t service --all` - All available services
  - `systemctl list-units --user "xdg*" --all` All desktop services (returns nothing on cloud VPS)
  - `systemctl | grep running` - All running services
- Managing services:#
  - `systemctl status SOME_SERVICE` - See status of SOME_SERVICE
  - Eg: `systemctl status mariadb`
  - `systemctl enable SOME_SERVICE` - Enable SOME_SERVICE so it runs at next startup
  - `systemctl start SOME_SERVICE` - Start SOME_SERVICE now
  - `systemctl stop SOME_SERVICE` - Stop SOME_SERVICE now
  - `systemctl disable SOME_SERVICE` - Disable SOME_SERVICE so it no longer runs at next startup

___

# The Keys
*Practice commands for SysAdmins who already know what these mean*

```console
ls | wc 1
seq 10

hostname
hostname -i
lsb_release -d
lsmod
lscpu
lsmem
lsblk
lsusb
lspci
free

find /usr/bin -perm -u+s
find /etc -type d -iname "*.d"
cd /etc
find . -iname "*.d"

whatis dmidecode
sudo dmidecode
sudo dmidecode -t bios
sudo dmidecode -t memory
sudo dmidecode -t system
sudo dmidecode -t

cd /usr/lib/systemd
find . -name "*.service"
cd /usr/lib/systemd/system
ls
cd /etc/systemd/user
ls
ls ~/.config/systemd/user
ls /etc/systemd/system

systemctl
systemctl list-units -t service
systemctl list-units -t service --all
systemctl list-units --user "xdg*" --all

su
cat <<EOF > /usr/lib/systemd/system/ddran.service
[Unit]
Description=dd dry process

[Service]
ExecStart=/usr/bin/dd if=/dev/urandom of=/dev/null

[Install]
WantedBy=multi-user.target
EOF
cat /usr/lib/systemd/system/ddran.service
systemctl enable ddran
systemctl start ddran
systemctl status ddran
systemctl stop ddran
systemctl status ddran
systemctl disable ddran
rm /usr/lib/systemd/system/ddran.service
exit
```

___

#### [Lesson 2: Procesesses & Monitoring](https://github.com/inkVerb/vip/blob/master/601/Lesson-02.md)