# Linux 601
## Lesson 5: Kernel

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
*Every Linux installation maintains basic and some previous images that can be booted from in `/boot/`*

- Many kernel commands are version-specific and can be best substituted for the current kernel version with `$(uname -r)`
   - To install a previous kernel, look for an earlier number in `/boot/`
   - In Arch/Manjaro, `uname -r` indicates kernels in `/usr/lib/modules/` (which may also contain `extramodules-` files)
- Re-install latest kernel: #
  - Arch/Manjaro: `kernel-install add $(uname -r) /usr/lib/modules/$(uname -r)/vmlinuz`
    - Or remove: `kernel-install remove $(uname -r)`
  - Debian/Ubuntu: `apt-get install --reinstall linux-image-generic linux-image`
    - Install specific kernel: `update-initramfs -u -k $(uname -r)`
  - CentOS/Fedora: `dnf reinstall kernel`
    - If that doesn't work, uninstall, then re-install:
      - `dnf remove kernel-$(unamne -r)`
      - `dnf install kernel-$(uname -r)`
- Update/Repairing GRUB:
  - Do this if GRUB's menu doesn't work or if other systems (ie Windows) had changes
  - This will automatically see what all operating systems are available and create a GRUB menue with options for each
  - On a damaged system, these could be run from a rescue and `chroot`, explained in [Lesson 12: Backup & System Rescue](https://github.com/inkVerb/vip/blob/master/601/Lesson-12.md)
  - Arch & Debian: # `update-grub` (short version of `grub-mkconfig -o`)
  - CentOS/Fedora: # `grub2-mkconfig -o "$(readlink -e /etc/grub2.conf)"`

### Kernel Command Line
- All boot parameters are on one, single line
  - This is called the ***kernel command line*** or ***boot command line***
  - Usually the `linux` line of GRUB config: `/boot/grub/grub.cfg`
    - Default from the `GRUB_CMDLINE_LINUX_DEFAULT=` statement in `/etc/default/grub`
- Find out what command line your system booted with:
  - `cat /proc/cmdline`
- Breakdown
  - `root=` the root filesystem, can take any accepted mount form also used in `/etc/fstab`
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
- **Settings for the *kernel command line***
  - Xubuntu:
    - `linux   /boot/vmlinuz-6.5.0-14-generic root=UUID=s0m3-l0ng-uid-47h3-d1sk-xzy81a51nk1n ro  quiet splash $vt_handoff`
  - Arch:
    - `linux   /boot/vmlinuz-linux root=UUID=s0m3-l0ng-uid-47h3-d1sk-xzy81a51nk1n rw  loglevel=3 quiet`
  - Manjaro:
    - `linux   /boot/vmlinuz-6.1-x86_64 root=UUID=s0m3-l0ng-uid-47h3-d1sk-xzy81a51nk1n rw  quiet splash apparmor=1 security=apparmor udev.log_priority=3`
  - Kali:
    - `linux   /boot/vmlinuz-6.3.0-kali1-amd64 root=UUID=s0m3-l0ng-uid-47h3-d1sk-xzy81a51nk1n ro  quiet splash`
  - CentOS: (not edited directly)
    - `set kernelopts="root/dev/mapper/cs-root ro crashkernel=auto resume=/dev/mapper/cs-swap rd.lvm.lv=cs/root rd.lvm.lv=cs/swap rhgb quiet`
    - Actually in `/boot/grub2/grubenv`: `kernelopts="root/dev/mapper/cs-root ro crashkernel=auto resume=/dev/mapper/cs-swap rd.lvm.lv=cs/root rd.lvm.lv=cs/swap rhgb quiet`
    - Root settings in `/etc/default/grub`: `GRUB_CMDLINE_LINUX`
    - Or in `/boot/loader/entries/*.conf`
    - Best applied through `grub2-mkconfig` tool
      - BIOS: `grub2-mkconfig -o /boot/grub2/grub.cfg` for BIOS firmware
      - UEFI: `grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg` for UEIF firmware
- **List of all kernel boot parameters**
  - `kernel-parameters.txt` in kernel source
  - Official docs: [kernel.org/doc/html](https://www.kernel.org/doc/html/) (listed by version)
  - Software packages:
    - `linux-docs` (Arch) installed at: `/usr/share/doc/linux/` (symlink to `/usr/lib/modules/x.x.x-...`)
    - `linux-doc` (Debian/Ubuntu) installed at: `/usr/share/doc/linux-doc/...`
    - `kernel-doc` (CentOS/Fedora) installed at: `/usr/share/doc/kernel-doc-x.xx.x/...`
    - `/usr/share/doc/.../index.html` can be read in a local browser directly
    - `/usr/share/doc/.../index.rst` can be read in the terminal using vim
    - You could use `grep` from the terminal to serch documentation
  - `man bootparam`

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
- See current values: `sysctl -a`
  - Each line of output refers to a subdirectory-based pseudofile in `/proc/sys/`
  - `vm.zone_reclaim_mode=` is the pseudofile contents of `/proc/sys/vm/zone_reclaim_mode`
  - Changing these pseudofile contents will change the settings seen from `sysctl -a`
- Change settings:
  - `sudo sh -c 'echo 0 > /proc/sys/vm/zone_reclaim_mode'` (must use `sh -c` to run command as, or use `echo` from root prompt `#`)
  - `sudo sysctl vm.zone_reclaim_mode=0` (or run `sysctl` from root prompt `#`)
  - `/etc/sysctl.conf` - Settings will be implemented at boot
    - Learn more: `man sysctl.conf`
    - `/etc/sysctl.conf`: original file
    - `/usr/lib/sysctl.d/`: vendor-specific setting files, vary per distro
    - `/etc/sysctl.d/`: files will override

## Kernel Modules
- Modules are located in `/lib/modules/$(uname -r)`
- Modules allod hardware drivers, network protocols, filesystems, and other such things that help the kernel

### Tools
- `lsmod` list loaded kernel modules
- `modprobe` insert a kernel module (`insmod` also, but rare)
  - Full path with module name: #
  - `insmod /lib/modules/$(uname -r)/kernel/drivers/something/some-mod.ko.zst`
  - eg: `insmod /lib/modules/$(uname -r)/kernel/drivers/net/ethernet/intel/e1000e/e1000e.ko.zst`
  - Use `insmod` if the module might **not be** in the "proper" place
- `rmmod` remove a kernel module: #
  - `rmmod some-mod`
  - eg: `rmmod e1000e`
- `modprobe` start a kernel module: #
  - Automatically loads and unloads dependency modules
  - `modprobe some-mod` load a module
  - `modprobe -r some-mod` unload a module
  - eg: `modprobe e1000e` load the `e1000e` module
  - eg: `modprobe -r e1000e` unload the `e1000e` module
- `modinfo` get kernel module info: #
  - `modinfo` no arguments for all loaded mods
  - `modinfo some-mod`
  - eg: `modinfo e1000e`
  - Also seen in `/sys/module/...` pseudo filesystem
- `depmod` rebuild kernel module dependency database: #
  - File is located at `/lib/modules/$(uname -r)/modules.dep`

### `/etc/modprobe.d/*.conf`
- `.conf` files in `/etc/modprobe.d/` are scanned when using `modprobe`
- These files contain settings, one command per line
- Commands
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

___

#### [Lesson 6: Devices](https://github.com/inkVerb/vip/blob/master/601/Lesson-06.md)
