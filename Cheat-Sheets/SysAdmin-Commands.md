# SysAdmin Commands

General final commands after completing **[Linux 601: SysAdmin](https://github.com/inkVerb/VIP/blob/master/601/README.md)**

# The Keys
*Commands are meant to be run as `su` for practice*

*(This is not a lesson and which commands require `sudo` permissions are not taught; this is only for study retention by repetition)*

## Lesson 1: Boot & System Init

```console
which seq
whereis ps
whatis lsb_release
type free
man timedatectl

whoami
uname -r
lsb_release -d
lsmod
lscpu
lsgpu
lsmem
lsblk
lsusb
lspci

whatis dmidecode
dmidecode
dmidecode -t bios
dmidecode -t memory
dmidecode -t system
dmidecode -t

find /etc -type d -iname "*.d"
cd /etc
find . -iname "*.d"
cd /usr/lib/systemd
ls
find . -name "*.service"
find . -name "*.service" | wc -l

cat /proc/cmdline
ls -l /sbin/init
ls -l /lib/systemd/systemd
ls /sbin/ | wc -l

systemctl
systemctl list-units -t timer
systemctl list-units -t service
systemctl list-units -t service --all
systemctl list-units --user "xdg*" --all

su
cat <<EOF > /etc/systemd/system/ddran.service
[Unit]
Description=dd running nothing

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
```

## Lesson 2: Procesesses & Monitoring

```console
find /usr/bin -perm -u+s

cd /usr/bin
ls -l | grep rws
find . -perm -u+s
find . -perm -u+x

# Choose gedit for GNOME or mousepad for Xfce
gedit &&
ps -C gedit
ps -C gedit -o cmd,pid,uid,ruid,euid,suid,user,ruser,euser,suser
ps -C gedit -o cmd,pid,cputime,pmem
pgrep gedit
pstree -aAp $(pgrep gedit)
killall gedit

mousepad &&
ps -C mousepad
ps -C mousepad -o cmd,pid,uid,ruid,euid,suid,user,ruser,euser,suser
ps -C mousepad -o cmd,pid,cputime,pmem
pgrep mousepad
pstree -aAp $(pgrep mousepad)
killall mousepad

d if=/dev/zero of=/dev/null &
jobs -l
ps -C dd
ps -C dd -o cmd,pid,cputime,pmem,uid,ruid,euid,suid,user,ruser,euser,suser
kill %1

cat /etc/security/limits.conf
ulimit -a
ulimit -H -u 256512
exit
ulimit -S -u 64128

cd sys/vm
ls
cat overcommit_memory
cat overcommit_ratio

at 14:09 -f somescript
# End each with Ctrl + D
at now + 3 hours
at now + 1 week
at 22:56

cat <<EOF > /etc/cron.d/chores
0/15 * * * 2 root /usr/bin/echo "Every Tuesday, every 15 minutes from 00 minutes"
15 12 * * * root /usr/bin/echo "Every day at 12:15 PM"
22 4 14 * * root /usr/bin/echo "The 14th of every month at 4:22 AM"
0 3 1 6,9 * root /usr/bin/echo "June 1 and September 1 at 3:00 AM"
EOF
cat /etc/cron.d/chores
ls -l /etc/cron.d/chores
chmod 0644 /etc/cron.d/chores
ls -l /etc/cron.d/chores
rm /etc/cron.d/chores
```

## Lesson 3: Users & Groups

```console
ls ~/.bash*
cat ~/.bashrc
echo $PATH
echo $SHELL
ps -p $$
cat /etc/shells

cat /etc/profile
less /etc/bash.bashrc

alias vovo="echo hello"
vovo
unalias vovo
vovo
echo 'alias vovo="echo hello"' >> ~/.profile
vim ~/.profile

history
echo $SHELL
cat ~/.bash_history
cat ~/.zsh_history
history | tail
cd /etc/skel
ls -a

useradd pinky -s /bin/sh -m -k /etc/skel
grep pinky /etc/passwd
grep pinky /etc/shadow
passwd pinky
# 123456 x2
su pinky
# 123456
chsh -s /bin/bash
echo $SHELL
exit
userdel pinky

useradd pinky -s /bin/sh -m -k /etc/skel
useradd binky -s /bin/bash -m -k /etc/skel
useradd zinky -s /bin/zsh -m -k /etc/skel
chage -E 1970-01-01 pinky
chage -E 1970-01-01 binky
chage -E 1970-01-01 zinky
vim /etc/shadow
# Remove the values between the last three colons on the three user lines to :::
chage -l pinky
usermod -L pinky
usermod -L binky
usermod -L zinky
usermod -U pinky
usermod -U binky
usermod -U zinky

echo "pinky ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/inky
echo "binky ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/inky
echo "zinky ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/inky
rm /etc/sudoers.d/inky

usermod pinky -aG sudo
usermod binky -aG sudo
usermod zinky -aG sudo

groupadd inky
usermod pinky -aG inky
usermod binky -aG inky
usermod zinky -aG inky

groups pinky
groups binky
groups zinky
groups inky
id pinky binky zinky
id -Gn pinky binky zinky

cd /home/pinky
mkdir /home/pinky/touchy /home/binky/touchy /home/zinky/touchy
chown -R zinky:zinky /home/pinky/touchy
chown -R binky:binky /home/binky/touchy
chown -R binky:pinky /home/zinky/touchy

su pinky
# 123456
cd ~/touchy
umask
umask 0002
umask
touch one two three
ls -l
umask 0022
touch four five six seven
ls -l

chmod ug+x one two
chmod o-r three
chmod 775 one
chmod 755 two
chmod 644 three
ls -l
exit

cd /home/pinky/touchy
getfacl one
ls -l
setfacl -m u:binky:rwx one
setfacl -m u:binky:r-x two
setfacl -m u:binky:r-- three
setfacl -m g:inky:rwx four
setfacl -m g:inky:r-x five
setfacl -m g:inky:r-- six
ls -l
getfacl one
getfacl two
getfacl three
getfacl four
getfacl five
getfacl six
getfacl seven

userdel pinky
userdel binky
userdel zinky
cd /home
rm -r /home/pinky /home/binky /home/zinky
```

## Lesson 4: Git & Revision Control

```console
mkdir sshtest
cd sshtest
ssh-keygen -t rsa -N "" -f key_1 -C Key-1
ssh-keygen -t rsa -N "" -f key_2 -C Key-2
ssh-keygen -t rsa -N "" -f key_3 -C Key-3
ssh-keygen -t rsa -N "" -f key_4 -C Key-4
ls
cd ..
rm -r sshtest

cd ~/vipgit
mkdir viprepo
cd viprepo
git init
git remote add origin git@github.com:myusername/viprepo.git
echo "# Title" > README.md
git add README.md
git commit -m "New readme"
git push -u origin main

git branch newbranch
git checkout newbranch
git tag -a v0.1 -m "New branch stage 1"
echo "newbranch" > bewbranch.md
git branch branchthree
git checkout branchthree
git tag -a v0.3 -m "Third branch stage 3"
echo "branchthree" > branchthree.md
git checkout main
git tag -a v0.2 -m "Main branch stage 2"
echo "mainbranch" > mainbranch.md

git checkout branchthree
git add branchthree.md
git commit -m "Branch Three"
git push -u origin branchthree
git checkout newbranch
git add bewbranch.md
git commit -m "New Branch"
git push -u origin newbranch
git checkout main
git add mainbranch.md
git commit -m "Main Branch"
git push

cd ..
rm -rf viprepo
git clone -b newbranch git@github.com:myusername/viprepo.git
rm -r viprepo
git clone -b branchthree git@github.com:myusername/viprepo.git
rm -r viprepo
git clone -b main git@github.com:myusername/viprepo.git
rm -r viprepo

git clone git@github.com:myusername/viprepo.git
cd viprepo
ls
git checkout newbranch
ls
git checkout branchthree
ls

git status -sb

git checkout newbranch
git status -sb
rm *
echo "# Title" > README.md
git add README.md
git rm newbranch.md
git commit -m "Refresh"
git push

git checkout branchthree
git status -sb
rm *
echo "# Title" > README.md
git add README.md
git rm branchthree.md
git commit -m "Refresh"
git push

git checkout main
git merge origin/newbranch -m "Merged"
git merge origin/branchthree -m "Merged"
git push

git checkout main
git status -sb
rm *
git rm README.md
git rm mainbranch.md
git commit -m "Refresh"
git push

git chekcout main
git push origin -d newbranch    # Remote delete
git push origin -d branchthree
git branch -d newbranch         # Local delete
git branch -d branchthree
```

## Lesson 5: Kernel & Devices

```console
uname -r
ls /usr/lib/modules/

# Arch
pacman -S linux
kernel-install add $(uname -r) /usr/lib/modules/$(uname -r)/vmlinuz
kernel-install remove $(uname -r)

# Ubuntu
apt-get install --reinstall linux-image-generic
update-initramfs -u -k $(uname -r)

# RedHat
dnf reinstall kernel
dnf remove kernel-$(uname -r)
dnf install kernel-$(uname -r)

# OpenSUSE
zypper in kernel-default
zypper se -s 'kernel*'
zypper in kernel-default-VER.SI.ION.NUM
zypper rm kernel-default-VER.SI.ION.NUM

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
zypper install kernel-docs
cd /usr/share/doc/kernel-docs
ls

# All distros
cd /boot
ls
cd grub
grep linux grub.cfg

sysctl -a
ls /proc/sys
less /etc/sysctl.conf
ls /usr/lib/sysctl.d
ls /etc/sysctl.d
man sysctl.conf

cd /lib/modules/$(uname -r)
lsmod
modprobe cdrom
rmmod cdrom
lsmod
lsmod | grep alx
lsmod | grep cdrom
modinfo alx
modinfo cdrom
depmod
less /lib/modules/$(uname -r)/modules.dep
cd /etc/modprobe.d/
ls

ls /usr/lib/udev/rules.d
cd /dev
mknod -m 655 /dev/zmyusb c 254 1
ls
rm /dev/zmyusb
ls

udevadm monitor
# Plug/unplug a USB
# Ctrl + C
```

## Lesson 6: Networks

```console
netstat -l
netstat -rn

cat /etc/hostname
hostname
hostname -i

hostnamectl set-hostname $(hostname)
hostname
hostname temp    # Not persistent
hostname

cat /etc/hosts

cat /etc/systemd/timesyncd.conf
cat /etc/ntp.conf
ls /usr/bin/ntp*
ntpdc -c peers
timedatectl

netstat -l
netstat -rn

nmcli device status
nmtui
man nmcli
nmcli --help

route -n
ip r
ip -6 r
ip a
ifconfig
ip link
arp -a
lspci -v
nmcli device status

route -n
ip route add 10.5.0.0/16 via 192.168.1.100
ip route del 10.5.0.0/16 via 192.168.1.100
ip route add default via 192.168.1.21 dev enp2s0
ip route del default via 192.168.1.21 dev enp2s0
route -n

nmcli connection add type bond con-name Bond0 ifname bond0 bond.options "mode=active-backup,miimon=1000"
nmcli connection add type ethernet slave-type bond con-name Bond0-Port1 ifname enp3s0 master bond0
nmcli connection add type wifi ssid "Home WiFi" slave-type bond con-name Bond0-Port2 ifname wlp4s0 master bond0
nmcli connection up Bond0
nmtui

dig +trace inkisaverb.com
dig -t A inkisaverb.com
dig -t AAAA inkisaverb.com
dig -t MX inkisaverb.com
dig -t NS inkisaverb.com
dig -t TXT inkisaverb.com
dig -t CAA inkisaverb.com
dig -t CNAME inkisaverb.com
dig -t SOA inkisaverb.com

ping inkisaverb.com
ping 192.168.1.1
```

## Lesson 7: Disk & Partitioning

```console
# Filesystem
cd /
ls -i
ls -l
du -shx .
du -shx *
df -h

# Extended attributes
cd 
mkdir test
cd test
touch one two three
lsattr
chattr -Vf +aAdeisu one
chattr =isu two
chattr -e three
lsattr
rm one two
chattr =e *
rm one two
cd ..
rm -r test

# Partitioning
cd /mnt
mkdir one two three four

gdisk /dev/sdx # create at least 5 partitions
# o # new partition table GPT
# n # new partition
partprobe -s

mkfs.ext4 /dev/sdx1
mkfs.btrfs /dev/sdx2
mkfs.fat -F32 /dev/sdx3
mkntfs /dev/sdx4
mkswap /dev/sdx5
lsblk -f
mount UUID=sdx1-l0ng-n0mb3r /mnt/one
mount UUID=sdx2-l0ng-n0mb3r /mnt/two
mount UUID=sdx3-l0ng-n0mb3r /mnt/three
mount UUID=sdx4-l0ng-n0mb3r /mnt/four
swapon UUID=sdx5-l0ng-n0mb3r
cd /mnt/one
du -shx .
df -h
cd /mnt
umount /mnt/one
umount /mnt/two
umount /mnt/three
umount /mnt/four
swapoff /dev/sdx5

cd /mnt
rm -rf one two three four

# /etc/fstab
cat <<EOF >> ~/fstab.practice
UUID=s0me-l0ng-n0mb3r   /boot/efi      vfat    umask=0077 0 2 
UUID=s0me-l0ng-n0mb3r   /              ext4    defaults,noatime 0 1
/dev/sdx1               /home          btrfs   defaults,noatime,nofail 0 1
/dev/nvme0n1p1          /mnt/ssd       ext4    defaults,noatime,nofail,x-systemd.automount 0 0
/dev/nvme0n1p2          /mnt/hdd       ext4    defaults,noatime,nofail,x-systemd.automount.device-timeout 0 0
/var/swap.img           none           swap    sw 0 0
/dev/volgrp/thislvm     /thislvm       ext4    defaults 1 2
EOF

# LVM
## Partition Prep
gdisk /dev/sdx
# Create 5 partitions
# sdx3 & sdx4 at 1G is wise so pvmove takes less time
# n # new partition
# 8e00 for LVM

partprobe -s

## LVM Management
lsblk
pvcreate /dev/sdx1
pvcreate /dev/sdx2
pvcreate /dev/sdx3 /dev/sdx4 /dev/sdx5

vgcreate -s 16M volgrp /dev/sdx1 /dev/sdx2
vgextend volgrp /dev/sdx3 /dev/sdx4 /dev/sdx5

ls -l /dev/volgrp
lsblk

lvcreate -L 4G -n thislvm volgrp
ls -l /dev/volgrp
lsblk

lvremove /dev/volgrp/thislvm
lvcreate -L 3G -n thislvm volgrp

mkfs.ext4 /dev/volgrp/thislvm
mkdir /mnt/thislvm
mount /dev/volgrp/thislvm /mnt/thislvm
lsblk -f
umount /mnt/thislvm

lvresize -r -L 2G /dev/volgrp/thislvm
lvresize -r -L +500M /dev/volgrp/thislvm
lvresize -r -L 3G /dev/volgrp/thislvm

pvmove /dev/sdx3
vgreduce volgrp /dev/sdx3
pvremove /dev/sdx3
pvcreate /dev/sdx3
vgextend volgrp /dev/sdx3
pvmove /dev/sdx4

vgreduce volgrp /dev/sdx3 /dev/sdx4
pvremove /dev/sdx3 /dev/sdx4
pvcreate /dev/sdx3 /dev/sdx4
vgcreate -s 16M newgrp /dev/sdx3 /dev/sdx4

pvdisplay
pvdisplay /dev/sdx1
vgdisplay
vgdisplay /dev/volgrp
lvdisplay
lvdisplay /dev/volgrp/thislvm
vgs
vgs newgrp
vgs volgrp
vgdisplay
vgdisplay newgrp
vgdisplay volgrp
vgchange -an newgrp
vgchange -an volgrp
vgmerge volgrp newgrp
change -ay volgrp

lvremove /dev/volgrp/thislvm
vgremove volgrp
pvremove /dev/sdx1 /dev/sdx2 /dev/sdx3 /dev/sdx4 /dev/sdx5 --force --force

## LVM Snapshot Management
pvcreate /dev/sdx1 /dev/sdx2 /dev/sdx3 /dev/sdx4 /dev/sdx5
lvcreate -L 2G -n thislvm volgrp
mkfs.ext4 /dev/volgrp/thislvm
mount /dev/volgrp/thislvm /mnt/thislvm
lsblk -f
echo "I am one two" > /mnt/thislvm/echoed

lvcreate -s -n thesnap -l 128 /dev/volgrp/thislvm
mkdir /mnt/thesnap
mount -o ro /dev/volgrp/thesnap /mnt/thesnap
lsblk -f
cd /mnt/thesnap
ls

cd /mnt/thislvm
umount /mnt/thesnap
touch three four
lvconvert --mergesnapshot /dev/volgrp/thesnap
lsblk -f
umount /mnt/thislvm
lvchange -an /dev/volgrp/thislvm # active no
lvchange -ay /dev/volgrp/thislvm # active yes
lsblk -f
mount /dev/volgrp/thislvm /mnt/thislvm
cd /mnt/thislvm
ls
cd /mnt

umount /mnt/thesnap
lsblk -f
lvremove /dev/volgrp/thesnap
lvremove /dev/volgrp/thislvm
vgremove volgrp
pvremove /dev/sdx1 /dev/sdx2 /dev/sdx3 /dev/sdx4 /dev/sdx5 --force --force

# Swap
swapoff /var/swap.img
touch /var/swap.img
chmod 600 /var/swap.img
dd status=progress if=/dev/zero of=/var/swap.img bs=2M count=1024
mkswap /var/swap.img
swapon /var/swap.img

# Disk Monitoring
iostat
iostat -mx
iotop
iotop -o
bonnie++ -u 0 -n 0 -f -b -r 150 -d /tmp/

# NBD
## On server
modprobe nbd
lsmod | grep nbd
mv /etc/nbd-server/config /etc/nbd-server/config.bak
vim /etc/nbd-server/config

mv /etc/nbd-server/config /etc/nbd-server/config.bak
mkdir /export
dd if=/dev/urandom of=/export/foo bs=1M count=128 status=progress
dd if=/dev/urandom of=/export/export1 bs=1M count=128 status=progress
dd if=/dev/urandom of=/export/otherexport bs=1M count=128 status=progress
chown /export/foo
chown /export/export1
chown /export/otherexport
mkfs.ext4 /export/foo
mkfs.ext4 /export/export1
mkfs.ext4 /export/otherexport

mv /etc/nbd-server/config /etc/nbd-server/config.bak
cat <<EOF > /etc/nbd-server/config
[generic]
user = nbd 
group = nbd
includedir = /etc/nbd-server/conf.d
EOF

mkdir -p /etc/nbd-server/conf.d
cat <<EOF > /etc/nbd-server/conf.d/foo.conf
[foo]
exportname = /export/foo
EOF
cat <<EOF > /etc/nbd-server/conf.d/e1.conf
[export1]
exportname = /export/export1
EOF
cat <<EOF >> /etc/nbd-server/config
[otherexport]
exportname = /export/otherexport
EOF
nbd-server
ip a

## On client
modprobe nbd
lsmod | grep nbd
nbd-client -N foo 192.168.0.9 10809 /dev/nbd0
nbd-client -N export1 192.168.0.9 10809 /dev/nbd1
nbd-client -N otherexport 192.168.0.9 10809 /dev/nbd2
lsblk -f

mkdir /mnt/nbd0 /mnt/nbd1 /mnt/nbd2
mount /dev/nbd0 /mnt/nbd0
mount /dev/nbd1 /mnt/nbd1
mount /dev/nbd2 /mnt/nbd2
cd /mnt/nbd0

umount /mnt/nbd0
umount /mnt/nbd1
umount /mnt/nbd2
nbd-client -d /dev/nbd0
nbd-client -d /dev/nbd1
nbd-client -d /dev/nbd2

modprobe -r nbd
```

## Lesson 8: Packages

```console
# Arch: pacman
pacman -Ss findword findotherword
pacman -Qs findinstalledpackage
pacman -Sy archlinux-keyring
pacman -Syy
pacman -Syyu
pacman -S cowsay
pacman -Syy cowsay
pacman -Sw cowsay
ls /var/cache/pacman/pkg/cowsay*
pacman -U /var/cache/pacman/pkg/cowsay-VERSION.pkg.tar.zst
ls /var/cache/pacman/pkg/
pacman -Scc
ls /var/cache/pacman/pkg/
pacman -Rsc
pacman -Qe
pacman -Ql package-name
pacman -Qii package-name
pacman -Qo /path/to/some/file
pactree package-name
pactree -r package-name

# Arch: yay
yay -Syyu
yay -Ps
yay -Yc
yay -Gp aur-package-name # Output PKGBUILD for that package
yay -S aur-package-name
yay -R aur-package-name

# Arch: makepkg
pacman -Sw package-name
cd /var/cache/pacman/pkg/
ls
cd
mkdir pacmanw
cd pacmanw
ls /var/cache/pacman/pkg/
cp /var/cache/pacman/pkg/package_name-version.pkg.tar.zst .
tar xf package_name-version.pkg.tar.zst
ls
# assuming output is "opt"
cd opt
ls
cd package_name
cd ~/pacmanw
makepkg -i
makepkg -c
cd
rm -rf pacmanw

# Debian: dpkg
dpkg -s dpkg | grep -i Version
dpkg -V
dpkg -V package-name
dpkg -l
dpkg -L wget
dpkg -s package-name
dpkg -I some_package-name_amd64.deb
dpkg -c some_package-name_amd64.deb
cd /etc
ls
dpkg -S /etc/openldap/slapd.conf
dpkg -r package-name
dpkg -P package-name

# Debian: apt-get
apt-file update
apt-get install package-name
apt-cache search package-name
apt list --installed
apt list --upgradeable
apt list --all-versions
apt-get update
apt-get upgrade -y
apt-get install -y package-name
apt-get remove -y package-name
apt-get --purge -y remove package-name
apt-get dist-upgrade
apt-get autoremove
apt-get clean

# RedHat: rpm
rpm --rebuilddb
rpm -qa
rpm -qf /bin/mv
rpm -qi gedit
rpm -ql gedit
rpm -Va
rpm -e package name

# RedHat: dnf
dnf --disablerepo repo-name
dnf --enablerepo repo-name
dnf search findword
dnf list installed
dnf list available
dnf list updates
dnf info git
dnf install --downloadonly git
find /var/cache -iname "*git*" # use this in the next command
dnf localinstall /var/cache/dnf/appstream-l07GNum84/packages/git-2.43.0-1.el9.x86_64.rpm
dnf remove git
dnf install git
dnf groupinstall package-group
dnf grouplist
dnf groupinfo package-group
cd /etc
ls
dnf provides /etc/crontab
dnf update
dnf update git
dnf list "dnf-plugin*"
dnf repolist
dnf shell
dnf history
dnf clean packages
dnf clean metadata
dnf clean all

# OpenSUSE: zypper
zypper list-updates
zypper repos
zypper search findword
zypper info cowsay
zypper install cowsay
zypper search --provides /bin/cowsay
zypper remove cowsay
zypper install cowsay --non-interactive
zypper update
zypper update --non-interactive
zypper shell
zypper addrepo http://example.com/path/to/repo some-alias-repo-name
zypper removerepo some-alias-repo-name
zypper clean --all
```

## Lesson 9: PAM & Cloud (SSH, LDAP, Docker, Mail)

```console
# Client & Server
ip a

# PAM
cd /etc/pam.d
ls
grep pam_securetty.so *
vim /etc/securetty # Add lines with IP address of Machine-2

# SSH
## Client
apt-get install openssh-client
mkdir ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh

ssh-keygen -t rsa -N "" -f id_rsa -C ID_RSA
cat id_rsa.pub # Copy to clipboard

## Server
apt-get install openssh-server
systemctl status ssh
systemctl start ssh
mkdir /root/.ssh
chmod 700 /root/.ssh
cd /root/.ssh
echo 'ssh-rsa THAT_LONG_SSH_KEY= user@machine' > authorized_keys

vim /etc/ssh/sshd_config
  # Uncomment & set:
  # PermitRootLogin prohibit-password
  # PubkeyAuthentication yes
  # PasswordAuthentication no

rm /etc/ssh/ssh_host_*_key*
ssh-keygen -A
systemctl start ssh

cd
touch /root/m2
mkdir /root/m2.d
touch /m2.d/m2.in

# Client
cd
touch m1
mkdir m1.d
touch m1.d/m1.in

ssh root@192.168.77.X
ls
exit

scp ~/m1 root@192.168.77.X:~/
scp root@192.168.77.X:~/m2 ~/
ls
scp -r ~/m1.d root@192.168.77.X:~/
scp -r root@192.168.77.X:~/m2.d ~/
ls
ssh root@192.168.77.X
vim m1 # Make some changes

# LDAP
## Server
apt install slapd ldap-utils
dpkg-reconfigure slapd
# No
# Any domain, or the pre-defined domain in /etc/hosts
# Organization name
# LDAP Admin password twice (same as during install)
# Database: MDB
# Remove databse when slapd is purged? Yes for practice (No for production)
# Move old databse? Yes
# LDAPv2 protocol? No (Use current LDAP protocol)

vim /etc/ldap/ldap.conf    # Arch is: /etc/openldap/ldap.conf
# Set/uncomment:
  # BASE    dc=localhost,dc=localdomain
  # URI     ldap://localhost:389

systemctl status slapd
systemctl start slapd
systemctl status slapd
ip a

## Client
apt install ldap-utils

vim /etc/ldap/ldap.conf
# Below uses the IP address from `ip a` on the server
# Set/uncomment:
  # BASE    dc=somedomain,dc=tld
  # URI     ldap://192.168.77.X

# SSSD
apt update
apt install sssd-ldap

vim /etc/sssd/conf.d/00-sssd.conf
vim /etc/pam.d/common-session.conf

systemctl start sssd
systemctl start slapd
systemctl status sssd

# Docker
## Arch
pacman -Syy docker docker-compose

## Debian
apt install docker docker-compose

## OpenSUSE
zypper install docker docker-compose docker-compose-switch

## All distros
systemctl enable docker
systemctl start docker
systemctl status docker

docker run -it ubuntu
docker run hello-world

docker pull centos
docker run -d -t --name bagged centos
docker ps
docker exec -it bagged bash
## Now in the Docker shell
uname
whoami
lsb_release -d
lsmem
lscpu
ls
lsblk
exit

docker ps
docker stop [ helloworld CONTAINER ID | NAMES ]
docker ps
docker stop bagged
docker ps

## Docker Compose
mkdir .docker
cd .docker
mkdir busybox

cat <<EOF > busybox/compose.yaml
services:
  foo:
    image: busybox
    environment:
      - COMPOSE_PROJECT_NAME
    command: echo "I'm running ${COMPOSE_PROJECT_NAME}"
EOF

ls *
cd ../busybox
docker compose up -d
docker ps # No listing
docker compose down

docker images
docker rmi -f [ helloworld IMAGE ID ]

systemctl stop docker
systemctl stop docker.socket
systemctl disable docker
```

## Lesson 10: Firewall

```console
man firewall-cmd
firewall-cmd --help

systemctl start firewalld
systemctl status firewalld

firewall-cmd --state
firewall-cmd --get-zones
firewall-cmd --get-active-zones
firewall-cmd --get-default-zone

firewall-cmd --set-default-zone=dmz
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=work
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=trusted
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --get-default-zone

firewall-cmd --get-active-zones
nmcli device status
# Note the interface outputs, these are used instead of `enp2s0`

firewall-cmd --state
firewall-cmd --reload
firewall-cmd --zone=dmz --list-all
firewall-cmd --zone=work --list-all
firewall-cmd --zone=public --list-all
firewall-cmd --zone=trusted --list-all

firewall-cmd --zone=internal --change-interface=enp2s0
firewall-cmd --zone=internal --change-interface=enp2s0 --permanent
firewall-cmd --get-zone-of-interface=enp2s0

firewall-cmd --zone=trusted --add-source=192.168.0.0/24
firewall-cmd --zone=trusted --list-sources
firewall-cmd --zone=trusted --add-source=192.168.1.0/24 --permanent
firewall-cmd --zone=trusted --list-sources --permanent
firewall-cmd --zone=trusted --list-sources

firewall-cmd --zone=trusted --remove-source=192.168.1.0/24 --permanent
firewall-cmd --zone=trusted --list-sources --permanent
firewall-cmd --zone=trusted --remove-source=192.168.0.0/24
firewall-cmd --zone=trusted --list-sources

firewall-cmd --zone=public --list-services
firewall-cmd --zone=external --add-service=ssh --permanent
firewall-cmd --zone=public --list-services
firewall-cmd --zone=external --remove-service=ssh --permanent
firewall-cmd --zone=public --list-services

firewall-cmd --zone=work --list-ports
firewall-cmd --zone=work --add-port=21/tcp
firewall-cmd --zone=work --list-ports
firewall-cmd --zone=work --remove-port=21/tcp
firewall-cmd --zone=work --list-ports

firewall-cmd --zone=work --list-forward
firewall-cmd --zone=work --add-forward-port=port=80:proto=tcp:toport=8080
firewall-cmd --zone=work --list-forward
firewall-cmd --zone=work --remove-forward-port=port=80:proto=tcp:toport=8080
firewall-cmd --zone=work --list-forward
```

## Lesson 11: Security Modules

```console
# SELinux
ls -l /etc/selinux/config
ls -l /etc/sysconfig/selinux

grep SELINUX= /etc/selinux/config
grep SELINUX= /etc/sysconfig/selinux
grep selinux= /boot/grub/grub.cfg

chcat -L
cd /etc/selinux
find . -name setrans.conf
cat /etc/selinux/targeted/setrans.conf
cd /etc/selinux/targeted/contexts
ls
cd /etc/selinux/targeted/contexts/users
ls
cd /etc/selinux/targeted/contexts/files
ls

sestatus
getenforce

ls /etc/selinux/ | wc -l
ls -l /etc/selinux/
setenforce Permissive
getenforce
setenforce Enforcing
getenforce

ps auZ
ps axZ
ls -Z
ls -aZ

mkdir /srv/lv
cd /srv/lv
touch onefile otherfile
ls -Z
chcon -t etc_t onefile
ls -Z
chcon --reference=onefile otherfile
ls -Z
touch levelfile
chcon -l s12 levelfile
ls -Z
chcon -t s5:c14 levelfile
ls -Z
chcat -- +c5 levelfile
ls -Z
chcat -- +s7,-c14 levelfile
ls -Z
chcat -l -- +s15 someuser
chcat -L
chcat -- +SystemLow levelfile
ls -Z
chcat -- +SystemHigh,-SystemLow levelfile
ls -Z

cd /
ls -Z
ls -lZ
ls -aZ
ls -lZ /home/
ls -lZ /tmp/
ls -lZ /home/ /tmp/

cd /tmp/
touch tmpfile
ls -Z

cd
touch homefile
ls -Z homefile
mv /tmp/tmpfile .
ls -Z
restorecon -Rv tmpfile
ls -Z

dnf install seinfo
seinfo -t # choose a type for below (to replace httpd_tmp_t), not all types will work
mkdir /srv/vm
ls -Z /srv
semanage fcontext -a -t httpd_tmp_t /srv/vm
ls -Z /srv
restorecon -RFv /srv/vm
ls -Z /srv
touch /srv/vm/somefile
semanage fcontext -a -t httpd_tmp_t /srv/vm/somefile
ls -Z /srv/vm
restorecon /srv/vm/somefile
ls -Z /srv/vm

getsebool -a
getsebool ftpd_anon_write

setsebool ftpd_anon_write on
semanage boolean -l | grep ftpd_anon_write

setsebool -P ftpd_anon_write on
semanage boolean -l | grep ftpd_anon_write

ls -l /var/log/audit/audit.log
ls -l /var/log/messages
dnf install setroubleshoot-server
ls -l /var/log/audit/audit.log
ls -l /var/log/messages
sealert

echo 'Wrong place' > /root/rootfile
mv /root/rootfile /srv/www/html/
wget -O - localhost/rootfile
tail /var/log/messages

# AppArmor
# Arch
pacman -Syy apparmor

# Debian
apt install apparmor-profiles
apt install apparmor-utils
dpkg -L apparmor-utils | grep bin

# OpenSUSE
rpm -qil apparmor-utils | grep bin
zypper install apparmor-utils

aa-enabled
aa-status

apparmor_status
systemctl status apparmor
systemctl stop apparmor
apparmor_status
systemctl start apparmor
systemctl status apparmor
apparmor_status

ps aux

ls /etc/apparmor.d | wc -l
ls -l /etc/apparmor.d

cd /etc/apparmor.d
ls -l
ls /usr/sbin/*complain | wc -l
ls -l /usr/sbin/*complain
ls /usr/bin/aa-* | wc -l
ls -l /usr/bin/aa-*

aa-complain git
aa-enforce git
aa-complain git

man apparmor.d
```

## Lesson 12: Backup & System Rescue

```console
# dd
dd status=progress if=/dev/sda of=/dev/sdx

# tar
mkdir -p /mnt/backup
mount /dev/sdx1 /mnt/backup
tar Jcvf /mnt/backup/var.bak.txz /var
tar Jcvf /mnt/backup/srv.bak.txz /srv

# rsync
## Remote
systemctl start rsync
systemctl start ssh
ip a

## Source
cd
mkdir syncme.d
cd syncme.d
touch alpha.a beta.a gamma.a delta.a epsilon.a alpha.f beta.f gamma.f delta.f epsilon.f
cd ..
rsync -avze ssh syncme.d someuser@192.168.77.X:/home/someuser/

## Remote
ls
cd syncme.d
ls -l
cat alpha.a

## Source
echo "changed" > syncme.d/alpha.a
chmod go-r *.a
chmod ug+x *.f
rsync -rvze ssh syncme.d someuser@192.168.77.X:/home/someuser/

## Remote
ls -l
cat alpha.a

## Source
rsync -avze ssh syncme.d someuser@192.168.77.X:/home/someuser/

## Remote
ls -l
mkdir ~/backups

## Source
rsync -avze ssh /var someuser@192.168.77.X:/home/someuser/
rsync -avze ssh /srv someuser@192.168.77.X:/home/someuser/

cat <<EOF > /etc/cron.d/backup
0 1 * * 2 root /usr/bin/rsync -aze ssh /srv someuser@192.168.77.X:/home/someuser/backups/2
0 1 * * 3 root /usr/bin/rsync -aze ssh /srv someuser@192.168.77.X:/home/someuser/backups/3
0 1 * * 4 root /usr/bin/rsync -aze ssh /srv someuser@192.168.77.X:/home/someuser/backups/4
0 1 * * 5 root /usr/bin/rsync -aze ssh /srv someuser@192.168.77.X:/home/someuser/backups/5
EOF
chmod 0644 /etc/cron.d/backup

## System Rescue
# Add 'emergency' or 'rescue' to the end of the 'linux' line in grub.cfg

## Boot Pluggable
lsblk -f
df -h

fsck /dev/sdb1

mkdir /mnt/fixsys
mount /dev/sdb1 /mnt/fixsys
chroot /mnt/fixsys

cat /etc/fstab
lsblk -f
update-grub

exit
```

## Final Tough List
*For typing into a text editor, not the terminal!*

### Lesson 1: Boot & System Init

```console
cat <<EOF > /etc/systemd/system/ddran.service
[Unit]
Description=dd running nothing

[Service]
ExecStart=/usr/bin/dd if=/dev/urandom of=/dev/null

[Install]
WantedBy=multi-user.target
EOF

shutdown.target
-
sysinit.target
rescue.target
--
sockets.target
basic.target
network.target
multi-user.target
--
graphical.target
-
reboot.target
-
emergency.target
```

### Lesson 2: Procesesses & Monitoring

```console
ps -C gedit -o cmd,pid,uid,ruid,euid,suid,user,ruser,euser,suser
ulimit -H -u 256512
umask 0022

/etc/cron.d/somejob
0 1 * * 2 user some command
chmod 0644 /etc/cron.d/somejob
```

### Lesson 3: Users & Groups

```console
alias vovo="echo hello"
unalias vovo
useradd pinky -m -k /etc/skel
usermod pinky -aG sudo
```

### Lesson 4: Git & Revision Control

```console

git remote add origin git@github.com:myusername/viprepo.git
git push -u origin main
git merge origin/newbranch -m "Merged"
git push origin -d newbranch    # Remote delete
git branch -d newbranch         # Local delete
```

### Lesson 5: Kernel & Devices

```console
pacman -S linux                                                      # newest version
kernel-install add $(uname -r) /usr/lib/modules/$(uname -r)/vmlinuz  # current version
kernel-install remove $(uname -r)

apt-get install --reinstall linux-image-generic   # newest version
update-initramfs -u -k $(uname -r)                # current version

sudo -i
dnf reinstall kernel           # newest version
dnf install kernel-$(uname -r) # current version
dnf remove kernel-$(uname -r)

zypper in kernel-default                  # newest version
zypper se -s 'kernel*'
zypper in kernel-default-VER.SI.ION.NUM   # current version
zypper rm kernel-default-VER.SI.ION.NUM

/etc/sysctl.conf
/proc/cmd
mknod -m 655 /dev/zmyusb c 254 1
dmidecode -t
```

### Lesson 6: Networks

```console
ip route add 10.5.0.0/16 via 192.168.1.100
ip route del 10.5.0.0/16 via 192.168.1.100
ip route add default via 192.168.1.21 dev enp2s0
ip route del default via 192.168.1.21 dev enp2s0

nmcli connection add type bond con-name Bond0 ifname bond0 bond.options "mode=active-backup,miimon=1000"
nmcli connection add type ethernet slave-type bond con-name Bond0-Port1 ifname enp3s0 master bond0
nmcli connection add type wifi ssid "Home WiFi" slave-type bond con-name Bond0-Port2 ifname wlp4s0 master bond0
nmcli connection up Bond0
nmcli connection down Bond0
```

### Lesson 7: Disk & Partitioning

```console
/etc/fstab
UUID=s0me-l0ng-n0mb3r   /boot/efi      vfat    umask=0077 0 2 
UUID=s0me-l0ng-n0mb3r   /              ext4    defaults,noatime 0 1
/dev/sdx1               /home          btrfs   defaults,noatime,nofail 0 1
/var/swap.img           none           swap    sw 0 0
/dev/volgrp/thislvm     /thislvm       ext4    defaults 1 2

pvcreate /dev/sdx1 /dev/sdx2 /dev/sdx3 /dev/sdx4
vgcreate -s 16M volgrp /dev/sdx1
vgextend volgrp /dev/sdx2 /dev/sdx3 /dev/sdx4
lvcreate -L 400G -n thislvm volgrp

pvmove /dev/sdx3
vgreduce volgrp /dev/sdx3
pvremove /dev/sdx3
lvresize -f -L 2g

lvcreate -s -n thesnap -l 128 /dev/volgrp/thislvm
lvconvert --mergesnapshot /dev/volgrp/thesnap

lvchange -an /dev/volgrp/thislvm
lvchange -ay /dev/volgrp/thislvm

/etc/nbd-server/config
[generic]
user = nbd 
group = nbd
[foo]
exportname = /export/foo

nbd-client -N foo 192.168.0.9 10809 /dev/nbd0
```

### Lesson 8: Packages

```console
pacman -Ss findword findotherword
pacman -Qs findinstalledpackage
pacman -Sy archlinux-keyring
pacman -Syyu
pacman -S cowsay
pacman -R cowsay
pacman -Scc

apt-get update
apt-get upgrade -y
apt-get install cowsay
apt-get remove cowsay
apt-get autoremove
apt-get clean

dnf search findword
dnf install git
dnf remove git
dnf clean all

zypper search findword
zypper install cowsay
zypper clean --all
```

### Lesson 9: PAM & Cloud (SSH, LDAP, Docker, Mail)

```console
ssh-keygen -t rsa -N "" -f key_1 -C Key-1
ssh root@192.168.77.X
scp ~/m1 root@192.168.77.X:~/
scp root@192.168.77.X:~/m2 ~/

dpkg-reconfigure slapd
/etc/ldap/ldap.conf
  # BASE    dc=localhost,dc=localdomain
  # URI     ldap://localhost:389
  # BASE    dc=somedomain,dc=tld
  # URI     ldap://192.168.77.X
  
docker compose up -d
docker compose down
docker pull centos
docker run -d -t --name bagged centos
docker exec -it bagged bash
docker ps
docker stop bagged
```

### Lesson 10: Firewall

```console
firewall-cmd --zone=dmz --list-all
firewall-cmd --set-default-zone=public
firewall-cmd --get-default-zone
firewall-cmd --state
```

### Lesson 11: Security Modules

```console
sestatus
getenforce

/etc/selinux/
setenforce Permissive
getenforce
setenforce Enforcing
getenforce
ls -Z

aa-enabled
aa-status

apparmor_status
systemctl status apparmor
```

### Lesson 12: Backup & System Rescue

```console
tar Jcvf var.txz /var
rsync -avze ssh syncme.d root@192.168.77.X:/root/

rescue
emergency
chroot /mnt/fixsys
fsck /dev/sdb1
```
