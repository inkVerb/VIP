# Linux 601
## Lesson 6: Networks

### [VIP/Cheat-Sheets: File Size, Binary, Hexadecimal](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Sizes-Binary-Hex.md)
### [VIP/Cheat-Sheets: Networking](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Networking.md)

___

# The Chalk
## Network Services
Services on the network can include:

- Webservers like Apache or Nginx
- Mail like Postfix, Dovecot, and Exim
- User services like LDAP or WebDAV
- Served databases that accept network access like MySQL, MariaDB, or MongoDB
- DNS nameservers like Bind
- NBD to use block devices (disks) over the network
- FTP, SSH, SIP, and much more

Knowing how to manage these is each a separate topic unto itself

All of these require that the network be operating, which this lesson addresses

Useful network commands:

- Host machine services listening on the network
  - :$ `netstat -l`
- **Netowrks**, **gateways**, and **NICs**:
  - :$ `netstat -rn` = `route -n`

This shows how each service listens on the network:

1. on IPs and ports (both local host machine and remote)
2. from which local socket (host machine)

Your host machine is found on the network through its IP address, which actually exists as a binary number, best understood in hexadecimal numerals

## Binary & Hexadecimal
For a thorough look at binary oclets and hexadecimal numbers, see [VIP/Cheat-Sheets: File Size, Binary, Hexadecimal](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Sizes-Binary-Hex.md)

Everything after this will presume knowledge of binary oclets and corresponding hexadecimal pairs

## Networking Terms
To understand the the behavior and structure of networks and IP addresses, see [VIP/Cheat-Sheets: Networking](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Networking.md)

Everything after this will presume knowledge and use of networks, network devices, and IP address structure

## Host
### Basics
- The host name is recorded in `/etc/hostname`
- Extended host IP information is in `/etc/hosts`
- `hostname` (machine name)
  - `hostname -i` set host IP address from `/etc/hosts` (not DHCP)
- :# `hostname inky` sets the host name to `inky`
- :# `hostnamectl set-hostname inky` persistently set the host name to `inky`
  - `hostnamectl --help`

### Basic Host Config

| **/etc/hosts** : (any second host is an alias)

```
127.0.0.1 localhost
127.0.1.1 host_name

# More extensive
# 127.0.0.1 localhost.localdomain localhost
# 127.0.1.1 host_domain.com host_name alias_served_also.com

# Network addresses
192.168.1.1 netserver.com aliasserver.com
192.168.1.2 hp-printer
192.168.1.3 barney workschedule
192.168.1.4 jim jimbbs
192.168.1.10 test testmail

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

### Host-Related Files
- `/etc/hosts`
- `/etc/hostname`
- `/etc/hosts.conf`
- `/etc/hosts.allow` (optional)
- `/etc/hosts.deny` (optional)

## Network Time Protocol (NTP)
### Structure
- Network time is divided into **strata**
  - strata `0` is a special clock: radio, atomic clock, shortwave GMT, etc
  - strata `1` NTP server connected directloy to `0` (via cable, etc)
  - strata `2` NTP server referencing strata `1`
  - strata `3` NTP server referencing strata `2`
- NTP server types
  - server: provides time to clients
  - client: gets time from server or peer
  - peer: synchronizes time between other peers (peers prioritized over defined servers)

### NTP Daemon (Service)
- :# `systemctl start ntpd` start your NTP daemon
- The NTP daemon helps with time syncronization, which is helpful, but not security related
- Running the NTP daemon is [considered wise, but optional](https://unix.stackexchange.com/questions/386914)

### Tools
#### `ntp`
- *Different NTP tools conflict; choose one*
- `ntp*` primary time tool kit
  - `/etc/ntp.conf`
  - `ls /usr/bin/ntp*`
- `chrony` cross-environment, including cross-network and VM (optional package)
  - `/etc/chrony.conf`
- `systemd-timesyncd` - `ntp` client included in `systemd` package
  - `/etc/systemd/timesyncd.conf`

#### Local Query
- *The NTP daemon must be running for some queries to work*
- :$ `ntpdc` open the NTP prompt
  - :$ `ntpdc -c [some NTP command]` run a single NTP command without opening the NTP prompt
  - :$ `ntpdc -c peers` show time difference between local and authoritative servers
- :$ `timedatectl` part of `systemd` and `systemd-timesyncd`

### Configs
#### Pool
- The NTP Pool Project relieves the query load on NTP servers by cycling through allowed IP addresses to make inquiries
- The pool is defined in the config files

| **/etc/ntp.conf** : (standard)

```
driftfile /var/lib/ntp/ntp.drift

server 0.pool.ntp.org
server 1.pool.ntp.org
server 2.pool.ntp.org
server 3.pool.ntp.org
```

| **/etc/ntp.conf** : (Arch Linux)

```
driftfile /var/lib/ntp/ntp.drift

server 0.arch.pool.ntp.org
server 1.arch.pool.ntp.org
server 2.arch.pool.ntp.org
server 3.arch.pool.ntp.org

restrict default kod limited nomodify nopeer noquery notrap
restrict 127.0.0.1
restrict ::1
```

#### NTPD Server Configs

| **/etc/ntp.conf** : (access control)

```
# Default prevent queries 
restrict default nopeer nomidify notrap noquery

# Allow specific subnet
restrict X.X.X.0 mask 255.255.255.0 nopeer nomodify notrap

# Allow specific host
restrict X.X.X.X nopeer nomodify notrap noquery

# Unrestrict localhost
restrict 127.0.0.1
```

| **/etc/ntp.conf** : (peer configuration)

```
peer X.X.X.X
peer 192.168.0.1
```

| **/etc/ntp.conf** : (self time source)

```
server A.B.C.0
fudge A.B.C.0 stratum 10
```

  - Note `A.B.C.0` is a consistent example IP address

## Network Devices
### Names
- List network devices and `dev` names
  - :$ `nmcli device status`
- Common names:
  - `eno1` (EtherNet with firmware/BIOS onboard index `1`)
  - `ens1` (EtherNet with firmware/BIOS hotplug slot `1`)
  - `enp1s0` (EtherNet PCI bus `1` ISDN `S` interface)
  - `en4ccc6ae26334` (EtherNet with MAC address)
  - `eth0` (legacy wired ethernet)
  - `wlan0` (legacy wireless LAN)
  - `wlp2` (Wireless LAN PCI bus `2`)
  - `wlp2s0` (Wireless LAN ISDN `S` interface)
- Device-IP maps: (use `| grep something` to narrow results)
  - `lspci` PCI devices
  - `ip link` connections (AKA `ip link show`)
  - `ip r` connections (AKA `ip link rout`)
  - `ip a` address of host (IP address for this machine)
  - `ifconfig` (network devices)
  - `arp -a` router

### Configs (old)
- Configs like these are from the days when normal networks were all hard-wired, not using WiFi, USB, or DHCP in networks
- Today, a machine has many network divices with many networks for each to choose from; configs get complicated
- It is generally better to use `networkmanager` commands
  - `nmtui`
  - `nmcli`

#### Network Configs
- Red Hat
  - `/etc/sysconfig/network`
  - `/etc/sysconfig/network-scripts/ifcfg-ethX`
  - `/etc/sysconfig/network-scripts/ifcfg-ethX:Y`
  - `/etc/sysconfig/network-scripts/rout-ethX`
- Debian
  - `/etc/network/interfaces`
- SUSE
  - `/etc/sysconfig/network/`...
- Arch
  - `/etc/NetworkManager/`...

### Network Manager
- Keep Network Manager mostly the same across systems
- Plugins:
  - `ifupdown`: `/etc/network/interfaces`
  - `ifcfg-rh`: `/etc/sysconfig/network-scripts`
  - `ifcfg-suse`: simple compatability with SUSE
  - `keyfile`: generic replacesment for some particular configs
  - Plugins are in a comma-separated list in:
    - in `/etc/NetworkManager/NetworkManager.conf`
    - under `[main]`
    - for `plugins=`
    - eg: `plugins=ifupdown,keyfile`

#### Network Manager Interfaces
- `nmtui` - Text User Interface
- `nmcli` - Command Line Interface
- Both of these access the same settings as the *WiFi* and *Wired* network settings in a desktop GUI like GNOME or Xfce

### Routing
#### `ip route` Command
- The `ip route` command sets the **next hop** when looking for a given IP address
  - `default` is for all "to" addresses
  - `192.168.1.1` is most likely the **gateway** for the current **subnet**

```
ip route add  192.168.77.3  via 192.168.1.1  dev     enp2s0
ip route add  default       via 192.168.1.1  dev     enp2s0
ip route add  To-Address    via Next-hop     For-NIC NIC-device-name
```

- Knowing machine information, such as NIC device names (eg `enp2s0`), is important for using the `ip route` command
- Get simple **route** tables for your machine :$
  - `ip r` = `ip route` = `ip route show`
  - `ip -6 r` for IPv6 routs
- Get NIC & **gateway** information :$
  - `route -n` = `netstat -rn`
  - `ip a` = `ip addr` = `address show`
  - `ifconfig -a` (elaborate)
  - `nmcli device status` (NIC: device, name, type, state, connection)

#### Reading `route -n` Output
- :$ `route -n`
  - Output:
```
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.1.1     0.0.0.0         UG    100    0        0 enp2s0
0.0.0.0         192.168.1.1     0.0.0.0         UG    600    0        0 wlp1s0
192.168.1.0     0.0.0.0         255.255.255.0   U     100    0        0 enp2s0
192.168.1.0     0.0.0.0         255.255.255.0   U     600    0        0 wlp1s0
```
- `0.0.0.0` is basically a placeholder meaning:
  - "unknown self" or "anything" or "nothing" or "Not-Applicable"
  - `0.0.0.0` was how your machine first identified itself to get its IP address from the DHCP server
- This table means:
  - Both the Ethernet NIC (`enp2s0`) and WiFi NIC (`wlp1s0`) are...
  - Both connected to the same **router** (`192.168.1.1`)
  - For the same network (`192.168.1.0`) with mask `255.255.255.0`
- Note each NIC has:
  - Network with mask (`192.168.1.0` with `255.255.255.0`)
  - Gateway (`192.168.1.1`) for the next stop on the way to the worlwdide Internet

#### Set Default Gateway Route
*`default` **gateway** IP address when router not known*

- Know your original **gateway** from `route -n`
- Manually set the default **gateway** to `192.168.1.21` :#
  - `ip route add default via 192.168.1.21 dev enp2s0`
    - ...where `enp2s0` is a NIC on your machine listed in:
      - `nmcli device status`
      - Also visible in all of these:
        - `ifconfig`
        - `route -n`
        - `ip link` (et al)
        - `arp -a`
    - `enp2s0` could also be:
      - `wlp2s0`
      - `enp3s0`
- Restore to the normal default **gateway** `192.168.1.1` :#
  - `ip route add default via 192.168.1.1 dev enp2s0`

#### Static Routs
*Usually with multiple routers*

- Add a non-persistent route :#
  - `ip route add 10.5.0.0/16 via 192.168.1.100`
- Delete a non-persistent route :#
  - `ip route del 10.5.0.0/16 via 192.168.1.100`
- Persistent routes:
  - Flavored distros must edit their config files and add them manually
    - Debian: `/etc/network/interfaces`
    - Red Hat: `/etc/sysconfig/network-scripts/rout-ethX`
    - SUSE: `/etc/sysconfig/network/ifroute-eth0`
  - Arch uses a service, then adds scripts: [read more](https://wiki.archlinux.org/title/NetworkManager#Network_services_with_NetworkManager_dispatcher)
    - `systemctl enable NetworkManager-dispatcher.service`
    - `systemctl start NetworkManager-dispatcher.service`
    - Create a BASH script in `/etc/NetworkManager/dispatcher.d/` with any name like *`10-script.sh`*
    - Own :# `chown root:root /etc/NetworkManager/dispatcher.d/10-script.sh`
    - Executable :# `chmod ug+x /etc/NetworkManager/dispatcher.d/10-script.sh`
    - Then, the script (eg *`10-script.sh`*) starts with `#!/bin/bash`, then uses standard `nmcli` commands
    
## Bonding
*Multiple NICs (network cards) connect the same host machine to the same network/Internet router*

- *Eg: Your PC's WiFi card and ethernet jack both connect to the same router*
- Uses a kernel module
- Provides fail-safes and redundancy
- Enhances robustness, throughput, and performance
- Methods of management:
  - Directly edit `/sys/` pseudofiles (non-persistent)
  - `iprout2` tools, including the `ip` command (non-persistent)
  - NetworkManager (`nmtui` & `nmcli`; persistent)

### Create Bonding Network Interface
- `nmcli device status` (find network device names)
  - Say this includes devices called `enp3s0` and `enp4s0`, which we use
- Create an interface bond called `Bond0` with device name `bond0`
```
nmcli connection add type bond con-name Bond0 ifname bond0 bond.options "mode=active-backup,miimon=1000"
nmcli connection add type ethernet slave-type bond con-name Bond0-Port1 ifname enp3s0 master bond0
nmcli connection add type wifi ssid "Home WiFi" slave-type bond con-name Bond0-Port2 ifname wlp4s0 master bond0
nmcli connection up Bond0
```
- `nmcli device status`
- System may need `reboot` and changes will persist

## Tool Comparisons (`nmtui` & `nmcli`)
### Settings from `nmtui`, `nmcli` & `route -n`
- Note: `nmcli` *CONNECTION* = `nmtui` *Profile name*

| **`nmcli device status` output** :

```
DEVICE  TYPE      STATE      CONNECTION
enp0s1  ethernet  connected  Wired connection 1
enp1s0  ethernet  connected  Wired connection 2 
wlp2s0  wifi      connected  Home WiFi
```

| **`nmtui` menu** :

```
Ethernet
  Wired connection 1
  Wired connection 2
Wi-Fi
  Home WiFi
```

| **`nmtui` Edit Connection** :

```
Profile name: Wired connection 1
      Device: enp0s1
```

```
Profile name: Wired connection 2
      Device: enp1s0
```

```
Profile name: Home WiFi
      Device: wlp2s0
```

| **`route -n` output** :

```
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.0.2.0        0.0.0.0         UG    100    0        0 enp0s1
0.0.0.0         192.168.1.1     0.0.0.0         UG    100    0        0 enp1s0
0.0.0.0         192.168.1.1     0.0.0.0         UG    600    0        0 wlp2s0
10.0.2.0        0.0.0.0         255.255.255.0   U     100    0        0 enp0s1
192.168.1.0     0.0.0.0         255.255.255.0   U     100    0        0 enp1s0
192.168.1.0     0.0.0.0         255.255.255.0   U     600    0        0 wlp2s0
```

### Bonding in `nmtui` & `nmcli`

| **`nmcli` bonding command** :#

```console
nmcli connection add type bond con-name Bond0 ifname bond0 bond.options "mode=active-backup,miimon=1000"
nmcli connection add type ethernet slave-type bond con-name Bond0-Port1 ifname enp1s0 master bond0
nmcli connection add type wifi ssid "Home WiFi" slave-type bond con-name Bond0-Port2 ifname wlp2s0 master bond0
nmcli connection up Bond0
```

| **`nmcli device status` output** :

```
DEVICE  TYPE      STATE      CONNECTION
bond0   bond      connecting Bond0
```

| **`nmtui` menu** :

```
Bond
  Bond0
```

| **`nmtui` Edit Connection** :

```
Profile name: Bond0
      Device: bond0

BOND
Slaves
  bond0-port2
  bond0-port1
___________________________________________

                Mode: <Active Backup>
             Primary: _____________________
     Link monitoring: <MII (recommended)>
Monitoring frequency: 1000______ ms
       Link up delay: 0_________ ms
```

| **`nmcli` bonding command** :# (again for reference to `nmtui` settings above)

```console
nmcli connection add type bond con-name Bond0 ifname bond0 bond.options "mode=active-backup,miimon=1000"
nmcli connection add type ethernet slave-type bond con-name Bond0-Port1 ifname enp1s0 master bond0
nmcli connection add type wifi ssid "Home WiFi" slave-type bond con-name Bond0-Port2 ifname wlp2s0 master bond0
nmcli connection up Bond0
```

## DNS & Host Name Resolution
**Resolution** - translating hostnames to their host machine IP addresses
- If your machine cannot **resolve** a hostname in `/etc/hosts`, then it will do a full DNS lookup

### Tools
- `dig` (modern)
  - `+trace` full trace
  - `-t` type of record in the DNS zone file
    - `SOA` start of authority
    - `A` IPv4
    - `AAAA` IPv6
    - `NS` nameserver
    - `MX` mail record
    - `TXT` text records
    - `CAA` certificate authority
    - `CNAME` alias
    - etc
  - `dig inkisaverb.com -t A +short`
- `host` (depreciated, easy to read)
- `nslookup` (depreciated)

### DNS
- A host machine's DNS use is configured in `/etc/resolv.conf`
  - This will list sources to search for DNS records
  - This file is probably generated automatically, such as by NetworkManager or the DHCP server

| **/etc/resolve.conf** :

```
# Generated by NetworkManager
# /etc/resolv.conf.head can replace this line
search lan 
nameserver 192.168.1.1
nameserver your:ISP:provider:name:server::
# /etc/resolv.conf.tail can replace this line
```

## Troubleshooting Network Problems
- Network problems come from either software or hardware; know which
- Troubleshooting checklist:
  - Ping a host in the network:
    - `ping 192.168.1.1` router
    - `ping inkisaverb.com`
    - `dig`, `host`
    - Trace packets: `traceroute`, `mtr`
      - These are similar to CISCO's Packet Tracer, see [VIP/Cheat-Sheets: Packet Tracer](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Packet-Tracer.md)
  - **Gateway**
    - `route -n` should should be in order
  - IP configuration
    - `ifconfig` or `ip` - look to see that everything is set and working
    - If properly set, but not working, it could be a driver problem...
  - Network Driver (in the kernel)
    - `lspci -v` shows devices and the `Kernel modules:` per device
      - `Kernel modules: alx` uses kernel module `alx`
    - See if `alx` is running (`alx` is our example, from `lspci -v` --> `Network`/`Ethernet` `controller`... `Kernel modules:`)
      - `lsmod | grep alx` shows if it is running
      - `find . -name "alx"` should return a value in `/sys` or `/proc`

### Tools
- IP configuration
  - `nmtui`
  - `nmcli device status`
  - `ifconfig`
  - `route -n`
  - `ip link`
    - `ip r` (`ip route`)
    - `ip -brief link`
- DNS lookup
  - `dig`
  - `host`
  - `nslookup`
- Network connection
  - `ping`
  - `traceroute`
  - `mtr`

___

# The Keys
*Practice commands for SysAdmins who already know what these mean*

| **Host** :$

```console
netstat -l
netstat -rn

cat /etc/hostname
hostname
hostname -i

hostname
sudo hostnamectl set-hostname $(hostname)
hostname
sudo hostname temp    # Not persistent
hostname

less /etc/hosts
less
```

| **Time** :$

```console
vim /etc/systemd/timesyncd.conf

ls /usr/bin/ntp*

ntpdc -c peers

timedatectl

vim /etc/ntp.conf
```

| **Network configs & routes** :

```console
# Network plugins are under [main] in the config...

less /etc/NetworkManager/NetworkManager.conf
grep plugins= /etc/NetworkManager/NetworkManager.conf

# Arch
cd /etc/NetworkManager
ls

# Debian
less /etc/network/interfaces

# Red Hat
less /etc/sysconfig/network
less /etc/sysconfig/network-scripts/ifcfg-ethX
less /etc/sysconfig/network-scripts/ifcfg-ethX:Y
less /etc/sysconfig/network-scripts/rout-ethX

# SUSE
cd /etc/sysconfig/network
ls
```

| **Network** :$

```console
netstat -l
netstat -rn

nmcli device status
nmtui
man nmcli

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
route -n
ip route del 10.5.0.0/16 via 192.168.1.100

route -n
ip route add default via 192.168.1.21 dev enp2s0
route -n
ip route del default via 192.168.1.21 dev enp2s0
route -n
```

| **Bonding** :$

```console
nmcli device status
# Note device names and don't reuse them below, presuming enp2s0 is listed at top
nmcli connection add type bond con-name Bond0 ifname bond0 bond.options "mode=active-backup,miimon=1000"
nmcli connection add type ethernet slave-type bond con-name Bond0-Port1 ifname enp3s0 master bond0
nmcli connection add type wifi ssid "Home WiFi" slave-type bond con-name Bond0-Port2 ifname wlp4s0 master bond0
nmcli connection up Bond0
nmtui
```

*Create the same bond with the above `nmcli` tool using `nmtui`*

```console
nmtui
```

| **DNS** :$

```console
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
___

#### [Lesson 7: Disk & Partitioning](https://github.com/inkVerb/vip/blob/master/601/Lesson-07.md)
