# Mail Servers

Use this guide to understand, verify, or troubleshoot a Postfix-Dovecot mail server.

In this article, our mail server is whatever hosts `mail.maildomain.tld`, where the Postfix, Dovecot, and port settings need to be.

## Overview: Postfix-Dovecot vmail
### Mail Quintet: Five main services

A common Linux mail server uses Postfix and Dovecot for SQL-managed vmail. These email accounts are not actual Linux users on the server (as they are in pure, vanilla email). They are stored in an SQL database, along with hashed passwords, forward, and name information. The actual mail resides in a `vmail/` folder often in `/var/` or `/srv`.

In this configuration, at least five different services talk to each other:

- `postfix` - sending and receiving mail
- `dovecot` - serving email user inboxes and managing folders
- `spamassassin` - filtering mail and running various checks
- `opendkim` - signing and validating outgoing emails (one spam check of many from receiving mail servers)
- `mariadb` (or `mysql` or other SQL) - where `spamassassin` keeps records and `postfix` & `dovecot` hold email address/login information in standardized tables and columns
- Plus various certificates, signed keys, and ports to glue connection security in place

All of these have different settings that list each other and define how they expect to behave together. Setting this up can be daunting at first; just remember they all are basically talking to each other.

Note:

- Many of these services have "plugins", which are usually included in the packages and don't need to be installed separately. These plugins are merely activated or disabled in the various settings files.
- These five services are just the main backbone of the mail quintet. There may be other packages and services you want to run that affect mail, including `ufw`, `monit`, `vind`, `systemd-resolved`, `letsencrypt`, `apache` and/or `nginx` (below), add-on packages, more security, etc.
- A mail server like this constantly talks to other mail servers much like this. Check the server's health both ways: test the world from your server and test your server from the world.

### Web app enhancement

Two web apps are common to empower a Postfix-Dovecot vmail server:

- [PostfixAdmin](https://postfixadmin.github.io/postfixadmin/) - manage email accounts in the SQL mail database via web GUI
- [Roundcube](https://roundcube.net/) - webmail

The vmail users can be added to the vmail database manually, but one common tool for managing the standard vmail database is the PHP web app [PostfixAdmin](https://postfixadmin.github.io/postfixadmin/).

For convenience, many people also use [Roundcube](https://roundcube.net/) as a webmail client to access the vmail accounts created by [PostfixAdmin](https://postfixadmin.github.io/postfixadmin/).

If using these web tools, you will also need to set up Apache on the server. Nginx is also an option, and an Nginx-Apache reverse proxy server also works like a charm once properly tuned.

### Creating such a mail server

There are many tutorials on such mail servers, for example:

- [Arch Linux Wiki: Virtual user mail system with Postfix, Dovecot and Roundcube](https://wiki.archlinux.org/title/Virtual_user_mail_system_with_Postfix,_Dovecot_and_Roundcube).
- [Vultr: How to Install Postfix, Dovecot, and Roundcube on Ubuntu 20.04](https://www.vultr.com/docs/how-to-install-postfix-dovecot-and-roundcube-on-ubuntu-20-04/)
- [inkVerb/verb](https://github.com/inkverb/verb) (beta, author of this article) installs such a server automatically.

This article goes through evaluating and testing such a server. There is much to learn about servers in general along the way.

### Config file locations

There are too many config files to list all here. This is a nice start...

- Postfix: `/etc/postfix/`
  - `main.cf` & `master.cf` (primary configs)
    - `main.cf` sets defaults
    - `master.cf` uses `-o` options to override defaults from `main.cf`
  - `virtual_*` (SQL info for vmail)
- Dovecot: `/etc/dovecot/`
  - `dovecot.conf` (main config)
  - `dovecot-sql.conf.ext` (SQL info for vmail)
  - `conf.d/` (all included from `dovecot.conf` settings files, named for human readability)
  - `seive*` (the main filter for Dovecot automatically moving emails around in folders and other workflow)
    - Many custom tweaks to a mail server are written by your own `seive` plugin, search the Internet for more
- SpamAssassin: `/etc/mail/spamassassin/`
  - `local.cf` (main config, including SQL)
  - `v*.pre` (files that only apply setings based on the current version)
- OpenDKIM: `/etc/opendkim/`
  - `opendkim.conf` (primary configs)
  - Key organizing: (different files with keys and matching domains tables)
    - `KeyTable`
    - `SigningTable`
    - `TrustedHosts`
    - `keys/`
- System configs: `/etc/systemd/`
  - Some subtle-important services are configured here, including spamassassin's updater, and the DNS resolver (used by Postfix to find and verify other mail servers via their domains)
- Service ports: `/etc/services`
  - If you have any port problems, a simple search here should show whether a service is listed with what port

## Services

Use `systemctl` to check the status of the services used by most Postfix/Dovecot mail servers

| **Check service status** :# (for `postfix` service)

```console
systemctl status postfix
```

<kbd>Q</kbd> to quit

Look for `enabled` and green lights around `Actice: actice (running)` and `postfix.service`.

| **Check other mail services** :# (Dovecot, SpamAssassin, OpenDKIM, SQL, etc)

```console
systemctl status dovecot
```

```console
systemctl status spamassassin
```

```console
systemctl status opendkim
```

Databases are also used by the mail server, especially for `spamassassin` and if you're using vmail. (`mariadb` or `mysql` with some)

```console
systemctl status mariadb
```

While those cover the usual suspects, there may be other services affecting your server, depending on your mailserver configuration...

- `nginx` (affects webmail and PostfixAdmin)
- `httpd` or `apache2` (affects webmail and PostfixAdmin)
- `named` (if you are running bind)

## Ping the server

Check to see if the server responds to `ping`...

Check the mail server from another machine, not on the mail server itself!

| **Ping mail server** :$ (`-c 1` for only one iteration, not continuous pinging)

```console
ping -c 1 mail.maildomain.tld
```

If that fails, ensure your machine is connected to the Internet

| **Ping the inkisaverb.com server** :$ (just for Internet test)

```console
ping -c 1 inkisaverb.com
```

## DNS records

DNS records need to be entered correctly. For `maildomain.tld`, you will need:

| **maildomain.tld** : DNS Zone file contains...

```
maildomain.tld.        IN MX    50   mail.maildomain.tld.       ; Usually 5 or 50, only matters with multiple mail servers for same domain
mail.maildomain.tld.   IN A          ip4.add.ress.here.
mail.maildomain.tld.   IN AAAA       ip6:lon:ger:add:ress::here.
```

Install `dig` and `nslookup` in the `bind` package...

| **Arch/Manjaro** :$

```console
sudo pacman -Sy dnsutils
```

| **Debian/Ubuntu** :$

```console
sudo apt install dnsutils
```

| **CentOS/Fedora** :$

```console
sudo dnf install bind-utils
```

Servers use a "resolver" to find domains. Make sure each machine's resolver can find the domains used to send and receive mail.

### On a different machine, check your mail server DNS records

| **Check nameserver** :$ `nslookup`

```console
nslookup maildomain.tld
```

You should get a few lines with various, correct domain and IP information.

You have a problem if you receive: `server can't find sendingdomain.tld`

- If you can't find just one specific domain, it could be a DNS record problem with that domain
- If you can't find multiple domains from the mail server, but you can find them from other machines, then you may have a problem with the server's DNS resolver; search the Internet for answers.

| **Check MX record** :$ `dig`

```console
dig maildomain.tld MX
```

...should show `MX` record for: `maildomain.tld. ... IN MX mail.maildomain.tld.`

| **Check A record** :$ `dig`

```console
dig mail.maildomain.tld A
```

...should show `A` record for: `mail.maildomain.tld. ... IN A ip4.add.ress.here.`

| **Check AAAA record** :$ `dig`

```console
dig mail.maildomain.tld AAAA
```

...should show `AAAA` record for: `mail.maildomain.tld. ... IN AAAA ip6:lon:ger:add:ress::here.`

### On the mail server itself, check if the "sending from" address can be found

Like on a different server, check that the mail server can resolve the sending domain

| **Check nameserver** :$ `nslookup`

```console
nslookup sendingdomain.tld
```

| **Check MX record** :$ `dig`

```console
dig sendingdomain.tld MX
```

| **Check A record** :$ `dig`

```console
dig mail.sendingdomain.tld A
```

| **Check AAAA record** :$ `dig`

```console
dig mail.sendingdomain.tld AAAA
```

## SSL settings

SSL certs are used for TLS connections. The difference is in how the certificate is used, not in the certificate itself.

On the mail server, verify that SSL cert settingss are properly in place for Postfix and Dovecot.

Open these files with an editor like `vim` or `nano`...

| **/etc/postfix/main.cf** :

```
smtpd_tls_chain_files = /file/must/exist/and/be/correct.key, /file/must/exist/and/be/correct.crt
```

| **/etc/dovecot/conf.d/10-ssl.conf** :

```
ssl_cert = </file/must/exist/and/be/correct.crt
ssl_key = <file/must/exist/and/be/correct.key
ssl_dh = </etc/dovecot/dh.pem
```

## Ports

Postfix and Dovecot use various ports

| Protocol | Port | Service | Security   | STARTTLS command | Use           | Firewall Port | Purpose                   |
|:---------|:-----|:--------|:-----------|:-----------------|:--------------|:--------------|:--------------------------|
| smtp     | 25   | Postfix | None       | Unsupported      | Not clients   | Allow         | Server-to-Server Delivery |
| smtps    | 465  | Postfix | TLS or SSL | Unsupported      | Legacy        | Block         | Send from client          |
| smtp     | 587  | Postfix | TLS or SSL | Required         | Preferred     | Allow         | Send from client          |
| smtp     | 2525 | Postfix | TLS or SSL | Required         | If 587 closed | Situational   | Send from client          |
|          |      |         |            |                  |               |               |                           |
| imap     | 143  | Dovecot | None/Text  | Supported        | Legacy        | Block         | Mailbox Sync              |
| imaps    | 993  | Dovecot | TLS or SSL | Required         | Preferred     | Allow         | Mailbox Sync              |
|          |      |         |            |                  |               |               |                           |
| pop3     | 110  | Dovecot | None/Text  | Supported        | Legacy        | Block         | Mailbox Fetch             |
| pop3s    | 995  | Dovecot | TLS or SSL | Required         | Preferred     | Allow         | Mailbox Fetch             |

Generally, never use: `465`/`smtps`, `110`, `143`

Keep `25` open, but not for clients. We still need it for the server to send and receive mail with other mail servers.

Best practice is to use these:

| Protocol | Port | Service | Security   | STARTTLS command | Use           | Firewall Port | Purpose                   |
|:---------|:-----|:--------|:-----------|:-----------------|:--------------|:--------------|:--------------------------|
| smtp     | 25   | Postfix | None       | Unsupported      | Not clients   | Allow         | Server-to-Server Delivery |
| smtp     | 587  | Postfix | TLS or SSL | Required         | Preferred     | Allow         | Send from client          |
| imaps    | 993  | Dovecot | TLS or SSL | Required         | Preferred     | Allow         | Mailbox Sync              |
| pop3s    | 995  | Dovecot | TLS or SSL | Required         | Preferred     | Allow         | Mailbox Fetch             |

Check the ports on the mail server...

Install `netstat` in the `net-tools` package...

| **Arch/Manjaro** :$

```console
sudo pacman -Sy net-tools
```

| **Debian/Ubuntu** :$

```console
sudo apt install net-tools
```

| **CentOS/Fedora** :$

```console
sudo dnf install net-tools
```

| **List all ports listening** :$

```console
netstat -tuplen 
```

Or list specific ports as `DROP` (blocked/closed) or `ACCEPT` (allowed/open)...

```console
iptables -nL 
```

| **Filter STDOUT to contain the port for 25** :$ (can be any port number)

```console
netstat -tuplen | grep :25
```

Or...

```console
iptables -nL | grep 25
```

Some results should show. If not then it isn't listening.

Also look in `/etc/services`...

| **Search services** :$

```console
cat /etc/services | grep 25
```

Do that for each port...

Should list (open): `25`, `587`, `993`, `995`

Should not list (closed): `110`, `143`, `465`

| **Open port 25 in the firewall** :$ (can be any port number)

```console
ufw allow 25
```

| **Block port 110 in the firewall** :$ (can be any port number)

```console
ufw deny 110
```

## Send a test mail

Send a test email from the server with `sendmail`

| **Send test mail** :$ (can be any email address)

```console
sendmail youremail@example.com
```

Enter lines like these...

```console
Subject: Test Send Mail
Hello World
```

Or with more header options...

```console
To: differentemail@example.com
From: anyone@example.com
Subject: Test Send Mail
Hello World
```

<kbd>Ctrl</kbd> + <kbd>D</kbd> to finish and send the email

If you don't use a `From:` line, the juser will be your Linux user and the host.

## Connect with `telnet`

Connect directly from the terminal with `telnet`

| **Connect** :$ (can be any port number)

```console
telnet mail.maildomain.tld 25
```

A `220` response is healthy and means the connection is working.

## Mail Queue

Mail processes in a queue

If you need to clean out the mail queue, here are some useful tools:

- Postfix: `mailq | awk '$7~/@/{print$1}' | while read qid; do postsuper -d $qid; done`
  - The operative command is: `postsuper -p`
  - From [ServerFault](https://serverfault.com/questions/1047113)

## Logs

Monitor logs:

- For sending and receiving
- From your mail server and another mail server sending to/from

Find the location of your mail log file, usually in `/var/mail/...`

| **Search maillog file** :$ (Usually at `/var/log/maillog` on Arch Linux)

```console
grep maillog_file /etc/postfix/main.cf
```

Output is something like...

```console
maillog_file = /var/log/maillog
```

The file is enormous and constantly updates, `vim` will need to reload; `cat` will overwhelm your reviewable terminal.

Use `tail` for most recent logs...

| **Monitor maillog file** :$ (follow)

```console
tail -f /var/log/maillog
```

| **Monitor maillog file** :$ (follow 10 lines)

```console
tail -10f /var/log/maillog
```

| **View end of maillog file** :$ (30 lines)

```console
tail -30 /var/log/maillog
```

| **Edit maillog file** :# (for `vim` interaction options)

```console
vim /var/log/maillog
```

### Understanding logs

Some of the most common problems on mail servers come from DNS records and the firewall. We won't guess solutions here, but this is a start to using logs to find answers.

Note, in theory:

- Every line in the mail log represents output from some command you could manually enter in the terminal.
  - They often indicate the service, protocol, port, IP address, or Postfix command (often ALL CAPS) involved, as well as to/from email addresses.
- Every connection to another server could be done manually in the terminal via `telnet`.

- Log: `mail.maildomain.tld...:25: Connection timed out`
  - Try: `telnet mail.maildomain.tld 25` to watch the problem live
    - Search the Internet for answers

- Log: `Domain not found`
  - This indicates a problem with DNS records
    - Look at the full log line and search the Internet for answers

