# VPS Archlinux
*This explains how to install Archlinux on a VPS instance from scratch*

1. Upload Arch ISO to custom images in the VPS supplier account
2. View Console
3. In console: Boot to install Arch

## Start with useful commands:

```console
lsblk # View partitions
ping -c 1 archlinux.org # See if network is working
```

## To set up disks: (commands by line)

`vda` may change based on the main disk seen from `lsblk`...

```console
timedatectl set-ntp true
pacman -Sy archlinux-keyring --noconfirm
fdisk /dev/vda
```

Press: <key>N</key>, <key>Enter</key> (x5), <key>W</key>, <key>Enter</key> (x1)

Now disk is partitioned

## Format disk & mount for temp use

Choose `btrfs` or `ext4`:

| **btrfs** :

```console
mkfs.btrfs -L arch /dev/vda1
mount /dev/disk/by-label/arch /mnt
```

| **ext4** :

```console
mkfs.ext4 /dev/vda1
mount /dev/vda1 /mnt
```

Now disk is temporarily mounted to install

## Start the install

```console
pacstrap /mnt base linux linux-firmware --noconfirm
genfstab -L /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash
```

Now system is ready and automatically mounted to / at startup

We are in `chroot` to operate on that temporarily mounted system to finish our setup needed before the first boot

## Set up DHCP

```console
cat <<EOF > /etc/systemd/network/enp1s0.network
[Match]
Name=enp1s0

[Network]
DHCP=ipv4
EOF
```

## DHCP, DNS, resolv forwards

```console
systemctl enable systemd-networkd
systemctl enable systemd-resolved
pacman -S dhcpcd --noconfirm
systemctl enable  dhcpcd.service
```

## Hosts

```console
echo 'myhost' > /etc/hostname
cat <<EOF > /etc/hosts
# localhost
127.0.0.1 localhost.localdomain localhost
127.0.1.1 myhost.mymachine myhost

# The following lines are desirable for IPv6 capable hosts
::1 localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts
EOF
```

## Rood password

```console
passwd
```

## Grub

```console
pacman -S grub --noconfirm
grub-install --target=i386-pc /dev/vda
sed 's/^GRUB_TIMEOUT=5$/GRUB_TIMEOUT=0/' -i /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
```

## Install a couple extra packages while we're here

```console
pacman -S sudo git vim --noconfirm
```

## Exit chroot & poweroff

```console
exit
systemctl poweroff
```

In VPS Settings, remove the Custom ISO

Restart the VPS and access the terminal as user: `root` Password: `whatever you typed for passwd`

## Use sudo

```console
pacman -S sudo --noconfirm
cp /etc/sudoers /etc/sudoers.new
sed 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' -i /etc/sudoers.new
visudo -c -f /etc/sudoers.new && mv /etc/sudoers.new /etc/sudoers
```

## SSH

```console
pacman -S openssh --noconfirm
sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
systemctl enable --now sshd
```

Now the server is ready to behave like a normal Arch installation
