# Linux 601
## Lesson 6: Devices

# The Chalk
## User Device Management (`udev`)
- **`udev`** discovers onboard and peripheral hardware
  - Used during:
    - System boot
    - Hotplugging (AKA *plug and play*)
  - When used, will:
    - Name devices
    - Make files and symlinks
    - Define attributes in settings files
    - Set file permissions and ownerships
    - Carry out other related tasks
  - This creates device nodes used by applications and OS subsystems to talk to that hardware
  - Special rules can be written for `udev`

### Devices
- `ls -l /dev` *Note the time of their creation*
- `who -b` *Note the time the system booted matches*
- Those `/dev/` pseudofile devices were created by `udev` at system boot

### Workflow
1. Devices are added or removed
2. The kernel signals `udev`
3. `udev` scans `/etc/udev/rules.d/` for files that govern the device

#### Device Node Creation
- `ls -l /dev`
- From output: *Note the number pairs (`1, 3`, `508, 1`, etc)*

```
crw-rw-rw-   1 root root        1,   3  1月 18 21:14 null
crw-rw-rw-   1 root root      195,   0  1月 18 21:15 nvidia0
crw-rw-rw-   1 root root      195, 255  1月 18 21:14 nvidiactl
crw-rw-rw-   1 root root      195, 254  1月 18 21:15 nvidia-modeset
crw-rw-rw-   1 root root      508,   0  1月 18 21:14 nvidia-uvm
crw-rw-rw-   1 root root      508,   1  1月 18 21:14 nvidia-uvm-tools
crw-------   1 root root      238,   0  1月 20 10:59 nvme0
brw-rw----   1 root disk      259,   0  1月 18 21:14 nvme0n1
brw-rw----   1 root disk      259,   1  1月 18 21:14 nvme0n1p1
brw-rw----   1 root disk      259,   2  1月 18 21:14 nvme0n1p2
brw-rw----   1 root disk      259,   3  1月 18 21:14 nvme0n1p3
brw-rw----   1 root disk      259,   4  1月 18 21:14 nvme0n1p4
brw-rw----   1 root disk        8,   0  1月 18 21:14 sda
brw-rw----   1 root disk        8,   1  1月 18 21:14 sda1
crw-rw-rw-   1 root tty         5,   0  1月 19 13:22 tty
crw--w----   1 root tty         4,   0  1月 18 21:14 tty0
crw--w----   1 root tty         4,   1  1月 18 21:14 tty1
crw--w----   1 root tty         4,  10  1月 18 21:14 tty10
crw--w----   1 root tty         4,  11  1月 18 21:14 tty11
crw--w----   1 root tty         4,  12  1月 18 21:14 tty12
crw--w----   1 root tty         4,  13  1月 18 21:14 tty13
crw--w----   1 root tty         4,  14  1月 18 21:14 tty14
crw--w----   1 root tty         4,  15  1月 18 21:14 tty15
crw--w----   1 root tty         4,  16  1月 18 21:14 tty16
crw-rw-rw-   1 root root        1,   5  1月 18 21:14 zero
```

The first number is a ***major***, the second number is a ***minor***; see the [kernel docs](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Kernel-Devices.md)

- **`mknod`** creates a device node: #
  - `mknod -m 655 /dev/myusb c 254 1`
  - `mknod -m FILE_PERMISSIONS /dev/NAME TYPE MAJOR MINOR`
  - `-m` is standard file permissions for the device node pseudofile, same as used by `chmod`
  - NAME is the pseudofile it will be called in `/dev/`
  - TYPE:
    - `c` character device
    - `p` fifo (pipe)
    - `b` block device
  - MAJOR/MINOR
    - Device types listed in [kernel documentation](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Kernel-Devices.md)
    - This takes experience to know, sometimes just follow instructions
  - *`mknod` is an old school tool only used in a nightmare scenario today*
  - *Solving issues with an installed Linux server is best done by booting to an attached image, or USB if using a local machine*
  - Today, `udev` handles these automatically

#### Daemon
- `udev` uses one of two daemons to monitor netlink sockets
  - `udevd`
  - `systemd-udevd`
- When a device is attached or removed, the kernel's `uevent` facility signals sends a message through the socket, then `udev` works its magic

#### Components
- `udev` uses three components:
  - `libudev` - a library with info about devices
  - `udevd`/`systemd-udevd` - manages the `/dev/` folder
  - `udevadm` - control & diagnostics

### Rules Files
- `udev` rules are kept in two folders:
  - `/usr/lib/udev/rules.d/*.rules`
  - `/etc/udev/rules.d/*.rules`
  - `/run/udev/rules.d/*.rules` (a third location you can create)
- `.rules` file lines have two parts separated by a comma `,`:
  - Logical `==` statements matching attributes with values
  - Assignment `=` statements for `KEY="value"` for many uses
    - `NAME=my-usb`
    - `MODE="0755"`
    - `GROUP="www"`
- `udevadm monitor` watch the rules at work live
  - Try plugging in and out USB devices

___

#### [Lesson 7: Network](https://github.com/inkVerb/vip/blob/master/601/Lesson-07.md)