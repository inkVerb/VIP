# Linux 601
## Lesson 5: Kernel & Devices

# The Chalk
## Kernel
*The kernel uses libraries, drivers, and modules to handle processes and hardware*

- CPU time allocation for man processes, applications, and services
- RAM
- Hardware connections and access
- System initialization and boot
- Process scheduling
- I/O middle man between applications and disks
- Filesystems, both local and network
- Security, both local filesystems and network
- Network itself

### Tools
- `sysctl` kernel settings
- `dmesg` display kernel messages

### Repairing & Re-installing the Kernel
*Every major Linux installation maintains basic and some previous images that can be booted from in `/boot/`*

- Many kernel commands are version-specific and can be best substituted for the current kernel version with `$(uname -r)`
   - To install a previous kernel, look for an earlier number in `/boot/`
   - In Arch/Manjaro, `uname -r` indicates kernels in `/usr/lib/modules/` (which may also contain `extramodules-` files)
- Re-install latest kernel:#
  - Arch/Manjaro: `kernel-install add $(uname -r) /usr/lib/modules/$(uname -r)/vmlinuz`
    - Or remove: `kernel-install remove $(uname -r)`
  - Debian/Ubuntu: `apt-get install --reinstall linux-image-generic`
    - Install specific kernel: `update-initramfs -u -k $(uname -r)`
  - RedHat/CentOS: `dnf reinstall kernel`
    - If that doesn't work, uninstall, then re-install:
      - `dnf remove kernel-$(unamne -r)`
      - `dnf install kernel-$(uname -r)`
  - OpenSUSE: (Kernels are handles as normal packages)
    - List all `kernel*` packages `zypper se -s 'kernel*'`
    - Install specific kernel: `zypper in kernel-default-VER.SI.ION.NUM`
    - Uninstall specific kernel: `zypper rm kernel-default-VER.SI.ION.NUM`
- Update/Repairing GRUB:
  - Do this if GRUB's menu doesn't work or if other systems (ie Windows) had changes
  - This will automatically see what all operating systems are available and create a GRUB menue with options for each
  - On a damaged system, these could be run from a rescue and `chroot`, explained in [Lesson 12: Backup & System Rescue](https://github.com/inkVerb/vip/blob/master/601/Lesson-12.md)
  - Arch & Debian:# `update-grub` (short version of `grub-mkconfig -o`)
  - RedHat/CentOS:# `grub2-mkconfig -o "$(readlink -e /etc/grub2.conf)"`

### Kernel Docs
- Official docs: [kernel.org/doc/html](https://www.kernel.org/doc/html/) (listed by version)
- Software packages:
  - `linux-docs` (Arch) installed at: `/usr/share/doc/linux/` (symlink to `/usr/lib/modules/x.x.x-...`)
  - `linux-doc` (Debian/Ubuntu) installed at: `/usr/share/doc/linux-doc/...`
  - `kernel-doc` (RedHat/CentOS) installed at: `/usr/share/doc/kernel-doc-x.xx.x/...`
  - `/usr/share/doc/.../index.html` can be read in a local browser directly
  - `/usr/share/doc/.../index.rst` can be read in the terminal using vim
  - You could use `grep` from the terminal to serch documentation

### Kernel Command Line
*The command that GRUB runs to start the kernel, kept at `/proc/cmdline`*

- All boot parameters are on one, single line
  - This is called the ***kernel command line*** or ***boot command line***
  - Usually the `linux` line of GRUB config: `/boot/grub/grub.cfg`
    - Default from the `GRUB_CMDLINE_LINUX_DEFAULT=` statement in `/etc/default/grub`
  - `man bootparam`
  - List of all kernel boot parameters:
    - `kernel-parameters.txt` in kernel source
- Find out what command line your system booted with:
  - `cat /proc/cmdline`
- Breakdown
  - `root=` the root filesystem, can take any accepted form of the first mount setting used in `/etc/fstab`
  - `rw` read-write root device on boot
  - `ro` read-only root device on boot
  - `find_preseed=` automatically pre-set install answers (Debian)
  - `crashkernel=` RAM to reserve for kernel crashdumps done via the `kdump` facility
  - `resume=` partition device for software suspend (hibernation)
  - `quiet` suppresses most log messages
  - `selinux=0` disables SELinux
  - `security=apparmor` uses apparmor security extension
  - `splash` shows the boot splash screen
  - `nomodeset` do not load video drivers for a high-res splash video on boot
  - `rhgb` Red Hat graphical boot facility (example of a parameter added by a vendor)
- **Examples of the *kernel command line***
  - Arch:
    - `linux   /boot/vmlinuz-linux root=UUID=s0m3-l0ng-uid-47h3-d1sk-xzy81a51nk1n rw  loglevel=3 quiet`
  - Manjaro:
    - `linux   /boot/vmlinuz-6.1-x86_64 root=UUID=s0m3-l0ng-uid-47h3-d1sk-xzy81a51nk1n rw  quiet splash apparmor=1 security=apparmor udev.log_priority=3`
  - Xubuntu:
    - `linux   /boot/vmlinuz-6.5.0-14-generic root=UUID=s0m3-l0ng-uid-47h3-d1sk-xzy81a51nk1n ro  quiet splash $vt_handoff`
  - Kali:
    - `linux   /boot/vmlinuz-6.3.0-kali1-amd64 root=UUID=s0m3-l0ng-uid-47h3-d1sk-xzy81a51nk1n ro  quiet splash`
  - OpenSUSE:
    - `linux   /boot/vmlinuz-6.7.5-1-default root=UUID=s0m3-l0ng-uid-47h3-d1sk-xzy81a51nk1n splash=silent mitigations=auto quiet security=apparmor`
  - CentOS SE: (not edited directly in `grub.cfg`)
    - `set kernelopts="root/dev/mapper/cs-root ro crashkernel=auto resume=/dev/mapper/cs-swap rd.lvm.lv=cs/root rd.lvm.lv=cs/swap rhgb quiet`
    - Actually in `/boot/grub2/grubenv`: `kernelopts="root/dev/mapper/cs-root ro crashkernel=auto resume=/dev/mapper/cs-swap rd.lvm.lv=cs/root rd.lvm.lv=cs/swap rhgb quiet`
    - Root settings in `/etc/default/grub`: `GRUB_CMDLINE_LINUX`
    - Or in `/boot/loader/entries/*.conf`
    - Best applied through `grub2-mkconfig` tool
      - BIOS: `grub2-mkconfig -o /boot/grub2/grub.cfg` for BIOS firmware
      - UEFI: `grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg` for UEIF firmware

### Boot Failure Causes
- **No bootloader screen**
  1. Bad GRUB config
  2. Corrupt boot sector on disk
- **Kernel load failure**
  1. Bad kernel config (if booted before, but received new parameters or upgrade)
  2. Corrupt kernel (more likely if booted successful in past)
  - Try re-installing or reverting kernel
  - Try minimal command from GRUB boot
  - Boot from rescue image to start troubleshooting
- **Kernel does not mount root filesystem**
  1. Bad `/etc/fstab` mounting
  2. No kernel support for the root filesystem at `/`, set by `root=` in the boot command line
  3. Bad GRUB config
- **`init` failure**
  - Look at messages before `init` stops
  - Boot from lower runlevel
    - `3` no graphics
    - `1` single user

### The `sysctl` Tool
*System settings for settings files in `/proc/sys/`*

- See current values: `sysctl -a`
  - Each line of output refers to a subdirectory-based pseudofile in `/proc/sys/`
  - `vm.zone_reclaim_mode=` is the pseudofile contents of `/proc/sys/vm/zone_reclaim_mode`
  - Changing these pseudofile contents will change the settings seen from `sysctl -a`
- Settings:
  - `/etc/sysctl.conf`: original file
  - `/usr/lib/sysctl.d/`: vendor-specific setting files, vary per distro
  - `/etc/sysctl.d/`: files will override
- Change settings:
  - `sudo sh -c 'echo 0 > /proc/sys/vm/zone_reclaim_mode'` (must use `sh -c` to run command as, or use `echo` from root prompt `#`)
  - `sudo sysctl vm.zone_reclaim_mode=0` (or run `sysctl` from root prompt `#`)
  - `/etc/sysctl.conf` - Settings will be implemented at boot
- Learn more:
  - `man sysctl.conf`

### Kernel Modules
*Modules that add capability to the kernel*

- Modules are located in `/lib/modules/$(uname -r)`
- Modules allod hardware drivers, network protocols, filesystems, and other such things that help the kernel

#### Tools
- `lsmod` list loaded kernel modules
- `modprobe` start a kernel module:#
  - Automatically loads and unloads dependency modules
  - `modprobe some-mod` load a module
  - `modprobe -r some-mod` unload a module
  - eg: `modprobe e1000e` load the `e1000e` module
  - eg: `modprobe -r e1000e` unload the `e1000e` module
- `insmod` insert a kernel module (`modprobe` alternative, but rare)
  - Full path with module name:#
  - `insmod /lib/modules/$(uname -r)/kernel/drivers/something/some-mod.ko.zst`
  - eg: `insmod /lib/modules/$(uname -r)/kernel/drivers/net/ethernet/intel/e1000e/e1000e.ko.zst`
  - Use `insmod` if the module might **not be** in the "proper" place
- `rmmod` remove a kernel module:#
  - `rmmod some-mod`
  - eg: `rmmod e1000e`
- `modinfo` get kernel module info:#
  - `modinfo` no arguments for all loaded mods
  - `modinfo some-mod`
  - eg: `modinfo e1000e`
  - Also seen in `/sys/module/...` pseudo filesystem
- `depmod` rebuild kernel module dependency database
  - Database file is located at `/lib/modules/$(uname -r)/modules.dep`

#### `/etc/modprobe.d/*.conf`
- `.conf` files in `/etc/modprobe.d/` are scanned when using `modprobe`
- These files contain settings, one command per line
- Parameters
  - `#` comment
  - `\` continue on next line
  - `alias`: `alias newalias modulename`
    - Assigns an alias for a module
  - `blacklist`: `blacklist modulename`
    - Blacklists a module
  - `install`: `modulename command...`
    - Installs a module using `modprobe`
  - `options`: `modulename option...`
    - Declares options for a module
  - `remove`: `remove modulename command...`
    - Removes a module using `modprobe -r`
  - `softdep`: `modulename pre: module module post: module module module`
    - Defines a modules pre- and post-dependencies

## Devices
- `who -b` *Note the time the system booted matches*
- `lspci -v` *Note kernel devices and the `Kernel modules:` per device*
- `ls -l /dev` *Note the time of their creation*
- Those `/dev/` pseudofile devices were created by udev at system boot

### User Device Management (udev)
*Devices located in `/dev/`*

- **udev** discovers onboard and peripheral hardware
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
  - Special rules can be written for udev

### Device Workflow
1. Devices are added or removed
2. The kernel signals udev
3. udev scans `/etc/udev/rules.d/` for files that govern the device

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

##### Create Custom Device Node (`mknod`)
- **`mknod`** creates a device node:#
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
  - Remove a device `/dev/devicename` created with `mknod` using:# `rm /dev/devicename`
  - *`mknod` is an old school tool only used in a nightmare scenario today*
  - *Solving issues with an installed Linux server is best done by booting to an attached image, or USB if using a local machine*
  - Today, udev handles these automatically

#### Devcice Daemon
- udev uses one of two daemons to monitor netlink sockets
  - `udevd`
  - `systemd-udevd`
- When a device is attached or removed, the kernel's `uevent` facility signals sends a message through the socket, then udev works its magic

#### Device Components
- udev uses three components:
  - `libudev` - a library with info about devices
  - `udevd`/`systemd-udevd` - manages the `/dev/` folder
  - `udevadm` - control & diagnostics

### Device Rules Files
- udev rules are kept in two folders:
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

# The Keys
*Practice commands for SysAdmins who already know what these mean*

| **Un/Re-Installing kernel** :#

```console
uname -r
cd /usr/lib/modules/
ls

# Arch
pacman -S linux
kernel-install add $(uname -r) /usr/lib/modules/$(uname -r)/vmlinuz
kernel-install remove $(uname -r)

# Ubuntu
apt-get install --reinstall linux-image-generic   # newest version
update-initramfs -u -k $(uname -r)                # current version

# RedHat
# SELinux: su = sudo -i
dnf reinstall kernel
dnf remove kernel-$(unamne -r)
dnf install kernel-$(uname -r)

# OpenSUSE
zypper se -s 'kernel*'
zypper in kernel-default-VER.SI.ION.NUM
zypper rm kernel-default-VER.SI.ION.NUM
```

| **Kernel docs** :#

```console
uname -r

# Arch
pacman -S linux-docs
cd /usr/share/doc/linux
ls

# Ubuntu
apt-get install linux-doc
cd /usr/share/doc/linux-doc
ls

# RedHat
dnf install kernel-doc
cd /usr/share/doc/
ls kernel-*

# OpenSUSE
zypper se -s 'kernel*'
zypper in kernel-default-VER.SI.ION.NUM
zypper rm kernel-default-VER.SI.ION.NUM
```

| **Linux docs in browser** ://

```console
file:///usr/share/doc/
```

| **Kernel management** :#

```console
man bootparam
cat /proc/cmdline
less /boot/grub/grub.cfg
grep linux /boot/grub/grub.cfg
```

| **`sysctl` tool** :$

```console
sysctl -a
cd /proc/sys
ls
less /etc/sysctl.conf
cd /usr/lib/sysctl.d
ls
cd /etc/sysctl.d
ls
man sysctl.conf
```

| **Kernel modules** :$

```console
cd /lib/modules/$(uname -r)
lsmod
modprobe cdrom
rmmod cdrom
lsmod
lsmod | grep alx
lsmod | grep cdrom
modinfo alx
modinfo cdrom
sudo depmod
less /lib/modules/$(uname -r)/modules.dep
cd /etc/modprobe.d/
ls
```

| **Devices** :$

```console
who -b
lspci -v
ls -l /dev
cd /etc/udev/rules.d
ls
cd /usr/lib/udev/rules.d
ls

sudo mknod -m 655 /dev/zmyusb c 254 1
ls -l /dev
sudo rm /dev/zmyusb
ls -l /dev

udevadm monitor
# Plug/unplug a USB
# Ctrl + C
```
___

#### [Lesson 6: Networks](https://github.com/inkVerb/vip/blob/master/601/Lesson-06.md)
