# Linux 601
## Lesson 1: Boot & System Init

# The Chalk
## Useful Commands
### Command Info
- `which Command_Name` - command location
- `whereis Command_Name` - command & man-file locations
- `whatis Command_Name` - command descriptions (found across system)
- `type Command_Name` - command role or purpose
- `whoami` - current user
- `pwd` - Present Working Directory (PWD)
- `ls | wc -l` - number of files in PWD
  - `wc` - word count (needs piped input, like `tee`)
- `seq 10` - print numbers 1-10, one per line (useful for loops)
- `find /etc -type d -iname "*.d"`
- `find . -perm -u+s` (for `s` permissions on **setuid** programs, see [Lesson 2: Procesesses & Monitoring](https://github.com/inkVerb/vip/blob/master/601/Lesson-02.md))
  - `-perm` - Permissions search with same notation at `chmod`, but prefix with `-` hyphen

### Machine Information
- `timedatectl` Time info
- `uptime` Machine uptime
- `free` RAM info
- `lsb_release -d` Architecture/ditstro
- `lsmod` enabled modules
- `lsgpu` (`intel-gpu-tools` package on all distros)
- `lscpu` CPU info
- `lsmem` RAM info
- `lsblk` disks
- `lsusb` USB devices
- `lspci` PCI devices
- `sudo dmidecode` system BIOS version
  - Desktop Management Interface (DMI)
  - `sudo dmidecode -t bios`
  - `sudo dmidecode -t memory`
  - `sudo dmidecode -t system`
  - `sudo dmidecode -t` (for full list of Types)

## Boot Process
1. **BIOS** - Basic Input/Output System
  - Stored in flash memory on the Motherboard
  - Executes GPT/MBR
2. **GPT** - GUID Partition Table (formerly MBR - Master Boot Record)
  - Bootable partition
  - Executes GRUB
  - [Lesson 7: Disk & Partitioning](https://github.com/inkVerb/vip/blob/master/601/Lesson-07.md)
3. **GRUB** - Grand Unified Bootloader
  - Menu at boot up
  - Executes the **kernel command** (recorded at `/proc/cmdline` after boot)
  - [Lesson 1: Boot & System Init](https://github.com/inkVerb/vip/blob/master/601/Lesson-01.md) (this lesson)
4. **Kernel** - The actual Operating System
  - Executes `/sbin/init`
  - [Lesson 5: Kernel & Devices](https://github.com/inkVerb/vip/blob/master/601/Lesson-05.md)
5. **Init** - Init (via `systemd`)
  - Executes **targets** (formerly **runlevels**)
  - [Lesson 1: Boot & System Init - init](https://github.com/inkVerb/vip/blob/master/601/Lesson-01.md#init) (this lesson)
  - [Lesson 2: Procesesses & Monitoring - Process Creation](https://github.com/inkVerb/vip/blob/master/601/Lesson-02.md#process-creation)
6. **Targets** - Stages of finishing the machine for normal use
  - Executes tools in `/usr/lib/systemd/` by configs in `/lib/systemd/system/`
  - [Lesson 1: Boot & System Init - Targets](https://github.com/inkVerb/vip/blob/master/601/Lesson-01.md#targets) (this lesson)

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
  2. Press <kbd>E</kbd> for "edit"
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
  - Ubuntu 16.04
  - Still contains wappers for SysVinit utilities for backwared compatability
  - An exciting human side of its development and Linux-wide implementation
  - All main Linux distros today

### `systemd`
- *Implementing* `init` with `systemd` means:
  - `/sbin/init` is a symlink to `/lib/systemd/systemd`
    - Thus other things can happen
  - **see for yourself** :$ `ls -l /sbin/init`
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

#### Targets
- **SysVinit** used **run levels**; each run level had to finish before the next was allowed to begin
  - This was because the first processors had only one core and boot rarely happened, so boot speed was obsolete
  - Run levels used shell scripts to run each program
- **`systemd`** replaced **SysVinit run levels** with **targets**, which can run with some parallel concurrency
  - This is allowed because of multicore processors and our need for speed
  - An actual program runs the targets
  - See the target on your machine with :$
    - `systemd-analyze` - status
    - `systemd-analyze critical-chain` - tree

| SysVinit     | Name                                                          | `systemd` target      |
|:-------------|:--------------------------------------------------------------|:--------------------|
| Run level 0  | Halt                                                          | `shutdown.target`   |
| Run level 1  | Singer-user text mode                                         | `sysinit.target`<br>`rescue.target`     |
| Run level 2  | Not used (user-definable)                                     | ∅                  |
| Run level 3  | Multiuser text mode<br> (networking included)                 | `sockets.target`<br>`basic.target`<br>`network.target`<br>`multi-user.target` |
| Run level 4  | Not used (user-definable)                                     | ∅                  |
| Run level 5  | Multiuser graphical mode<br> (with X-window GUI login screen) | `graphical.target`  |
| Run level 6  | Reboot                                                        | `reboot.target`     |
| emergency    | Emergency shell                                               | `emergency.target`  |

#### `systemd` Unit Config Files (`.service`, et al)
- Tools
  - `/lib/` is a common symlink to `/usr/lib/`
  - Thus `/lib/systemd/` is usually `/usr/lib/systemd/`
- User unit configs
  - `/etc/systemd/user/`
  - `~/.config/systemd/user/`

##### Unit Config File Locations

| Unit            | Location                   |
|:----------------|---------------------------:|
| Default         |     `/lib/systemd/system/` |
| Runtime         |     `/run/systemd/system/` |
| System specific |     `/etc/systemd/system/` |
| User specific   |       `/etc/systemd/user/` |
| User controlled |  `~/.config/systemd/user/` |

- These should have permissions:
  - `rw-r--r--`
  - `chmod 0644`
- Some user-specific directories may not exist if they would be empty, especially in the home folder

##### Unit Config File Types
*The config files run & monitored by `systemctl`*

- *Note files of a specific extension may also require specific attributes (below)*
  - ie: `.timer` files may require a `[Timer]` section and attributes
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

##### Unit Config File Attributes & Settings
- *Not comprehensive, yet most of these are not used in common unit configs*
- *Those toward the top tend to be more common sections and attributes*
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

##### Example Unit Config Files

| **/usr/lib/systemd/system/dddummy.service** : (dummy service running `dd`)

```
[Unit]
Description=dd running nothing

[Service]
ExecStart=/usr/bin/dd if=/dev/urandom of=/dev/null

[Install]
WantedBy=multi-user.target
```

| **/usr/lib/systemd/system/sshd.service** : (`ssh` server login service)

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

| **/lib/systemd/system/dbus.service** : (**D-Bus** desktop inter-app comm service)

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

- *Note `After=network.target` in these below, so they run with the `network.target`*

| **/lib/systemd/system/httpd.service** : (stock **Apache** service)

```
[Unit]
Description=Apache Web Server
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=simple
ExecStart=/usr/bin/httpd -k start -DFOREGROUND
ExecStop=/usr/bin/httpd -k graceful-stop
ExecReload=/usr/bin/httpd -k graceful
PrivateTmp=true
LimitNOFILE=infinity
KillMode=mixed

[Install]
WantedBy=multi-user.target
```

| **/lib/systemd/system/php-fpm.service** : (stock **PHP-FPM FastCGI** service)

```
[Unit]
Description=The PHP FastCGI Process Manager
After=network.target

[Service]
Type=notify
PIDFile=/run/php-fpm/php-fpm.pid
ExecStart=/usr/bin/php-fpm --nodaemonize --fpm-config /etc/php/php-fpm.conf
ExecReload=/bin/kill -USR2 $MAINPID
PrivateTmp=true
ProtectSystem=full
PrivateDevices=true
ProtectKernelModules=true
ProtectKernelTunables=true
ProtectControlGroups=true
RestrictRealtime=true
RestrictAddressFamilies=AF_INET AF_INET6 AF_NETLINK AF_UNIX
RestrictNamespaces=true

[Install]
WantedBy=multi-user.target
```

- *Custom `.service` examples*

| **/etc/systemd/system/mynodeapp.service** : (**Node.js** app as a `.service`)

```
[Unit]
Description=My Node.js App
Documentation=https://mynodeappdomain.tld/read-the-docs
ConditionPathExists=/srv/www/node
After=network.target

[Service]
Environment=NODE_PORT=3001
Type=simple
User=www
Group=www
ExecStart=/usr/bin/node /srv/www/node/my_node_app.js
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

| **/etc/systemd/system/mygoapp.service** : (**Go** app as a `.service`)

```
[Unit]
Description=My Go App
Documentation=https://mygoappdomain.tld/read-the-docs
ConditionPathExists=/srv/www/mygoapp
After=network.target

[Service]
Type=simple
User=www
Group=www
WorkingDirectory=/srv/www/mygoapp
ExecStart=/usr/local/go/bin/go run .
SyslogIdentifier=MyGoAppService
StandardOutput=syslog
StandardError=syslog
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```

#### The `systemctl` Tool
*The main utility for managing Units*

- `systemctl` is at `/usr/bin/systemctl`
- Some uses require `root` permissions; some don't
- Runs & monitors processes defined in **System Unit Config Files**
- Looks for argued config files in the `.../systemd/.../` locations (above)
- Searches for `.service` files by default, others must be specified
  - eg: `httpd.service` can be managed with `systemctl ... httpd`
    - `systemctl ... httpd.service` is redundant
  - This may not be true for other Unit Config filetypes

##### Using `systemctl`
- Listing units :#
  - `systemctl` - All that `systemctl` controls
    - On a LAMP server, you will see services like:
      - `httpd.service`
      - `mariadb.service`
      - `php-fpm.service`
  - `systemctl list-units -t timer` - Only running timers
  - `systemctl list-units -t service` - Only running services
  - `systemctl list-units -t service --all` - All available services
  - `systemctl | grep running` - All running services
- Managing services :#
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
which cd
which ls
which echo
which cat
which wc
which lsb_release
which free

whereis cd
whereis ls
whereis echo
whereis cat
whereis wc
whereis lsb_release
whereis free

whatis cd
whatis ls
whatis echo
whatis cat
whatis wc
whatis lsb_release
whatis free

type cd
type ls
type echo
type cat
type wc
type lsb_release
type free

whoami
pwd

ls | wc -l
cd /usr/bin
pwd
ls | wc -l
ls ls* | wc -l
cd /etc
pwd
ls | wc -l

seq 10
seq 20
seq 15

which lsb_release
whereis lsb_release
whatis lsb_release
type lsb_release
man lsb_release

timedatectl
uptime

free
lsb_release -d
lsb_release -v
lsb_release -i
lsb_release -c
lsb_release -a
lsb_release -r
lsmod
lscpu
lsgpu
lsmem
lsblk
lsusb
lspci

find /etc -type d -iname "*.d"
cd /etc
find . -iname "*.d"

whatis dmidecode
sudo dmidecode
sudo dmidecode -t bios
sudo dmidecode -t memory
sudo dmidecode -t system
sudo dmidecode -t

cat /proc/cmdline
vim /proc/cmdline
cd /proc
cat cmdline

ls -l /sbin/init
cd /sbin
pwd
ls | wc -l
ls
ls -l init
cd /lib/systemd
ls | wc -l
ls -l systemd

cd /usr/lib/systemd
ls
find . -name "*.service"
find . -name "*.service" | wc -l
cd /lib/systemd/system
ls
ls | wc -l
cd /run/systemd/system
ls
ls | wc -l
cd /etc/systemd/system
ls
ls | wc -l
cd /etc/systemd/user
ls
ls | wc -l
ls ~/.config/systemd/user
ls /etc/systemd/system

systemctl
systemctl list-units -t timer
systemctl list-units -t service
systemctl list-units -t service --all
systemctl list-units --user "xdg*" --all

su
cat <<EOF > /etc/systemd/system/ddran.service
[Unit]
Description=dd running nothing
After=sockets.target

[Service]
ExecStart=/usr/bin/dd if=/dev/urandom of=/dev/null

[Install]
WantedBy=multi-user.target
EOF

cat /etc/systemd/system/ddran.service

systemctl status ddran
systemctl enable ddran
systemctl start ddran
systemctl status ddran
systemctl stop ddran
systemctl status ddran
systemctl disable ddran
systemctl status ddran

rm /etc/systemd/system/ddran.service

exit
```

___

#### [Lesson 2: Procesesses & Monitoring](https://github.com/inkVerb/vip/blob/master/601/Lesson-02.md)