# VPS Archlinux
*This explains how to install Archlinux on a VPS instance from scratch*

1. Upload Arch ISO to custom images in the VPS supplier account
2. View Console
3. In console:
## Useful commands:
lsblk # View partitions
ping -c 1 archlinux.org # See if network is working

## To set up disks: (commands by line)
Enter
```
timedatectl set-ntp true
pacman -Sy archlinux-keyring --noconfirm
fdisk /dev/vda
```
Press: n, Enter (x5), w, Enter (x1)
## Now disk is partitioned
```
mkfs.btrfs --label arch /dev/vda1
mount /dev/disk/by-label/arch /mnt
```
## Now disk is mounted
```
pacstrap /mnt base linux linux-firmware --noconfirm
genfstab -L /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash
```
## Now system is ready and automatically mounted to / at startup

## Set up DHCP
```
cat <<EOF > /etc/systemd/network/enp1s0.network
[Match]
Name=enp1s0

[Network]
DHCP=ipv4
EOF
```

## DHCP, DNS, resolv forwards
```
systemctl enable systemd-networkd
systemctl enable systemd-resolved
#ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf # redundant?
```
## Hosts
```
echo 'verber' > /etc/hostname
cat <<EOF > /etc/hosts
127.0.0.1 localhost
127.0.1.1 verber.verberdomain verber
::1 localhost
EOF
```

## Rood password
```
passwd
```

## Grub
```
pacman -S grub --noconfirm
grub-install --target=i386-pc /dev/vda
sed 's/^GRUB_TIMEOUT=5$/GRUB_TIMEOUT=0/' -i /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
```

## Exit chroot & poweroff
```
exit
systemctl poweroff
```

## Use sudo
```
pacman -S sudo --noconfirm
cp /etc/sudoers /etc/sudoers.new
sed 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' -i /etc/sudoers.new
visudo -c -f /etc/sudoers.new && mv /etc/sudoers.new /etc/sudoers
```

## SSH
```
pacman -S openssh --noconfirm
sed 's/#Port 22/Port 22/' -i /etc/ssh/sshd_config
systemctl enable --now sshd
```

## Now the server is ready to behave like a normal Arch installation
