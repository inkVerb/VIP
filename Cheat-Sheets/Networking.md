# Networking

Learn more about managing networks in **[Linux 601 Lesson 6: Networks](https://github.com/inkVerb/vip/blob/master/601/Lesson-06.md)**

## Reference
### [VIP/Cheat-Sheets: Packet Tracer](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Packet-Tracer.md)
### [CISCO Classes on Networking](https://skillsforall.com/catalog?category=course&subject+areas=networking) 
### [Udemy Class on Networking](https://www.udemy.com/course/complete-networking-fundamentals-course-ccna-start/)

___

## I. Networking Terms
### Network Interface Card (NIC)
- The card on a motherboard or PCI slot or plugged via USB that accesses the network
- Usually either WiFi or ethernet

### Media Access Control (MAC)
- A unique number for a network device
  - Theoretically, it is burned into the NIC by the manufacturer
  - This can be changed, but that could cause problems
- A 12-digit hexadecimal number, using three oclets
  - Eg: `FF:E6:05:9D:42:75`
- Earlier pairs of these oclets may be specifically reserved by individual manufacturers
  - Keep your MAC address private as it could be used to ghost your device for malicious use
- *The MAC address is not assigned to a machine, but to a **network device***
  - *If your machine has both ethernet and WiFi cards, your machine will have two MAC addresses*

### Local Area Network (LAN)
- The network in your home or office or something like that
- All host devices using the same WiFi or ethernet router are on this network
- Devices using services like YouTube or Spotify can use this network to remotely control each other
- Sometimes meaning *Land Area Network* to distinguish from **WLAN**

### Wireless LAN (WLAN)
- Redundant and often TMI (too much information)
- Extra clarity that the LAN uses WiFi, not Ethernet
- Most LANs at home or office use both LAN and WLAN
- A "mobile hot spot" is a WLAN, not a LAN, (though it probably has Ethernet plugs used only bye NetAdmins)

### Wide Area Network (WAN)
- A network that connetcs multiple Local Area Networks
- It includes multiple locations
- The Internet itself is a kind of Wide Area Network

### Subnet
- Redundantly clarifying: *the immediate LAN **and not** the WAN*
- eg a **gateway** is always for each **subnet**
  - A **gatweay** is the "gate" to leave the **subnet** to enter the WAN, worlwdide Internet, etc

### Internet Service Provider (ISP)
- Any company that offers Internet service
- These include AT&T, Spectrum, Taiwan Mobile, Virgin Mobile, Chinanet and many others

### Network Address Translation (NAT)
- Every machine must have an IP address to talk to other machines
  - Some are only unique and recognized inside your local network
  - Others are unique throughout the worldwide Internet
- NAT grants your private IP address on the network into a public IP address the Internet can interpret

### Local Boxes
#### Router
- Connects a network to other networks, including the worlwdide Internet
- Is the **NAT** server (if you have one which you probably do)

#### Switch
- Is the **LAN** server (Local Area Network server)
- Is the **DHCP** server for machines on the LAN it serves
- Uses **MAC** address to identify each machine on the LAN it serves
- Can connect to a router
- Connects different machines on the same network
- Can use WiFi or ethernet
  - Usually both in a home or office
- Usually has WiFi antennas and/or a few ethernet jacks

#### Router-Switch
- A router with a switch built inside
- The *consumer router*, probably with "Router" printed on the case somewhere
- Probably the main WiFi/LAN box in your home or office that your **ISP** gave you with setup instructions that you might have been scared to read, bearing a large and fashionable logo of your **ISP**

#### Hub
- Connects all machines to each other or the network
- Uses **broadcast**, very public where everyone sees everyone
- Almost the same as one ethernet CAT-5 or CAT-6 cable plugged directly between two computers as P2P networking
  - The cable used in that way could itself be called a "hub"

#### Modem
- Connects outside Internet to a router (from: broadband, NAS, POTS line, power line, satellite, etc)
- At home or office, has one coax cable input and one ethernet jack output
- Plugs into both the TV cable line and into your **router-switch** at a home or office
- Probably that other, less fashionable box in your home or office that your **ISP** gave you with setup instructions that you might have been even more scared to read and usually sits closer to the TV

### Internet Protocol (IP)
- Used in:
  - IP Packets
    - IP Header
    - IP Data
    - IP Trailer
    - IP Footer
  - IP Address (v4 or v6)
  - Etc
- (An/The) **IP** - universally-used bad slang meaning "IP *Address*"

### IP Address
- A numeric address in binary that identifies a machine on a network
- IP addresses are almost always translated to human-readable decimal, so they look like this:
  - IPv4 eg: `192.168.7.7`
    - (actually `11000000.10101000.00000111.00000111`)
  - IPv6 eg: `f800:19f0:72d1:5f8c:58cf:4ff:e89b:a851`
    - (actually `1111100000000000:1100111110000:111001011010001:101111110001100:101100011001111:10011111111:1110100010011011:1010100001010001`)

#### Network IP Addresses
- Ends in `0`: address for the *network itself* (**switch**)
  - `192.168.0.0`
  - `192.168.1.0`
- Ends in `1`: address for the network **gateway** (**router**)
  - `192.168.0.1`
  - `192.168.1.1`
  - **Gateway** - the IP address that network machines use to identify the **router** and thus talk to the WAN, other networks, or the worldwide Internet
- These numbers are standard settings, but they could be manually configured otherwise by a network administrator
- See your network addresses :$ `netstat -rn` or `route -n`

#### Network Mask
- AKA *netmask* or *mask*, implicated when discussing a *subnet mask*
- Masks binary bits in oclets of an IP address
  - Blocks it from being used by public Internet IP addresses
  - Makes the blocked portion *unchangable*
- Common masks:
  - `255.255.255.0` AKA `/24`
  - `255.0.0.0` AKA `/8`
- `255` here means that this oclet is reserved for the network
- Compare two IP addresses in lieu of the mask:
  - Masked oclets are same = both IPs are on the same **local** network
  - Masked oclets are different = IPs are **remote** on different networks
- Thus determines whether an IP address is **remote** or **local**
  - **Remote IP address** - different subnet, **default gateway** required
  - **Local IP address** - same subnet, **default gateway** *NOT* required
- **IP address prefix**: (`X.X.X/X`)
  - The first part of every IP address on the network (`X.X.X`), plus the mask (`/X`)
  - eg: `192.168.38/24` means every IP address on the network will start with `192.168.38`
    - Mask: `255.255.255.0` AKA `/24`
    - Machine 1: `192.168.38.52`
    - Machine 2: `192.168.38.1`
  - eg: `10/8` means every IP address on the network will start with `10`
    - Mask: `255.0.0.0` AKA `/8`
    - Machine 1: `10.0.0.1`
    - Machine 2: `10.175.4.58`
- *More is addressed later in **Subnet Mask***

### Dynamic Host Configuration Protocol (DHCP)
- Automatically assign IP addresses to machines on a LAN
- This can be done through a DHCP server (the **switch**)
  - The **switch** acts as the DHCP server

### Automatic Private IP Address (APIPA)
- `169.254/16`
- AKA *auto-IP*, auto-assigning local IP addresses when there is no DHCP server
- Done automatically in a peer-to-peer situation
  - All machines must be configured to use DHCP
  - No DHCP server is available

### Transmission Control Protocol (TCP)
- *Considered a kind of Internet Protocol*
- The basic *network* connection language
- Individual units of TCP information are called "**links**" or "**PDU Segments**"
- Almost all *inter-machine* network connections are using this under the hood
  - SSH login or command
  - HTTP web page (load a webpage or an AJAX request)
  - FTP file upload
  - SMTP/IMAP/POP email
  - VoIP/SIP phone call
  - IP networking
  - Any WiFi/ethernet/etc connection
- Usually ***not** intra-machine* communication (pluggable device peripherals)
  - PCI
  - USB
  - SATA
  - NVMe
  - Video
    - VGA
    - DVI
    - HDMI
    - DP

### Protocol Data Unit (PDU)
- Categorized as:
  - Segments (**TCP** links)
  - Packets (**IP** header/data/trailer/footer, sent to/from IP addresses)
  - Frames (**ARP** calls)
  - Bits (Eterhent chatter, ATM transactions, WiFi chatter)

### Address Resolution Protocol (ARP)
- Basic messaging betwen networked computers as they shake hands
- In headers, essentially with To/From information like IP and MAC addresses

### Packet
- PDU of information sent in the **Network** layer
- Made of:
  - Header (contains ARP)
  - Payload
  - Footer

### Mobile ISP
*(Not likely on Linux SysAdmin exams, but helps keep a perspective in networking)*

#### Access Stratum (NAS & AS) Protocols
- *Considered a kind of Internet Protocol*
- **Non-Access Stratum (NAS)**: (Network Layer) mobile device and ISP nodes deeper in the network
- **Access Stratum (AS)**: (Data Layer) mobile device and radio towers
- Wireless protocols used by ISPs to communicate with UE devices
  - LTE
  - GSM
  - UMITS
  - 4G/5G/etc
- A more basic layer than TCP

#### User Equipment (UE)
- Usually a mobile phone, SIM-card tablet, or "mobile hot spot"
- Mobile equipment that connects to an **ISP**'s mobile service radio towers
  - LTE
  - GSM
  - UMITS
  - 4G/5G/etc
- Uses **NAS/AS** protocols
  - Basically it's own way to talk to mobile service towers instead of **modem-switch-router** like in a home or office

### Integrated Services Digical Network (ISDN)
**AKA: Basic Rate Interface (BRI)**

*(Not likely on Linux SysAdmin exams, but helps keep a perspective in networking)*

- Transmits both data and voice over a digital line
  - Broadband or fiberoptic line
  - Could be an old phone line or cable TV line that became Internet, cable, and TV service combined
  - Usually includes and serves:
    - SIP trunking/termination (VoIP phone service)
    - Cable TV
    - Internet service
- **ISDN switch** (road box?)
  - Probably the ISP box at the end of your driveway
  - Provides the `U` interface for NT devices
- **Network Termination (NT)**
  - **NT1** (modem/UE)
    - Setup per instructions from the ISP (with login), probably the "modem"
    - Mobile phone, tablet, mobile "hot spot" (when using mobile Internet service like LTE/GSM/4G/5G/etc)
    - Provides the `T` interface cable, which plugs Internet service into a WiFi Router
  - **NT2** (router/switch)
    - Probably the ethernet/WiFi router or switch all your household devices connect to
    - Provides the `S` interface cable or WiFi signal, which connects to TE
- **Termination Equipment (TE)** can include:
  - PC
  - Mobile phone or tablet (when using WiFi)
  - VoIP/ISDN phone
  - Cable TV channel box (usually includes remote control, a kind of TA)
  - Smart TV that can change cable channels and uses ethernet or WiFi
  - Gaming console
  - WebCam
  - Another switch or router to distribute service to more terminal points
- **Terminal Adapter (TA)**
  - Allows non-ISDN equipment to operate on ISDN network
  - Adapter that creates an SIP/VoIP interface for a standard phone
  - Cable TV box so a monitor or old TV can view cable TV channels
  - Provides the `R` interface to equipment needing the adaptation
- Basic diagram:

```
[Old TV/Monitor TE]---R---[TA]---S---[NT2]---T---[NT1]---U---{ISDN switch}
[Old POTS Phone TE]---R---[TA]---S---[NT2]---T---[NT1]---U---{ISDN switch}
[PC/mobile/VoIP TE]--------------S---[NT2]---T---[NT1]---U---{ISDN switch}
```

- `R` - `S` - `T` - `U` represent connection links (cables & radio) on the way to the ISDN switch, then on toward the Internet

## II. Data Communication Layers
- Data communication layers help explain where we are working in the hardware-software stack
- There are two main models:
  - **[OSI (Open Systems Interconnection)](https://en.wikipedia.org/wiki/OSI_model)** - the first developed in the 1970s by the [International Organization for Standardization (ISO)](https://www.iso.org/) (the company that certifies factories to fly the *ISO 9001* flag at their driveways)
    - Seven layers (first five same as TCP/IP)
    - Theoretical, not practical
    - This standard is highly controversial and disliked by many who work in the field of SysDevOps and IT
    - Because of the authors, the model is likely intended to be used for "ISO" certification for SysDevOps and IP, to determine whether SysOps and DevOps are being done responsibly, reliably, and securely
  - **[TCP/IP (AKA Internet protocol suite)](https://en.wikipedia.org/wiki/Internet_protocol_suite)** - the second developed in the 1970s by the US Department of Defense
    - Five layers (same layers as OSI)
    - Adopted in 1983 as the official standard for ARPANET (succeeded by the Internet)
    - Inspired as a replacement for the OSI model because it didn't seem to fit how things worked in the real world
    - This seems to be the preferred model for many SysDevOps IT technicians because it is more practical for people working in the field
- Generally, you can follow any model you like without owing any loyalty to the other
- There is some ambiguity on the precise terms for each layer; the table below attempts to reconcile this for simplicity and understanding

### Devices Span Layers
- WiFi operates on Layer 1 in place of a cable, but on Layer 2 in supplying the connection for MAC addresses and ARP calls for the subnet
- Switches operate on Layer 2 in serving MAC addresses and ARP calls for the subnet, but on Layer 3 if connecting to any larger network

### Layers Table
| Layer       | TCP/IP      | OSI                                     | Uses                                              | Protocol Data Units |
| :---------: | :---------: | :-------------------------------------: | :-----------------------------------------------: | :-----------------: |
| 7<br>6<br>5 | Application | Application<br>Presentation<br>Session  | HTTP, SMTP, FTP, DNS, SSH, Telnet, VoIP/SIP       |                     |
| 4           | Transport   | Transport                               | TCP, UDP                                          | Segments            |
| 3           | Network     | Network                                 | Router/Switch, IP (Header, Data, Trailer, Footer), NAS           | Packets             |
| 2           | Access Link | Data Link                               | Switch, MAC, ARP calls, WiFi, AS          | Frames              |
| 1           |             | Physical                                | Eternet, Optical/Copper Cables, Hub, ATM, WiFi    | Bits                |

## III. IPv4 Addresses
### Oclets
- IP addresses actually exist only in binary:
  - `127.53.207.5` is actually:
  - `01111111.00110101.11001111.00000101`
- Each of the four places in the IP address is called an "Oclet"
- IPv4 uses four oclets in its address
- We humans write these in decimal (`0`-`9`), but that just makes it easy for us; they remain binary

### Subnet Mask
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

#### Mask in Binary vs Decimal
- Masks are in binary, using all `1` digits (`11111111` or `255` for a full oclet)
- Formats:
  - `1` binary = Network: *Any `1` or `0` in these places may not change*
  - `0` binary = Host: *Any `1` or `0` in these places could be anything*
  - Mask: `255`.`0`.`0`.`0` = `11111111`.`00000000`.`00000000`.`00000000` = `/8`
    - The first oclet is reserved for the local network
  - Mask: `255`.`255`.`0`.`0` = `11111111`.`11111111`.`00000000`.`00000000` = `/16`
    - The first two oclets are reserved for the local network
- Most network hardware requires that the `1`s be contiguous:
  - `11111111.11111111.00000000.00000000` (`255.255.0.0` = `/16`) contiguous (allowed)
  - `11111111.11111110.00000000.00000000` (`255.254.0.0` = `/15`) contiguous (allowed)
  - `11111111.11111100.00000000.00000000` (`255.252.0.0` = `/14`) contiguous (allowed)
  - `11111111.11111000.00000000.00000000` (`255.248.0.0` = `/13`) contiguous (allowed)
  - `11111111.11110000.00000000.00000000` (`255.240.0.0` = `/12`) contiguous (allowed)
  - `11111111.11100000.00000000.00000000` (`255.224.0.0` = `/11`) contiguous (allowed)
  - `11111111.11000000.00000000.00000000` (`255.192.0.0` = `/10`) contiguous (allowed)
  - `11111111.10000000.00000000.00000000` (`255.128.0.0` = `/9`) contiguous (allowed)
  - `11111111.00000000.00000000.00000000` (`255.0.0.0` = `/8`) contiguous (allowed)
  - `11110000.11111111.00000010.00000001` (`240.255.2.1` = `/??`) *discontiguous (not allowed)*

##### Network Mask & Prefix Examples
*Each IP in this entire list is for a different machine!*

- Network A:
  - `192.168.38.31/16` (`192.168.38/24` = first three oclets are masked)
  - `192.168.38.57/16` (`192.168.38/24` = first three oclets are masked)
  - `192.168.38.0/16` network IP
  - `255.255.255.0` = `/24` mask
- Network B:
  - `192.168.191.31/16` (`192.168.191/24` = first three oclets are masked)
  - `192.168.191.57/16` (`192.168.191/24` = first three oclets are masked)
  - `192.168.191.0/16` network IP
  - `255.255.255.0` = `/24` mask
- Network C:
  - `172.21.77.31/16` (`172.21/16` = first two oclets are masked)
  - `172.21.62.57/16` (`/172.2116` = first two oclets are masked)
  - `172.21.0.0/16` network IP
  - `255.255.0.0` = `/16` mask
- Network D:
  - `172.30.77.31/16` (`172.30/16` = first two oclets are masked)
  - `172.30.62.57/16` (`172.30/16` = first two oclets are masked)
  - `172.30.0.0/16` network IP
  - `255.255.0.0` = `/16` mask
- Network E:
  - `10.129.77.31/8` (`10/8` = first oclet is masked)
  - `10.106.62.57/8` (`10/8` = first oclet is masked)
  - `10.0.0.0/8` network IP
  - `255.0.0.0` = `/8` mask
- Network F:
  - `10.23.77.31/8` (`10.23/12` = first oclet is masked)
  - `10.23.62.57/8` (`10.23/12` = first oclet is masked)
  - `10.23.0.0/8` network IP
  - `255.240.0.0` = `/12` mask
  - `11111111.11110000.00000000.00000000` = `/12` = `8` + `4` mask in binary
  - `23` is `00010111`, protected by the first half oclet mask of `11110000`
- Network G:
  - `172.17.77.31/12` (`/12` = first and half oclet is masked)
  - `172.17.62.57/12` (`/12` = first and half oclet is masked)
  - `172.17.0.0/12` network IP
  - `255.240.0.0` = `/12` mask
  - `11111111.11110000.00000000.00000000` = `/12` = `8` + `4` mask in binary
  - `17` is `00010001`, protected by the first half oclet mask of `11110000`

### Classful Masking (before 1993)
- **Class A**: `0-127` (*network* uses first oclet)
  - *`0`*.`0`.`0`.`0` - *`127`*.`255`.`255`.`255`
- **Class B**: `128-191` (*network* uses first two oclets)
  - *`128`*.*`0`*.`0`.`0` - *`191`*.*`255`*.`255`.`255`
- **Class C**: `192-223` (*network* uses first three oclets)
  - *`192`*.*`0`*.*`0`*.`0` - *`223`*.*`255`*.*`255`*.`255`
- **Class D**: `224-239` (no oclets reserved for network)
  - `224`.`0`.`0`.`0` - *`239`*.`255`.`255`.`255`
  - Used by IP-based streaming services like cable TV
- **Class E**: `240-255` (no oclets reserved for network)
  - `240`.`0`.`0`.`0` - `255`.`255`.`255`.`255`
  - Reserved for research by IT teams

#### Unicast Classes
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

#### Multicast Class
- **Class D: `224-239`**
  - *`224`*.`0`.`0`.`0` - *`239`*.`255`.`255`.`255`
  - First four oclet digits are `1110`: *`11100000`* - *`11101111`*
  - Mask: none
  - `224`.`0`.`0`.`X` Local Link Multicasts

#### IT Reserved Class
- **Class E: `240-255`**
  - *`240`*.`0`.`0`.`0` - *`255`*.`255`.`255`.`255`
  - First four oclet digits are `1111`: *`11110000`* - *`11111111`*
  - Mask: anything
  - Entirely reserved for broadcasts

### Classless Inter-Domain Routing (CIDR) Masking
- 1993 introduced CIDR to replace **classful** IP addressing
- CIDR uses Variable Length Subnet Masking (VLSM)
- Class Mask Notation: `255`.`0`.`0`.`0`
- CIDR Mask Notation: `/X`
  - `/8` (first `8` binary places)
  - `/16` (first `16` binary places)
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

### Reserved & Local IPv4 addresses
- **[RFC5735](https://datatracker.ietf.org/doc/html/rfc5735#section-3)** has more information on various reserved IP addresses

### IPv4 Address Types
- **Unicast**: Cloud servers, your computer/phone on the Internet
  - `120.53.207.5` (example only)
  - `4.129.82.193` (example only)
  - `87.6.253.17` (example only)
- **Network**: Networks
  - Uses only `0` for last oclet and/or the host (non-masked) portion of the address
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
  - `29.7.255.255`
  - `135.14.3.255`

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
- `255.255.255.255` is for **Local Broadcast**

### Private IPv4 Addresses
#### Local Broadcast
- **`255`.`255`.`255`.`255`**
- DHCP requests query this address
  - A new machine sends a request to this local broadcast to ask for an automatically assigned IP address
- Layer three routers and switches always drop DHCP requests
  - Unless configured for "DHCP forwarding/relay"

#### Local Loopback
- `127`.`X`.`X`.`X`
  - `127`.`0`.`0`.`1` = `localhost`
  - `127`.`0`.`1`.`1` = `$HOSTNAME`
  - These point to the same machine, but must be separate for creating a healthy FQDN
    - We don't want `localhost` and the domain that the machine serves to be one-in-the-same
    - FQDN (Fully Qualified Domain Name) is the "true domain" of a web server and is necessary for some things like being a DNS Nameserver, email server, etc
- Used by a device to send a message to itself for testing
  - Verifying installation of a TCP/IP stack
- Different from a router/switch loopback address
- Per [RFC5735](https://datatracker.ietf.org/doc/html/rfc5735#section-3):

> `127.0.0.0/8` - This block is assigned for use as the Internet host
> loopback address.  A datagram sent by a higher-level protocol to an
> address anywhere within this block loops back inside the host.  This
> is ordinarily implemented using only `127.0.0.1/32` for loopback.  As
> described in [[RFC1122], Section 3.2.1.3](https://datatracker.ietf.org/doc/html/rfc1122#section-3.2.1.3), addresses within the entire
> `127.0.0.0/8` block do not legitimately appear on any network anywhere.

#### Local DHCP Discovery Source
- `0`.`0`.`0`.`0`
- Used by a host machine as a spoof "source" address so it can learn its own address, particularly when assigned a local IP by DHCP
- Per [RFC1122](https://www.rfc-editor.org/rfc/rfc1122#page-30):

> (a)  `{ 0, 0 }`
> 
> This host on this network.  MUST NOT be sent, except as
> a source address as part of an initialization procedure
> by which the host learns its own IP address.

#### Link-Local (APIPA)
- `169`.`254`.`X`.`X`
- Reserved for the immediate subnet of a machine
- Per [RFC9327](https://datatracker.ietf.org/doc/html/rfc9327), Automatic Private IP Address (**APIPA**) can be chosen by a PC configured for DHCP ***when no DHCP server is available***
  - PC automatically chooses its own IP in range `169.254/16` (`169`.`254`.`X`.`X`)
- Traffic on these addresses is non-routable
- Per [RFC5735](https://datatracker.ietf.org/doc/html/rfc5735#section-3):

> `169.254.0.0/16` - This is the "link local" block.  As described in
> [[RFC3927](https://datatracker.ietf.org/doc/html/rfc3927)], it is allocated for communication between hosts on a
> single link.  Hosts obtain these addresses by auto-configuration,
> such as when a DHCP server cannot be found.

#### Private Internets
- Per [RFC1918](https://datatracker.ietf.org/doc/html/rfc1918):
  - IANA has reserved these for private internets
  - ISPs will not accept these addresses

> ```
> 10.0.0.0    - 10.255.255.255  (10/8 prefix)
> 172.16.0.0  - 172.31.255.255  (172.16/12 prefix)
> 192.168.0.0 - 192.168.255.255 (192.168/16 prefix)
> ```

- Note this uses **CIDR**, not **classful**

## IV. IPv6 Addresses
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
- IPv6 does not use subnet masking, but rather uses a **prefix length** with the same notation as CIDR
  - Often called "**prefix**" for short
- `/64` binary places is standard for network mask length
  - eg: `2001:19F0:0420:A29D:/64` is the network **prefix** of an IPv6 address
    - The first four hexadecs take up a total of `64` binary places, `16` per hexadec group
    - All host machines on this network will begin their IPv6 address with `2001:19F0:0420:A29D:`
    - Likely **gateway**/network IP: `2001:19F0:0420:A29D::`
    - Likely **switch** IP: `2001:19F0:0420:A29D::1`

### IPv6 Address Types
#### Unicast
##### Global Unicast
- Can be either:
  - Mannually assigned, such as on the host and recorded in DNS
  - Dynamically assigned, such as through DHCP

##### Link-local Unicast
- Automatically on every machine
- Non-routable (as with IPv4)
- `FE80::/64` (`1111111010:0000000010`)
- Not necessarily bound to a MAC address

#### Multicast
- Packets are delivered to multiple IP destinations
- `FF00::/8`

#### Anycast
- A packet is delivered to the first available of multiple IP destinations (in network routing structure)

#### IPv4-Mapped
- An IPv4 address's four oclets replace the last two hexadecs of an IPv6 address
- `::FFFF:X.X.X.X/96`

#### Loopback
- For `localhost`
- All `0` and ends with binary `1`
- `::1/128`

## V. Pigeons & Ravens
- Per [RFC1149](https://datatracker.ietf.org/doc/html/rfc1149), pigeons and ravens can be used in flight, in place of networking cable or radio, to transmit IP datagrams
- Yes, "avian carriers" (pigeons & ravens)

## VI. Routing
### Basics for Beginners
- ***IP routing tables** are well beyond the scope of this course*
  - *System Administrators* and *Network Administrators* often overlap, but have different areas of training
  - *This provides a basic overview so the `ip route` commands are understandable* for SysAdmins without network experience
- Over a WAN like the worldwide Internet, each machine must connect through many different routers in order to talk to another machine across the network
- The list of which routers to go through in what order is called a "**route**"
- Routers and large servers often keep **routing tables** to look up best routes
- Routes can change all the time, so routers must ask each other where to go
- **Route** example:
```
[your-COMPUTER]--[house-ROUTER]--[new-york-ROUTER]--[tokyo-ROUTER]--[taiwan-website-HOST]
[first.ip.ad.1]--[next.ip.ad.2]--[next.ip.addre.3]--[next.ip.ad.4]--[thelast.ip.addrss.5]
```
- **Hopping** - Each machine asks the next machine which machine to go to next
  - Each "**hop**" asks for the "**next hop**"
  - The chain of "**hops**" is called a "**route**"
- **Routing** - deciding the best **route** (chain of **hops**)
- **Routing protocols** - *priority* for deciding the best **route**
  - RIP (Routing Information Protocol)
    - *hop count*
  - OSPF (Open Shortest Path First)
    - *distance; adaptable and scalable*
  - IGRP (Interior Gateway Routing Protocol)
    - *bandwidth, capacity & load*
  - EIGRP (Enhanced Interior Gateway Routing Protocol)
    - *IGRP + routers sharing route plans*
  - BGP (Border Gateway Protocol)
    - *origin, distance, neighbor routers*
  - IS-IS (Immediate System to Immediate System)
    - *distance + router groups*
- For SysAdmins, thee most important **route** (**next hop**) is the **gateway** used by the host machine the SysAdmin manages
  - Rephrased: *the only **route** most SysAdmins need is the **first hop** (the **gateway**)*

### Routing by NIC
- Your machine keeps a **route** setting for the **gateway** for each NIC connected to a LAN
  - On a DHCP server, this **route** setting is temporary and changes every time you connect to Ethernet or WiFi (which is why it often takes a few seconds to connect)
- Your WiFi could connect to a different LAN than your Ethernet plug
  - So, each **gateway** setting is kept per NIC
    - (One for the WiFi device, one for the Ethernet device)
- *Deciding "**routes**" is why it is called a "**router**"!*
- You can configure this **gateway route** manually with the `ip route` command
  - *When managing servers on a LAN, a SysAdmin may need to do this*
- ***Remember:*** Most DHCP servers (router/switch) decide their own IP address (since they decide everyone else's IP address)
  - The **router/gateway** IP address is set in the machine, probably won't change, and is listed in the printed manual
  - It usually is `192.168.1.1`
  - Use `route -n` to find the **gateway** IP address
  - For the practice commands below, you will need to change it back to the correct one once finished

## VII. Domain Name Server (DNS)
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
- Each DNS record is kept on a single line

**DNS zone record** - single-line entry in the DNS zone file
- Lines contain an tag of each record, usually after `IN`
- Each line starts with the name of the record and ends with the value, such as a string or an IP address
- `;` is the comment character
- `@` means "this host"
- Common DNS records:
  - `SOA` start of authority
    - (uses several parameters in `(`parentheses`)` and often on muptiple lines for comment descriptions)
  - `A` IPv4
  - `AAAA` IPv6
  - `NS` nameserver
  - `MX` mail record
  - `TXT` text records
  - `CAA` certificate authority
  - `CNAME` alias

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
- Find reverse DNS with :$ `host some.ip.addr.ess`

## VIII. Common IP Addresses
```
# Local machine
::1         # localhost & loopback (IPv6)
127.0.0.1   # localhost (a loopback)
127.0.1.1   # $HOSTNAME (a loopback)

# Local network
192.168.1.0 # Network IP address (switch)
192.168.1.1 # Gateway for machines to access Internet (router)
192.168.1.X # Other hosts connected to the network (incl your machine's network IP)

# DHCP
0.0.0.0          # Identify self in query to DHCP server
255.255.255.255  # DHCP server broadcast address

# Private Internet IP addresses:
10.0.0.0    - 10.255.255.255  (10/8 prefix)
172.16.0.0  - 172.31.255.255  (172.16/12 prefix)
192.168.0.0 - 192.168.255.255 (192.168/16 prefix)
```
