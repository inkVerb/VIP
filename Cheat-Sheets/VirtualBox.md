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

- (Kali Linux)[https://www.kali.org/downloads/]
- (Metaspoitable 2)[https://sourceforge.net/projects/metasploitable/files/Metasploitable2/]
- (Metaspoitable 3)[https://sourceforge.net/projects/metasploitable3-ub1404upgraded/]
- (Windows for VM (Enterprise Evaluation))[https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/]

Also see [CISCO Packet Tracer](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Packet-Tracer.md) to practice making your own networks in a simulator
