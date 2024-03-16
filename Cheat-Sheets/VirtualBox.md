# Oracle VirtualBox

For testing with networks

## Debian & CentOS

**(Download VirtualBox)[https://www.virtualbox.org/wiki/Downloads]**

## Arch/Manjaro

For reference:

- (Arch Wiki)[https://wiki.archlinux.org/title/VirtualBox]
- (Manjaro Wiki)[https://wiki.manjaro.org/index.php/VirtualBox]

*Install VirtualBox*

| **1** :$

```console
sudo pacman -Syy virtualbox
```

*Install host kernel modules (very necessary)*

*First get your kernel version*

| **2** :$

```console
mhwd-kernel -li
```

*Output should look something like:*

```
Currently running: 6.1.69-1-MANJARO (linux61)
The following kernels are installed in your system:
   * linux419
   * linux61
```

*(only the bottom kernel version matters, `linux61`)*

*...in which case we use `61` for `linux61` in the `linux*-virtualbox-host-modules` package...*

| **3** :$ (this command will need to be modified to correct `linux61` to your current kernel version number)

```console
sudo pacman -S linux61-virtualbox-host-modules
```

*Avoid trouble, make your current desktop user a member of the `vboxusers` group*

| **4** :$

```console
sudo gpasswd -a $USER vboxusers
```

*Now, before running virtualbox, you must start the kernel module*

| **5** :$

```console
sudo modprobe vboxdrv
```

*Modules for **Bridged** and **Host-only** networking*

| **6** :$

```console
sudo modprobe vboxnetflt vboxnetadp
```

*Prevent Wayland from blocking some keyboard input?*

| **7** :$ **??**

```console
gsettings get org.gnome.mutter.wayland xwayland-grab-access-rules
gsettings set org.gnome.mutter.wayland xwayland-grab-access-rules "['VirtualBox Machine']"
```

*Guest .iso package?*

*(The .iso file will be available at: `/usr/lib/virtualbox/additions/VBoxGuestAdditions.iso`)*

| **8** :$ **??**

```console
sudo pacman -S virtualbox-guest-iso
```

*Load kernel modules without restarting your computer?*

| **9** :$ **??**

```console
sudo vboxreload
```

*Optionally, add additional features for non-free, for personal use?*

- Oracle Cloud Infrastructure integration
- USB host controller
- Host webcam
- VirtualBox RDP
- PXE ROM
- Disk encryption
- NVMe

- ***Warning, this could break other `virtualbox` dependencies or packages***

| **10** :$ **??!!**

```console
yay -S virtualbox-ext-oracle
```

___

## Troubleshooting
- If you encounter a network-related error on starting a VM
  - Right click on the VM in the list, then try: > Settings... > Network
    - Attached to: NAT (or something else that works)
    - Enable Network Adapter (unckeck)
- If it keeps booting to your install .iso
  - Right click on the VM in the list, then try: > Settings... > Storage
  - Right click on the controller listing your .iso file
  - Click "Remove Controller"
- If you encounter other errors while using the VM, check if your disk is full where your "VirtualBox VMs" folder resides

## Relevant OS Images
*These are useful for practice with networking and security*

- [Kali Purple](https://www.kali.org/get-kali/#kali-installer-images) (Debian pen-testing for red-blue-team)
  - Good for **AppArmor** practice
  - Good for **Debian** practice
- [CentOS Stream](https://www.centos.org/centos-stream/) (RedHat, free)
  - Good for **SELinux** practice
  - Easy SELinux option is *PCI-DSS (Payment Card Industry Data Security Standard)* because it doesn't have partition mounting requirements at install time
- For additional security testing: (beyond these lessons)
  - [Metaspoitable 2](https://sourceforge.net/projects/metasploitable/files/Metasploitable2/)
  - [Metaspoitable 3](https://sourceforge.net/projects/metasploitable3-ub1404upgraded/)
  - [Windows for VM (Enterprise Evaluation)](https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/)
  - [Kali Linux](https://www.kali.org/get-kali/#kali-installer-images) (Debian pen-testing)
  - [BlackArch Linux](https://blackarch.org/) (Arch Linux pen-testing)

### Standard Linux Images
*These mainstream Linux distros may be useful for practice on different architectures*

- [Arch](https://archlinux.org/download/) (minimalist, rolling release, bleeding edge package versions)
- [Manjaro](https://manjaro.org/download/) (OOB-ready Arch)
- [Ubuntu](https://ubuntu.com/download/desktop) (built on Debian)
- [Xubuntu](https://xubuntu.org/download/) (Xfce Ubuntu - lightweight)
- [OpenSUSE](https://get.opensuse.org/tumbleweed/?type=desktop#download) (Tumbleweed - Rolling Release)
- [Fedora](https://fedoraproject.org/) (RedHat, free project by community funded by RedHat)

## Clipboard
- Click on the VM:
  - Settings > General > Advanced
  - Shared Clipboard: Bidirectional

## Networking
- VirtualBox:
  - File > Tools > Network Manager (<key>Ctrl</key> + <key>H</key>)
  - Create... (<key>Ctrl</key> + <key>Shift</key> + <key>C</key>)
  - Click on *the new network just created - `vboxnet0`?*
    - Right Click > Properties (<key>Ctrl</key> + <key>Shift</key> + <key>P</key>)
  - DHCP Server > Enable Server (checked / enabled)
  - Change the third oclet in each *Address* field to your custom number (eg `77`)
    - Server Address: `192.168.56.2` to `192.168.77.2`
    - Lower Address Bound: `192.168.56.3` to `192.168.77.3`
    - Upper Address Bound: `192.168.56.254` to `192.168.77.254`
  - Apply
  - Adapter > Configure Adapter Automatically (checked / enabled)
  - Apply
- *Connect VMs to this network*
  - For each VM you want on this network:
    - Click on the VM
    - Settings > Network
    - Adapter 1 (unchecked / disabled)
      - *This removes the machine's ability to access the Internet*
      - *For some distros, Adatper 1 does not conflict with Adapter 2, thus this may not be necessary*
      - *This is necessary on Kali Linux to prevent conflict with Adapter 2*
    - Adapter 2 (checked / enabled) > Host only Adapter
      - *This is always necessary for the VM to attain its own unique private virtual network IP address*
    - Adapter 2 > Name: *the same name as the new network just created - `vboxnet0`?*

### Other Networking Tools
- [CISCO Packet Tracer](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Packet-Tracer.md) to practice making your own networks in a simulator
