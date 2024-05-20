# Linux 601
## Lesson 10: Firewall

# The Chalk
## Firewall
*A network traffic security system*

- Monitors and controls
- Incoming and outgoing
- Connections and packets
- Built on hardware or software
- In routers, client machines, any network device
- Protects from intruders
- Enforces trust levels
- Watches interfaces and addresses

### Packet Filtering
- *Most firewalls filter packets*
- ***Packets** & **layers** are covered more in [Lesson 6: Networks](https://github.com/inkVerb/vip/blob/master/601/Lesson-06.md)*
- **Packet** - Protocol Data Unit (PDU) - sent in the **Network** layer
- A **packet** contains:
  - Header
  - Payload
  - Footer
- Packet filtering intercepts packets at multiple **security layers**, including:
  - Application
  - Transport
  - Network
  - Data/Access
- Firewall rules determine whether each packet should be:
 - Accepted or rejected
 - Damaged and in need of action
 - Redirected
 - Inspected

### History
1. First generation firewalls were from the late 1980s
   - Filtered only packets, *not the connection*
2. Second generation firewalls used **stateful filters**
   - Evaluate connection: new, existing, none
   - DDoS attacks overwhelm this firewall
3. Third generation fiewalls also use the **application layer**
   - Aware of:
     - Application type
     - Protocol
   - Blocks anything OOO (Out Of Ordinary), only allows NOB (Need to Operate Basis)

### Interfaces & Tools
#### Low in the Stack
- `firewall-cmd` (CLI for Dynamic Firewall Manager, `firewalld` package)
- `ufw` (Uncomplicated Firewall)
- `iptables`
  - More complex to use by itself
  - Managed by `firewalld` to interact with the kernel 
  - Older than `firewalld`
  - Direct control conflicts with `firewalld`
  - Covered thoroughly elsewhere, but not on these lessons
- Such tools are:
  - Configured in the `/etc/` directory
  - Managed by the CLI
  - Don't change often (cf GUI tools)
  - Have more capability
  - Consistent across Linux distros
  - Have a steep learning curve

#### GUI
- `firewall-config` (GUI for Dynamic Firewall Manager, `firewalld` package)
- `system-config-firewall`
- `gufw`
- `yast`
- Such tools are:
  - Managed through a GUI
  - Change often with updates and new versions
  - Have less capability
  - May be Linux distro-specific
  - Have an easy learning curve

### Dynamic Firewall Manager (`firewalld`)
- This package includes: `firewall-cmd` & `firewall-config`
- Helo: `firewall-cmd --help`
- Uses **zones**
- Configs:
  - `/etc/firewalld/` (override)
  - `/usr/lib/firewalld/` (defaults)
- These contain sub-folders with config files that can be edited directly rather than using the `firewall-cmd` command, but it is not recommended
  - One obvious purpose of using files rather than commands might be for an OOB-ready install package that needs specific `firewalld` settings that would be copied into the corresponding place in `/etc/firesalld/.../` as a program-specific file to override the `firewalld` defaults in `/usr/lib/firewalld/../`

#### Management
- `systemctl enable firewalld`
- `systemctl start firewalld`
- `systemctl status firewalld`

*Always reload after any changes made with the `firewall-cmd` command or otherwise*

- `firewall-cmd --reload`

*Note, using more than one IPv4 network interface requires IP forwarding*

| **Turn on IP forwarding** :# *(not persistent)*

```console
sysctl net.ipv4.ip_forward=1
echo 1 > /proc/sys/net/ipv4/ip_forward
```

| **Turn on IP forwarding** :# *(persistent)*

```console
echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
sysctl -p || reboot
```

  - *The line `net.ipv4.ip_forward=1` probably resides commented in `/etc/sysctl.conf`*

#### Zones
- On most Linux systems, the default is **public**
- *Never use a more open zone than necessary!*
- Read more in the [docs](https://firewalld.org/documentation/zone/predefined-zones.html)

##### Drop
- Incoming packets all dropped
- Outgoing traffic only

##### Block
- Incoming network connection requests are rejected
- Only connections initiated by system are allowed

##### Public
- Do not trust other machines on the network
- Only selected connections are allowed

##### External
- When [masquerading](https://superuser.com/questions/935969) is enabled
- Otherwise same as public

##### DMZ
- For publicly-accessible machines with limited access to the internal network
- Only selected connections are allowed

##### Work
- Generally trust other machines on the network
- Only selected connections are allowed

##### Home
- Generally trust other machines on the network
- Only selected connections are allowed

##### Internal
- Generally trust other machines on the network
- Only selected connections are allowed

##### Trusted
- Trust all machines on the network
- Allow all connections

#### Zone Management
- Get information as a normal user:$
  - `firewall-cmd --help`
  - `firewall-cmd --get-zones`
  - `firewall-cmd --get-default-zone`
  - `firewall-cmd --get-active-zones`
    - *Use interfaces from that output*
    - *Or get available interfaces from:$ `nmcli device status`*
- Deeper access must be done as `root`:#
  - `firewall-cmd --state`
  - `firewall-cmd --reload`
  - `firewall-cmd --zone=public --list-all`
  - `firewall-cmd --set-default-zone=dmz`
  - `firewall-cmd --zone=internal --change-interface=enp2s0`
  - `firewall-cmd --zone=internal --change-interface=enp2s0 --permanent`
  - `firewall-cmd --get-zone-of-interface=enp2s0`
  - `firewall-cmd --zone=trusted --add-source=192.168.0.0/24 --permanent`
  - `firewall-cmd --zone=trusted --list-sources=192.168.0.0/24 --permanent`
  - `firewall-cmd --remove-source==192.168.0.0/24 --permanent`
  - `firewall-cmd --list-services --zone=public`
  - `firewall-cmd --zone=external --add-service=ssh --permanent`
  - `firewall-cmd --zone=external --remove-service=ssh --permanent`
- `man firewall-cmd`

#### Source Address Management
- Zones are bound to a **source**:
  - A network interface
  - An incomine IP address 
- Packet association priority:
  1. Source address bound to zone
  2. Source interface bound to zone
  3. Default zone
- Assign zone to interface device **source**
  - (`enp2s0` or any device found via `nmcli device status`)
  - `firewall-cmd --zone=dmz --change-interface=enp2s0 --permanent`
  - `firewall-cmd --zone=internal --change-interface=enp2s0 --permanent`
- Assign zone to IP address **source**
  - `firewall-cmd --zone=work --add-source=192.168.0.0/24 --permanent`
- List sources bound to a zone
  - `firewall-cmd --zone=dmz --list-sources --permanent`

#### Services in Zones
- List available services
  - `firewall-cmd --get-services`
  - Output will list services you can add to a zone with `--add-service=`
- List services bound to a zone
  - `firewall-cmd --list-services --zone=public`
  - Output may return more than one service
- Add/remove a service to a zone
  - `firewall-cmd --zone=external --add-service=ssh --permanent`
  - `firewall-cmd --zone=block --remove-service=smtp --permanent`
- Or edit the config files:
  - `firewalld/services/*.xml`

#### Port Management
- Add/remove a port to a zone
  - `firewall-cmd --zone=work --add-port=21/tcp`
  - `firewall-cmd --zone=work --remove-port=21/tcp`
- List ports bound to a zone
  - `firewall-cmd --zone=work --list-ports`
- Serviced ports are listed in `/etc/services`
  - `grep "21/tcp" /etc/services`

#### Port Redirection
- Add/remove forwarding all port `80` traffic to `8080`
  - `firewall-cmd --zone=work --add-forward-port=port=80:proto=tcp:toport=8080`
  - `firewall-cmd --zone=work --remove-forward-port=port=80:proto=tcp:toport=8080`
- List all forwarded ports
  - `sudo firewall-cmd --zone=work --list-forward`

#### Network Address Translation (NAT)
*Changes source or destination addresses of packets passing in or out through the firewall*

##### Destination NAT (DNAT)
- *Governs in-bound packets*
- *Alters "to" IP address*
- *May alter the port*
- *Usually in pre-routing chain of NAT table*
- Workflow:
  - Packet sent to public IP address based on public DNS records
  - Public IP address is the same as the firewall
  - Change the "to" destination so the packet can move throug the firewall to where it should go
  - The web server then accepts processes the packet for any appropriate response
- Firewall rules for incoming packets:
  - Destination IP address is the firewall's public-facing adapter
  - Port is for the correct service
  - Change destination IP to the web server behind the firewall
  - Forward the packet to that IP address behind the firewall
  - Host machine behind the wall accepts, processes, and replies to the packet

##### Source NAT (SNAT)
- *Governs out-bound packets*
- *Alters "from" IP address*
- *Protects the internal network from the Internet*
- *Comensates for the non-routable nature of most internal networks being private*
- ***Masquerade** implements SNAT for DHCP*
  - *On a DHCP-created outbound interface address, Masquerade implements the SNAT public IP address*
  - *On a statick outbound interface address, SNAT specifies the public IP address without Masquerade*
- *Usually in the post-routing chain of the NAT table*
- Workflow:
  - Packet is addressed to the IP of the remote system
  - Change the "from" source IP address to the firewall's public-facing adapter

___

# The Keys
*Practice commands for SysAdmins who already know what these mean*

- These could be run on a local work machine or on machines in a [hybervisor's virtual network](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/VirtualBox.md#Networking) like the one used in [Lesson 9](https://github.com/inkVerb/vip/blob/master/601/Lesson-09.md)

```console
man firewall-cmd
firewall-cmd --help

systemctl start firewalld
systemctl status firewalld

firewall-cmd --state
firewall-cmd --get-zones
firewall-cmd --get-default-zone

sudo firewall-cmd --set-default-zone=dmz
firewall-cmd --get-default-zone
sudo firewall-cmd --set-default-zone=public
firewall-cmd --get-default-zone

firewall-cmd --get-active-zones
nmcli device status
# Note the interface outputs, these are used instead of `enp2s0`

sudo firewall-cmd --state
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --list-all
sudo firewall-cmd --zone=trusted --list-all

sudo firewall-cmd --zone=internal --change-interface=enp2s0
sudo firewall-cmd --zone=internal --change-interface=enp2s0 --permanent
sudo firewall-cmd --get-zone-of-interface=enp2s0

sudo firewall-cmd --zone=trusted --add-source=192.168.0.0/24
sudo firewall-cmd --zone=trusted --list-sources
sudo firewall-cmd --zone=trusted --add-source=192.168.1.0/24 --permanent
sudo firewall-cmd --zone=trusted --list-sources --permanent
sudo firewall-cmd --zone=trusted --list-sources

sudo firewall-cmd --zone=trusted --remove-source=192.168.1.0/24 --permanent
sudo firewall-cmd --zone=trusted --list-sources --permanent
sudo firewall-cmd --zone=trusted --remove-source=192.168.0.0/24
sudo firewall-cmd --zone=trusted --list-sources

sudo firewall-cmd --zone=public --list-services
sudo firewall-cmd --zone=external --add-service=ssh --permanent
sudo firewall-cmd --zone=public --list-services
sudo firewall-cmd --zone=external --remove-service=ssh --permanent
sudo firewall-cmd --zone=public --list-services

sudo firewall-cmd --zone=work --list-ports
sudo firewall-cmd --zone=work --add-port=21/tcp
sudo firewall-cmd --zone=work --list-ports
sudo firewall-cmd --zone=work --remove-port=21/tcp
sudo firewall-cmd --zone=work --list-ports

sudo firewall-cmd --zone=work --list-forward
sudo firewall-cmd --zone=work --add-forward-port=port=80:proto=tcp:toport=8080
sudo firewall-cmd --zone=work --list-forward
sudo firewall-cmd --zone=work --remove-forward-port=port=80:proto=tcp:toport=8080
sudo firewall-cmd --zone=work --list-forward
```

___

#### [Lesson 11: Security Modules](https://github.com/inkVerb/vip/blob/master/601/Lesson-11.md)
