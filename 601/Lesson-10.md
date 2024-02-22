# Linux 601
## Lesson 10: Firewall

# The Chalk
## Firewall
A network traffic security system

- Monitors and controls
- Incoming and outgoing
- Connections and packets
- Built on hardware or software
- In routers, client machines, any network device
- Protects from intruders
- Enforces trust levels
- Watches interfaces and addresses

### Packet Filtering
Most firewalls filter packets

**Packet** - Protocol Data Unit (PDU) sent in the **Network** layer
- Contains:
  - Header
  - Payload
  - Footer

Packet filtering intercepts packets at many security layers, including:

- Application
- Transport
- Network
- Data/Access

Firewall rules determine whether each packet is:

- Accepted or rejected
- Damaged
- Redirected
- Inspected

### History
1. First generation firewalls were from the late 1980s
  - Filtered only packets, *not the connection*
2. Second generation firewalls used **stateful filters**
  - Evaluate connection: new, existing, none
  - DDoS attacks overwhelm this firewall
3. Third generation fiewalls use the **application layer**
  - Aware of:
    - Application type
    - Protocol

### Interfaces & Tools
#### Low in the Stack
- `firewall-cmd` (Dynamic Firewall Manager, `firewalld` package)
- `ufw` (Uncomplicated Firewall)
- `iptables`
  - More complex
  - Same kernel code as `firewalld`
  - Older than `firewalld`
  - Conflicts with `firewalld`
  - Covered thoroughly elsewhere
- Such tools are:
  - Configured in the `/etc/` directory
  - Managed by the CLI
  - Don't change often
  - Have more capability
  - Consistent across Linux distros
  - Have a steep learning curve

#### GUI
- `firewall-config` (Dynamic Firewall Manager, `firewalld` package)
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
- Uses **zones**
- Configs:
  - `/etc/firewalld/` (override)
  - `/usr/lib/firewalld/` (defaults)

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
- `firewall-cmd --state`
- `firewall-cmd --reload`
- `firewall-cmd --get-default-zone`
- `firewall-cmd --get-active-zones`
- `firewall-cmd --get-zones`
- `firewall-cmd --set-default-zone=dmz`
- `firewall-cmd --set-default-zone=public`
- `firewall-cmd --zone=public --list-all`
- `firewall-cmd --help`
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
  - `firewall-cmd --permanent --zone=dmz --change-interface=enp2s0`
  - `firewall-cmd --permanent --zone=internal --change-interface=enp2s0`
- Assign zone to IP address **source**
  - `firewall-cmd --permanent --zone=work --add-source=192.168.1.0/24`
- List sources bound to a zone
  - `firewall-cmd --permanent --zone=dmz --list-sources`

#### Services in Zones
- List available services
  - `firewall-cmd --get-services`
  - Output will list services you can add to a zone with `--add-service=`
- List services bound to a zone
  - `firewall-cmd --list-services --zone=public`
  - Output may return more than one service
- Add a service to a zone
  - `firewall-cmd --permanent --zone=external --add-service=ssh`
  - `firewall-cmd --permanent --zone=block --remove-service=smtp`
- Or edit the config files:
  - `firewalld/services/*.xml`

#### Port Management
- Add a port to a zone
  - `firewall-cmd --zone=work --add-port=21/tcp`
- List ports bound to a zone
  - `firewall-cmd --zone=work --list-ports`
- Serviced ports are listed in `/etc/services`
  - `grep "21/tcp" /etc/services`

#### Port Redirection
- Forward all port `80` traffic to `8080`
  - `firewall-cmd --zone=work --add-forward-port=port=80:proto=tcp:toport=8080`

#### Network Address Translation (NAT)
##### Destination NAT (DNAT)
- *Governs in-bound packets*
- *Alters "to" IP address*
- *May alter the port*
- *Usually in pre-routing chain of NAT table*
- Workflow:
  - Packet sent to public IP address based on public DNS records
  - Public IP address is the same as the firewall
  - Change the "to" destination so the packet can move throug the firewall to where it should go
- Firewall rules for packets:
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
- *Masquerade is a type of SNAT*
  - *On a DHCP outbound interface, Masquerade implements the SNAT*
  - *On a statick outbound interface, SNAT specifies the public IP address*
- *Usually in the post-routing chain of the NAT table*
- Workflow:
  - Packet is addressed to the IP of the remote system
  - Change the "from" source IP address to the firewall's public-facing adapter

___

#### [Lesson 11: Security Modules](https://github.com/inkVerb/vip/blob/master/601/Lesson-10.md)
