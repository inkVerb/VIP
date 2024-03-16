# Linux 601
## Lesson 6: Networks

### Reference

#### [VIP/Cheat-Sheets: File Size, Binary, Hexadecimal](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Sizes-Binary-Hex.md)
#### [VIP/Cheat-Sheets: Packet Tracer](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Packet-Tracer.md)
#### [CISCO Classes on Networking](https://skillsforall.com/catalog?category=course&subject+areas=networking) 
#### [Udemy Class on Networking](https://www.udemy.com/course/complete-networking-fundamentals-course-ccna-start/)

___

# The Chalk
## Network Services
Services on the network can include:

- Webservers like Apache or Nginx
- Mail like Postfix and Dovecot
- User servers like LDAP or WebDAV
- Databse servers that accept network access like MySQL or MariaDB
- DNS nameservers like Bind
- NBD to use block devices (disks) over the network
- FTP, SSH, SIP, and much more

Knowing how to manage these is each a separate topic unto itself

All of these will require that the network be operating, which this lesson addresses

To see which host machine services are listening on the network, use:

- `netstat -l`

This shows how each service listens:

1. to which port on the network
2. from which socket on the host machine

Your host machine is found through its IP address, which actually exists as a binary number, best understood in hexadecimal numerals

## Binary & Hexadecimal
Study binary and hexadecimal systems thoroughly: [VIP/Cheat-Sheets: File Size, Binary, Hexadecimal](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Sizes-Binary-Hex.md)

Everything after this will presume knowledge of binary oclets and corresponding hexadecimal pairs

## Terms
### Media Access Control (MAC)
- This is a unique number to a network device
  - Theoretically, it is burned into the network card by the manufacturer
  - This can be changed, but that could cause problems
- This is a 12-digit hexadecimal number, using three oclets
  - Eg: `FF:E6:05:9D:42:75`
- Earlier pairs of these oclets may be specifically reserved by individual manufacturers
  - Keep your MAC address private as it could be used to ghost your device for malicious use
- *The MAC address is not assigned to a machine, but to a **network device***
  - *If your machine has both ethernet and WiFi cards, your machine will have two MAC addresses*

### Local Area Network (LAN)
- The network in your home or office
- All host devices using the same WiFi or ethernet router are on this network
- Devices using services like YouTube or Spotify can use this network to remotely control each other

### Wide Area Network (WAN)
- A network that connetcs multiple Local Area Networks
- It includes multiple locations
- The Internet itself is a kind of Wide Area Network

### Internet Service Provider (ISP)
- This is a company that offers internet service
- These include AT&T, Spectrum, Taiwan Mobile, Virgin Mobile, Chinanet and many others

### Network Address Translation (NAT)
- Every machine must have an IP address to talk to other machines
  - Some are only unique and recognized inside your local network
  - Others are unique throughout the worldwide Internet
- NAT grants your private IP address on the network into a public IP address the Internet can interpret

### Network Mask
- Masks an oclet of an IP address, blocking it from being used by public Internet IP addresses
- Uses all `1` digits (`11111111` or `255` for a full oclet)
- Compare two IP addresses in lieu of the mask
  - Masked oclets same = both IPs are on the same **local** network
  - Masked oclets different = IPs are **remote** on different networks
- Thus determines whether an IP address is **remote** or **local**
  - **Remote** - different subnet, **default gateway** required
  - **Local** - same subnet, no **default gateway** required
- Formats
  - `1` binary = Network
  - `0` binary = Host
  - Mask: `255`.`0`.`0`.`0` = `11111111`.`00000000`.`00000000`.`00000000` = `/8`
    - The first oclet is reserved for the local network
  - Mask: `255`.`255`.`0`.`0` = `11111111`.`11111111`.`00000000`.`00000000` = `/16`
    - The first two oclets are reserved for the local network
- Most network hardware requires that the `1`s be contiguous:
  - `11111111.11111111.00000000.00000000` (`255.255.0.0/16`) contiguous (allowed)
  - `11111111.11111100.00000000.00000000` (`255.252.0.0/14`) contiguous (allowed)
  - `11111111.11110000.00000000.00000000` (`255.240.0.0/12`) contiguous (allowed)
  - `11111111.11000000.00000000.00000000` (`255.192.0.0/10`) contiguous (allowed)
  - `11111111.00000000.00000000.00000000` (`255.0.0.0/8`) contiguous (allowed)
  - `11110000.11111111.00000010.00000001` (`240.255.2.1/??`) *discontiguous (not allowed)*

### Dynamic Host Configuration Protocol (DHCP)
- Automatically assign IP addresses to machines on a network
- This can be done through a DHCP server
- This can be done automatically in a peer-to-peer situation (APIPA)
  - All machines must be configured to use DHCP
  - No DHCP server is available

### Internet Protocol (IP)
- Used in:
  - IP Header
  - IP Data
  - IP Packets
  - IP Address (v4 or v6)
  - Etc

### Protocol Data Unit (PDU)
- Categorized as:
  - Segments(TCP links)
  - Packets (IP header/data, sent to/from IP addresses)
  - Frames (ARP calls)
  - Bits (Eterhent chatter, ATM transactions, WiFi chatter)
- These are ***too small*** to include fuller information used in:
  - SSH login or command
  - HTTP web page (load a webpage or an AJAX request)
  - FTP file upload
  - VoIP/SIP phone call
  - SMTP email

### Address Resolution Protocol (ARP)
- Basic messages betwen networked computers as they shake hands
- In headers, essentially with To/From information like IP and MAC addresses

### Packet
- PDU of information sent in the **Network** layer
- Made of:
  - Header (contains ARP)
  - Payload
  - Footer

#### Integrated Services Digical Network (ISDN)
**AKA: Basic Rate Interface (BRI)**

*Not on Linux SysAdmin exams, but helps keep a perspective in networking*

- Transmits both data and voice over a digital line
  - Probalby an old phone line or cable TV line that became Internet, cable, and TV service combined
  - Usually includes and serves:
    - SIP trunking/termination (VoIP service)
    - Cable TV
    - Internet service
- **ISDN switch** (road box?)
  - Probably the ISP box at the end of your driveway
- **Network Termination (NT)**
  - **NT1** (modem?)
    - Setup per instructions from the ISP (with login), probably the "modem"
    - Provides the `T` interface cable, which plugs Internet service into a WiFi Router
  - **NT2** (router?)
    - Probably the ethernet/WiFi router all your household devices connect to
    - Provides the `S` interface cable or WiFi signal, which connects to TE
- **Termination Equipment (TE)** can include:
  - PC
  - Mobile phone or tablet
  - VoIP/ISDN phone
  - Cable TV channel box (usually includes remote control, a kind of TA)
  - Smart TV that can change cable channels and uses ethernet or WiFi
  - Gaming console
  - WebCam
  - Another router to distripute service to more terminal points
- **Terminal Adapter (TA)**
  - Allows non-ISDN equipment to operate on ISDN network
  - Adapter that creates an SIP/VoIP interface for a standard phone
  - Cable TV box so a monitor or old TV can view cable TV channels
- Search online for more details
- Basic map is this:
```
[Old TV/Monitor TE]---R---[TA]---S---[NT2]---T---[NT1]---U---{ISDN switch}
[Standard Phone TE]---R---[TA]---S---[NT2]---T---[NT1]---U---{ISDN switch}
[PC/mobile/VoIP TE]--------------S---[NT2]---T---[NT1]---U---{ISDN switch}
```
- `R` - `S` - `T` - `U` represent connection links on the way to the ISDN switch, then on toward the Internet

## Layers
| Layer       | TCP/IP      | OSI                                     | Uses                                              | Protocol Data Units |
| :---------: | :---------: | :-------------------------------------: | :-----------------------------------------------: | :-----------------: |
| 7<br>6<br>5 | Application | Application<br>Presentation<br>Session  | HTTP, SMTP, FTP,<br>DNS, SSH, Telnet,<br>VoIP/SIP |                     |
| 4           | Transport   | Transport                               | TCP, UDP                                          | Segments            |
| 3           | Network     | Network                                 | IP Addresses, IP Headers, IP Data                 | Packets             |
| 2           | Data/Access | Data Link                               | MAC, ARP calls, Router, Switch, WiFi              | Frames              |
| 1           |             | Physical                                | Eternet, ATM, Cables, Hub, WiFi                   | Bits                |

## IPv4 Addresses
### Oclets
- IP addresses actually exist only in binary:
  - `127.53.207.5` is actually:
  - `01111111.00110101.11001111.00000101`
- Each of the four places in the IP address is called an "Oclet"
- IPv4 uses four oclets in its address
- We humans write these in decimal (`0`-`9`), but that just makes it easy for us; they remain binary

### Subnet Mask: Host v Network
- A network and host machine use different binary places for their addresses
- A subnet mask blocks off binary places so they can only be used to
- A mask uses `1` in binary to block (mask) binary places to be used only for the network's address
  - This is set up in network settings, such as on your host machine and on network routers, etc
- This mask blocks the first oclet:
  - `11111111.00000000.00000000.00000000` (AKA `255.0.0.0`)
  - In every host machine on the same network, they have the same first oclet
  - The network's address will uses `0` for all remaining oclets
  - Network address: `125.0.0.0`
  - Host addresses on that network: `125.52.215.0`, `125.0.0.1` `125.1.1.49`
    - (First oclet always the same, others can be anything)
- This mask blocks the first three oclets:
  - `11111111.11111111.11111111.00000000` (AKA `255.255.255.0`)
  - In every host machine on the same network, they have the same first three oclets
  - The network's address will uses `0` for the last oclet
  - Network address: `125.59.2.0`
  - Host addresses on that network: `125.59.2.249`, `125.59.2.1` `125.59.2.38`
    - (First three oclets always the same, others can be anything)

### Classful Masking (before 1993)
- Class A: `0-127` (*network* uses first oclet)
  - *`0`*.`0`.`0`.`0` - *`127`*.`255`.`255`.`255`
- Class B: `128-191` (*network* uses first two oclets)
  - *`128`*.*`0`*.`0`.`0` - *`191`*.*`255`*.`255`.`255`
- Class C: `192-223` (*network* uses first three oclets)
  - *`192`*.*`0`*.*`0`*.`0` - *`223`*.*`255`*.*`255`*.`255`
- Class D: `224-239` (no oclets reserved for network)
  - `224`.`0`.`0`.`0` - *`239`*.`255`.`255`.`255`
  - Used by IP-based streaming services like cable TV
- Class E: `240-255` (no oclets reserved for network)
  - `240`.`0`.`0`.`0` - `255`.`255`.`255`.`255`
  - Reserved for research by IT teams

### Classless Inter-Domain Routing (CIDR) Masking
- 1993 introduced CIDR to replace **classful** IP addressing
- CIDR uses Variable Length Subnet Masking (VLSM)
- Class Mask Notation: `255`.`0`.`0`.`0`
- CIDR Mask Notation: `/8` (first `8` binary places)
- Because it does not break in oclet increments, CIDR allowes more flexibility for number of network-host addresses
- Classfull mask oclets are either `255` or `0` (`11111111` or `00000000`), allowing only three options
  - A: `255.0.0.0`
  - B: `255.255.0.0`
  - C: `255.255.255.0`
- CIDR mask values can be any number using contiguous preceding `1` values:
  - `10000000.00000000.00000000.00000000` (`/1`) (`128.0.0.0`)
  - `11110000.00000000.00000000.00000000` (`/4`) (`240.0.0.0`)
  - `11111111.10000000.00000000.00000000` (`/9`) (`255.128.0.0`)
  - `11111111.11000000.00000000.00000000` (`/10`) (`255.192.0.0`)
  - `11111111.11111000.00000000.00000000` (`/13`) (`255.248.0.0`)
  - `11111111.11111111.00000000.00000000` (`/16`) (`255.255.0.0`)
  - Et cetera, up to 32 possible masks

### IP addressTypes
- **Unicast**: Cloud servers, your computer/phone on the Internet
  - `120.53.207.5`
- **Network**: Networks
  - Uses only `0` for the host (non-masked) portion of the address
  - `120.0.0.0`
  - `113.24.0.0`
  - `47.53.4.0`
- **Multicast**: `224-239`.`X`.`X`.`X` (cablt TV, stock market feed, news feed, IP radio)
  - *So-configured hosts listen* to this host address
  - Prefix: `1110` (`224-239` in the first oclet)
  - No mask, others don't matter
  - `224.0.0.1`
  - `238.14.15.254`
  - `239.1.1.19`
- **Broadcast**: `X`.`X|255`.`X|255`.`255` (usually for network to talk to itself, routine business, exploited for DDoS attacks)
  - *All hosts listen* to this host address
  - Uses only `1`, (`11111111` AKA `255`) for host (non-masked) portion of the address
  - `8.255.255.255`
  - `137.14.255.255`
  - `137.14.3.255`

### Unicast Classes
- **Class A: `0-127`**
  - *`0`*.`0`.`0`.`0` - *`127`*.`255`.`255`.`255`
  - First oclet digit is `0`: *`00000000`* - *`011111111`*
  - Mask: `255`.`0`.`0`.`0` (`/8` CIDR)
  - Network uses first oclet ***`X`***.`0`.`0`.`0`
  - Host uses last three oclets `10`.***`X`***.***`X`***.***`X`***
  - 16,777,214 hosts
  - Reserved: *`0`*.`0`.`0`.`0`, *`127`*.`255`.`255`.`255`
    - *`127`*.`X`.`X`.`X` (Loopback)
    - *`0`*.`X`.`X`.`X` (Network)
  - Available network oclets: `1-126` *`1`*.`0`.`0`.`0` - *`126`*.`255`.`255`.`255` (*`00000001`* - *`01111110`*)
  - Reserved network address: `X`.`0`.`0`.`0`
  - Private range: (`10/8`) `10`.`0`.`0`.`0` - `10`.`255`.`255`.`255`
- **Class B: `128-191`**
  - *`128`*.`0`.`0`.`0` - *`191`*.`255`.`255`.`255`
  - First two oclet digits are `10`: *`10000000`* - *`10111111`*
  - Mask: `255`.`255`.`0`.`0` (`/16` CIDR)
  - Network uses first two oclets ***`X`***.***`X`***.`0`.`0`
  - Host uses last two oclets `172`.`16`.***`X`***.***`X`***
  - 65,534 hosts
  - Reserved network address: `X`.`X`.`0`.`0`
  - Private range: (`172.16/12`)  `172`.`16`.`0`.`0` - `172`.`31`.`255`.`255`
- **Class C: `192-223`**
  - *`192`*.`0`.`0`.`0` - *`223`*.`255`.`255`.`255`
  - First three oclet digits are `110`: *`11000000`* - *`11011111`*
  - Mask: `255`.`255`.`255`.`0` (`/24` CIDR)
  - Network uses first three oclets ***`X`***.***`X`***.***`X`***.`0`
  - Host uses last oclet `192`.`168`.`1`.***`X`***
  - 254 hosts
  - Reserved network address: `X`.`X`.`X`.`0`
  - Private range: (`192.168/16`) `192`.`168`.`0`.`0` - `192`.`168`.`255`.`255`

### Multicast Class
- **Class D: `224-239`**
  - *`224`*.`0`.`0`.`0` - *`239`*.`255`.`255`.`255`
  - First four oclet digits are `1110`: *`11100000`* - *`11101111`*
  - Mask: none
  - `224`.`0`.`0`.`X` Local Link Multicasts

### IT Reserved Class
- **Class E: `240-255`**
  - *`240`*.`0`.`0`.`0` - *`255`*.`255`.`255`.`255`
  - First four oclet digits are `1111`: *`11110000`* - *`11111111`*
  - Mask: anything
  - Entirely reserved for broadcasts

## Local IPv4 addresses
### Directed Broadcast
- Host uses all binary `1`, `255` for all host octets
  - Class A: `X`.`255`.`255`.`255`
  - Class B: `X`.`X`.`255`.`255`
  - Class C: `X`.`X`.`X`.`255`
- Disabled in modern routers by default
- DDoS attacks: (eg SMURF)
  1. Cause a machine to send a **directed broadcast** to other machines (via `255` hosts)
  2. All machines process the broadcast
  3. Those machines respond to the first machine with a denial

### Local Broadcast
- **`255`.`255`.`255`.`255`**
- DHCP requests query this address
  - A new machine sends a request to this local broadcast to ask for an automatically assigned IP address
- Layer three routers always drop DHCP rewuests
  - Unless configured for "DHCP forwarding/relay"

### Local Loopback
- `127`.`X`.`X`.`X`
  - `127`.`0`.`0`.`1` = `localhost`
  - `127`.`0`.`1`.`1` = `$HOSTNAME`
  - These point to the same machine, but must be separate for creating a healthy FQDN
    - We don't want `localhost` and the domain that the machine serves to be one-in-the-same
    - FQDN (Fully Qualified Domain Name) is the "true domain" of a web server and is necessary for some things like being a DNS Nameserver, email server, etc
- Used by a device to send a message to itself for testing
  - Verifying installation of a TCP/IP stack
- Different from a router/switch loopback address

### Local DHCP
- `0`.`0`.`0`.`0`
  - Used by a host machine to be assigned a local IP by DHCP
### Private IPv4 Addresses
#### Private Internets
- Per [RFC1918](https://datatracker.ietf.org/doc/html/rfc1918), IANA has reserved these for private internets:
  - ISPs will not accept these addresses
```
10.0.0.0    - 10.255.255.255  (10/8 prefix)
172.16.0.0  - 172.31.255.255  (172.16/12 prefix)
192.168.0.0 - 192.168.255.255 (192.168/16 prefix)
```
- Note this uses **CIDR**, not **classful**

#### Link-Local `169`.`254`.`X`.`X` (APIPA)
- Per [RFC9327](https://datatracker.ietf.org/doc/html/rfc9327), Automatic Private IP Address (APIPA) can be chosen by a PC configured for DHCP ***when no DHCP server is available***
  - PC automatically chooses its own IP in range `169.254/16` (`169`.`254`.`X`.`X`)
- Traffic on these addresses is non-routable

### Pigeons
- Per [RFC1149](https://datatracker.ietf.org/doc/html/rfc1149) pigeons can be used in place of an Internet cable

## IPv6 Addresses
### Format
- `128` bits long (`16` oclets)
- Grouped into `8` "hexadecs" (AKA two oclets, `16` binary places each)
- Each hexadec (short for hexadeclet) is notated with four hexadecimal digits
  - `A13D` (decimal `41277`)
  - `143F` (decimal `5183`)
  - `1001` (decimal `4097`)
  - `FFFF` (decimal `65535`)
  - `12AB` (decimal `4779`)
  - `0000` (decimal `0`)
  - Case does not matter: `FFFF` = `ffff`
- `:` (colon) is delimeter between hexadecs
  - `2001:19F0:AC01:01B9:5400:04FF:FE60:D6D2`
  - `2001:19F0:7001:42B4:5400:04FF:FE60:E32F`
  - `2001:19F0:B002:0AEC:5400:04FF:FE60:E2BF`
  - `2001:19F0:6001:5FC6:5400:04FF:FE96:A851`
- Leading zeros may be omitted in each hexadec
  - `04FE` = `4FE`
  - `04FE` is called "**expanded**"
  - `4FE` is called "**compressed**"
  - DNS and others require expanded notation
  - Some systems allow **compressed** notation
- `::` a multi-hexadec wildcard
  - Also used in a **compressed** IPv6 format
  - Represents a span of hexadecs all equal to zero
  - Can cover any number of hexadecs
  - Can only appear once in the entire address
  - `0000:0000:0000:0000:0000:0000:0000:0000` = `::`
  - `0000:0000:0000:0000:0000:0000:0000:0001` = `::1` (used for loopback)
  - `2001:0000:0000:0000:0000:0000:FE96:A851` = `2001::FE96:A851`
  - `2001:0000:6001:5FC6:5400:04FF:FE96:A851` = `2001::6001:5FC6:5400:4FF:FE96:A851`
  - `2001:0000:6001:5FC6:5400:0000:0000:0000` = `2001:0:6001:5FC6:5400::` (can only use `::` once)

### Network Masking
- IPv6 does not use subnet masking, but rather uses a "prefix" with the same notation as CIDR
- `/64` binary places is standard for network mask length
  - Eg: `2001:19F0:0420:0000:/64` is the network portion of an IPv6 address
    - The first four hexadecs take up a total of `64` binary places, `16` per hexadec group
    - All host machines on this network will begin their IPv6 address with `2001:19F0:`
    - The host machine will likely have `2001:19F0::` as its IP address

### Types
#### Unicast
##### Global
- Can be either:
  - Mannually assigned, such as on the host and recorded in DNS
  - Dynamically assigned, such as through DHCP

##### Link-local
- Automatically on every machine
- Non-routable (as with IPv4)
- `FE80::/10` (1111111010 0000000010)
- Not necessarily bound to a MAC address

#### Multicast
- Packets are delivered to multiple IP destinations

#### Anycast
- A packet is delivered to the first available of multiple IP destinations (in network routing structure)

#### IPv4-Mapped
- An IPv4 address's four oclets replace the last two hexadecs of an IPv6 address
  - `::FFFF:X.X.X.X/96`

#### Loopback
- All `0` and ends with binary `1`
- `::1/128`

## Host
### Basics
- The host name is recorded in `/etc/hostname`
- `hostname` see the name of your machine's host
  - `hostname -i` for your IP address
- `#` `hostname inky` sets the host name to `inky`
- Extended host IP information is in `/etc/hosts`
- `#` `hostnamectl set-hostname inky` persistently set the hostname
  - `hostnamectl --help`

### Basic config
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
- Network time is ddivided into **strata**
  - strata `0` is a special clock: radio, atomic clock, shortwave GMT, etc
  - strata `1` NTP server connected directloy to `0` (via cable, etc)
  - strata `2` NTP server referencing strata `1`
  - strata `3` NTP server referencing strata `2`
- NTP server types
  - server: provides time to clients
  - client: gets time from server or peer
  - peer: synchronizes time between other peers (peers prioritized over defined servers)

### Tools
#### `ntp`
- *Different NTP tools conflict; choose one*
- `ntp` primary time tool
  - `/etc/ntp.conf`
- `chrony` cross-environment, including cross-network and VM (optional package)
  - `/etc/chrony.conf`
- `systemd-timesyncd` - `ntp` client included in `systemd` package
  - `/etc/systemd/timesyncd.conf`

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

#### Local Query
- `ntpdc -c peers` show time difference between local and authoritative servers
- `timedatectl` part of `systemd` and `systemd-timesyncd`

#### NTPD Server
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

## Network Devices
### Names
- List network devices and `dev` names:
  - `nmcli device status`
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

#### Network Configs
- Red Hat
  - `/ext/sysconfig/network`
  - `/ext/sysconfig/network-scripts/ifcfg-ethX`
  - `/ext/sysconfig/network-scripts/ifcfg-ethX:Y`
  - `/ext/sysconfig/network-scripts/rout-ethX`
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
  - `key-file`: generic replacesment for some particular configs
  - Plugins are in a comma-separated list under `[main]` in `/etc/NetworkManager/NetworkManager.conf`

#### Network Manager Interfaces
- `nmtui` - Text User Interface
- `nmcli` - Command Line Interface
- Both of these access the same settings as the *WiFi* and *Wired* network settings in a desktop GUI like GNOME or Xfce

### Routing
- Get information
  - `route -n`
  - `ip r` (AKA `ip route` AKA `ip route show`)
    - `ip -6 r` for IPv6 routs
  - `ip a` (AKA `ip addr` AKA `address show`)
  - `ifconfig -a`

#### Default Route
*IP for router not known, such as with DHCP*

- Manually set the default gateway to `192.168.1.21`:#
  - `ip route add default via 192.168.1.21 dev enp2s0`
    - ...where `enp2s0` is a card on your machine listed in:
      - `nmcli device status`
      - Also visible in all of these:
        - `ifconfig`
        - `route -n`
        - `ip link` (et al)
        - `arp -a`
    - `enp2s0` could also be:
      - `wlp2s0`
      - `enp3s0`
- Restore to the normal default gateway `192.168.1.1`:#
  - `ip route add default via 192.168.1.1 dev enp2s0`
- Command description:
```
ip route add default via 192.168.1.1 dev    enp2s0
IP route add default via address     device name
```

#### Static Routs
*Usually with multiple routers*

- Add a non-persistent route:#
  - `ip route add 10.5.0.0/16 via 192.168.1.100`
- Delete a non-persistent route:#
  - `ip route del 10.5.0.0/16 via 192.168.1.100`
- Persistent routes:
  - Flavored distros must edit their config files and add them manually
    - Debian: `/etc/network/interfaces`
    - Red Hat: `/ext/sysconfig/network-scripts/rout-ethX`
    - SUSE: `/etc/sysconfig/network/ifroute-eth0`
  - Arch uses a service, then adds scripts: [read more](https://wiki.archlinux.org/title/NetworkManager#Network_services_with_NetworkManager_dispatcher)
    - `systemctl enable NetworkManager-dispatcher.service`
    - `systemctl start NetworkManager-dispatcher.service`
    - Create a BASH script in `/etc/NetworkManager/dispatcher.d/` with any name like *`10-script.sh`*
    - Own:# `chown root:root /etc/NetworkManager/dispatcher.d/10-script.sh`
    - Executable:# `chmod ug+x /etc/NetworkManager/dispatcher.d/10-script.sh`
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
- `nmcli device status` (find network device name)
  - Say this includes devices called `enp3s0` and `enp4s0`, which we use
- Create an interface bond called `bond0`
```
nmcli connection add type bond con-name bond0 ifname bond0 bond.options "mode=active-backup,miimon=1000"
nmcli connection add type ethernet slave-type bond con-name bond0-port1 ifname enp3s0 master bond0
nmcli connection add type ethernet slave-type bond con-name bond0-port2 ifname enp4s0 master bond0
nmcli connection up bond0
```
- `nmcli device status`
- System may need `reboot` and changes will persist

## DNS & Host Name Resolution

**Resolution** - translating hostnames to their host machine IP addresses

- If your machine cannot **resolve** a hostname in `/etc/hosts`, then it will do a full DNS lookup

### Tools
- `dig` (modern)
  - `+trace` full trace
  - `-t` type of record in the DNS zone file
    - `A` IPv4
    - `AAAA` IPv6
    - `NS` nameserver
    - `MX` mail record
    - `TXT` text records
    - `CAA` certificate authority
    - `CNAME` alias
    - `SOA` start of authority
    - etc
  - `dig inkisaverb.com -t A +short`
- `host` (depreciated, easy to read)
- `nslookup` (depreciated)

### DNS

- A host machine's DNS use is configured in `/etc/resolv.conf`
  - This will list sources to search for DNS records
  - This file is probably generated automatically, such as by NetworkManager or DHCP

| **/etc/resolve.conf** :

```
# Generated by NetworkManager
# /etc/resolv.conf.head can replace this line
search lan 
nameserver 192.168.1.1
nameserver your:ISP:provider:name:server::
# /etc/resolv.conf.tail can replace this line
```

### What is a Domain Name Server (DNS)?

**DNS nameserver** - a server with `bind` or other DNS service answering to port `53` with record for a domain host name

- Your nameserver is probably either your domain registrar or VPS service where you "park" the DNS records
- There must be at least two nameservers
- The DNS nameserver is configured by your registrar
- Domain server examples:
  - `ns33.domaincontrol.com`
  - `ns3.digitalocean.com`
  - `ns1.vultr.com`
  - `ns2.inkisaverb.com`
- Setting these usually involves instructions to follow

**DNS zone file** - the file on the DNS nameserver that we get host & IP record information from using `dig` or `hosts`
- These records are stored in a "zone file" on the nameserver
  - Zone files have one record per line
  - A GUI nameserver may separate each individual record for you to edit them more easily, such as GoDaddy or Vultr, DigitalOcean, Linode, etc
- DNS records include a type and a value, such as a string or an IP address
- DNS record type examples:
  - `A` IPv4
  - `AAAA` IPv6
  - `NS` nameserver
  - `MX` mail record
  - `TXT` text records
  - `CAA` certificate authority
  - `CNAME` alias
  - `SOA` start of authority

| **db.verb.ink** : (DNS zone file example for verb.ink)

```
$TTL    86400
; This is a comment
verb.ink.          IN  SOA      ns1.inkisaverb.com. dns.inkisaverb.com. (
2023122529              ; Serial No
10800                   ; Refresh
3600                    ; Retry
604800                  ; Expire
1800 )                  ; Minimum TTL
$ORIGIN verb.ink.
@                  IN  NS       ns1.inkisaverb.com.
@                  IN  NS       ns2.inkisaverb.com.
@                  IN  A        149.28.67.239
@                  IN  AAAA     2001:19f0:6001:5fc6:5400:4ff:fe96:a851
@                  IN  CAA      0 issue "letsencrypt.org"
email.verb.ink.    IN  CNAME    mail.verb.ink.
verb.ink.          IN  MX 50    mail.verb.ink.
verb.ink.          IN  TXT      "v=spf1 a mx a:verb.ink ip4:149.28.67.239 ip6:2001:19f0:6001:5fc6:5400:4ff:fe96:a851 -all"
_dmarc.verb.ink.   IN  TXT      "v=DMABOX1; p=reject; fo=0; aspf=r; adkim=r; pct=100; ri=86400; rua=mailto:dmark@verb.ink;"
```

**rDNS** - (reverse-DNS) looks up a domain by IP address

- rDNS lookup finds an IP address's FQDN - (Fully Qualified Domain, the primary host name) of a host machine on the Internet or network
- The entire IP address (v4 or v6) is in "reverse" order, looked-up backwards, often including the letters `arpa`
- Reverse IP address examples:
  - `207.246.96.85` = `85.96.246.207.in-addr.arpa`
  - `2001:19f0:6001:1450:5400:4ff:fe74:28a7` = `7.a.8.2.4.7.e.f.f.f.4.0.0.0.4.5.0.5.4.1.1.0.0.6.0.f.9.1.1.0.0.2.ip6.arpa`
- Eg, find reverse DNS with `host some.ip.addr.ess`

*Learn more about DNS and DNS records by searching on your own*

## Troubleshooting Network Problems
- Network problems come from either software or hardware; know which
- Troubleshooting checklist:
  - Ping a host in the network:
    - `ping 192.168.1.1` router
    - `ping inkisaverb.com`
    - `dig`, `host`
    - Trace packets: `traceroute`, `mtr`
      - These are similar to CISCO's Packet Tracer, see [VIP/Cheat-Sheets: Packet Tracer](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Packet-Tracer.md)
  - Gateway
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

## IP Cheat Sheet
### Common IP Addresses
```
::1         # localhost & loopback
127.0.0.1   # localhost
127.0.1.1   # $HOSTNAME
192.168.1.0 # Router's IP on network
192.168.1.1 # Gateway for machines to access Internet
192.168.1.X # Other hosts connected to the network (incl your machine's network IP)

0.0.0.0     # DHCP server

# Private IP addresses: (in addition to 127.X.X.X)
10.0.0.0    - 10.255.255.255  (10/8 prefix)
172.16.0.0  - 172.31.255.255  (172.16/12 prefix)
192.168.0.0 - 192.168.255.255 (192.168/16 prefix)
```

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
hostname
cat /etc/hostname
hostname -i
sudo hostname temp
sudo hostnamectl set-hostname $(hostname)

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

# Red Hat
less /ext/sysconfig/network
less /ext/sysconfig/network-scripts/ifcfg-ethX
less /ext/sysconfig/network-scripts/ifcfg-ethX:Y
less /ext/sysconfig/network-scripts/rout-ethX

# Debian
less /etc/network/interfaces

# SUSE
cd /etc/sysconfig/network
ls

# Arch
cd /etc/NetworkManager
```

| **Network** :$

```console
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
ip route add default via 192.168.1.1 dev enp2s0
route -n
```

| **Bonding** :$

```console
nmcli device status
# Note device names and don't reuse them below, presuming enp2s0 is the top
nmcli connection add type bond con-name bond0 ifname bond0 bond.options "mode=active-backup,miimon=1000"
nmcli connection add type ethernet slave-type bond con-name bond0-port1 ifname enp3s0 master bond0
nmcli connection add type ethernet slave-type bond con-name bond0-port2 ifname enp4s0 master bond0
nmcli connection up bond0
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
