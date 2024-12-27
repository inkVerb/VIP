# LENG Desktop
## Nginx/Go/Node developer environment directly in Arch/Manjaro
*(rather than WAMPP or XAMPP in Windows)*

***This is for your local desktop developer environment only, not secure for production servers!***

***This is only for Arch/Manjaro and installs Nginx!*** *For Apache on Arch/Manjaro or Debian/Ubuntu, see [LAMP Desktop](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/LAMP-Desktop.md)*

***If you are running another Linux architecture, you may need to create a [Virtual Machine](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/VirtualBox.md) with Arch or Manjaro***

### Update

| **0** :$

```console
sudo pacman -Syy
```

### Setup LENG
#### SSL for HTTPS
*Create 10-year self-signed "snakeoil" SSL certificates*

Install OpenSSL

| **E1** :$

```console
sudo pacman -Syy --noconfirm openssl
```

Prepare a place for the certs

| **E2** :$

```console
sudo mkdir -p /etc/ssl/desk
```

Create the 10-year snakeoil certs

| **E3** :$

```console
sudo openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/desk/snakeoil.key.pem -out /etc/ssl/desk/snakeoil.crt.pem -sha256 -days 3650 -nodes -subj "/C=XX/ST=Some State/L=Some City/O=Snakeoil/OU=Learning/CN=myComputer"
```

Create a small [Diffie-Hellman Group](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange) file for how most of us should do security these days

| **E4** :$ (Nginx thinks anything less than `2048` is too small and it will refuse to start; production servers may need `4096` or higher)

```console
sudo openssl dhparam -out /etc/ssl/desk/dhparams.pem 2048
sudo chmod 600 /etc/ssl/desk/dhparams.pem
```

#### Nginx

Install Nginx

| **E4** :$

```console
sudo pacman -Syy --noconfirm nginx
```

Prepare configs

| **E5** :$

```console
sudo mkdir -p /etc/nginx/conf.d /etc/nginx/enabled.d
```

Backup the old main config

| **E6** :$

```console
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
```

Create the web user

*A time may come when you depend on the `http` user for Nginx, but we want the main user to be `www` because that's just smart, so...*

| **E7** :$

```console
sudo useradd -g www www
sudo usermod -a -G www http
sudo mkdir -p /srv/www/html
sudo chmod u+w /srv/www
sudo chmod u+w /srv/www/html
sudo chown -R www:www /srv/www
```

*If you don't know how to use `vim`, then replace it with `nano` or `gedit` in `vim` commands...*

Create the new main config

| **E8** :$

```console
sudo vim /etc/nginx/nginx.conf
```

| **`nginx.conf`** :

```
user http;
worker_processes auto;
worker_cpu_affinity auto;

events {
    multi_accept on;
    worker_connections 1024;
}

http {
    server_names_hash_max_size 1024;
    server_names_hash_bucket_size 128;
    charset utf-8;
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    server_tokens off;
    log_not_found off;
    types_hash_max_size 4096;
    client_max_body_size 1000M;

    # Global SSL
    ssl_prefer_server_ciphers on;
    ssl_ciphers ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_dhparam /etc/ssl/desk/dhparams.pem;

    # MIME
    include mime.types;
    default_type application/octet-stream;

    # logging
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log warn;

    # load configs
    include /etc/nginx/enabled.d/*.conf;
}
```

##### Basic Text/HTML
*Note any files in the `/srv/www/html/` directory will need to be owned by `www` using:*
- *`sudo chowon -R www:www /srv/www/html/`*

Create the config for Text/HTML over http

| **E9** :$

```console
sudo vim /etc/nginx/conf.d/htmlhttp.conf
```

| **`htmlhttp.conf`** :

```
server {
  listen 80;
  listen [::]:80;
  server_name localhost;

  root /srv/www/html;
  index index.html;

  location / {
    try_files $uri $uri/ =404;
  }

  types {
    text/plain text;
    text/html html;
  }
}
```

Create the config for Text/HTML over https

| **E10** :$

```console
sudo vim /etc/nginx/conf.d/htmlhttps.conf
```

| **`htmlhttps.conf`** :

```
server {
  listen 443 ssl;
  listen [::]:443 ssl;
  http2 on;
  server_name localhost;

  ssl_certificate      /etc/ssl/desk/snakeoil.crt.pem;
  ssl_certificate_key  /etc/ssl/desk/snakeoil.key.pem;

  root /srv/www/html;
  index index.html;

  location / {
    try_files $uri $uri/ =404;
  }

  types {
    text/plain text;
    text/html html;
  }
}
```

##### Reverse proxy
*These are mainly used to point browser and web traffic to another internal server, such as:*
- *An apache server, to use `RewriteMod` such as with PHP*
- *Go app*
- *Node.js app*
- *Python app*

*Such internal servers will listen on some port (as their programming will set); we will use `9001`*

Create the config for reverse proxy over http

| **E11** :$

```console
sudo vim /etc/nginx/conf.d/rphttp.conf
```

| **`rphttp.conf`** :

```
server {
  listen 80;
  listen [::]:80;
  server_name localhost;

  location / {
    proxy_pass http://127.0.0.1:9001;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_hide_header Upgrade;
  }
}
```

Create the config for reverse proxy over https

| **E12** :$

```console
sudo vim /etc/nginx/conf.d/rphttps.conf
```

| **`rphttps.conf`** :

```
# HTTPS port 443
server {
  listen 443 ssl;
  listen [::]:443 ssl;
  http2 on;
  server_name localhost;

  ssl_certificate      /etc/ssl/desk/snakeoil.crt.pem;
  ssl_certificate_key  /etc/ssl/desk/snakeoil.key.pem;

  location / {
    proxy_pass http://127.0.0.1:9001;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_hide_header Upgrade;
  }
}

# Redirect HTTP port 80 to HTTPS port 443
server {
  listen 80;
  listen [::]:80;
  server_name localhost;
  
  return 301 https://$host$request_uri;
}
```

*To enable any site, create a link to the `include` directory from `nginx.conf`: `/etc/nginx/enabled.d/`*

- *We will enable only the reverse proxy for https in this situation*
- *Any of the created sites would work*
- *Because they all listen to `localhost`, only one of these should be used at a time*
  - *This is why we always create the symlink to `active.conf` regardless of the original `.conf` file, so only one works at a time*

Enable only the reverse proxy for http Nginx config

| **E13** :$

```console
sudo ln -sfn /etc/nginx/conf.d/rphttp.conf /etc/nginx/enabled.d/active.conf
```

Turn on the Nginx service

| **E14** :$

```console
sudo systemctl start nginx
```

##### Nginx config reference
*Here is an wasy list of commands to enable the different sites*

- Text/HTML HTTP: `http://localhost`

```console
sudo ln -sfn /etc/nginx/conf.d/htmlhttp.conf /etc/nginx/enabled.d/active.conf
```

- Text/HTML HTTPS: `https://localhost`

```console
sudo ln -sfn /etc/nginx/conf.d/htmlhttps.conf /etc/nginx/enabled.d/active.conf
```

- *Own the web directory: (for Text/HTML service)*

```console
sudo chown -R www:www /srv/www/html
```

- Reverse proxy HTTP: `http://localhost`

```console
sudo ln -sfn /etc/nginx/conf.d/rphttp.conf /etc/nginx/enabled.d/active.conf
```

- Reverse proxy HTTPS: `https://localhost`

```console
sudo ln -sfn /etc/nginx/conf.d/rphttps.conf /etc/nginx/enabled.d/active.conf
```

When you need, restart the Nginx service

| **Restart Nginx** :$

```console
sudo systemctl restart nginx
```

When you need, stop the Nginx service

| **Stop Nginx** :$

```console
sudo systemctl stop nginx
```

#### Open-SSL self-signed certs
*So SSL can be running for your `localhost` developer environment*

### Servers & Server-Side
#### Node.js Server

| **NGP1** :$

```console
sudo pacman -Syy --noconfirm nodejs
```

*Node Version Manager & Node Package Manager*

*(We may not use these in our lessons, but they can be useful for more extensive development with Node.js)*

| **NGP2** :$

```console
sudo pacman -Syy --noconfirm nvm npm
```

#### Go Compiler

| **NGP3** :$

```console
sudo pacman -Syy --noconfirm go
```

#### Python

| **NGP4** :$

```console
sudo pacman -Syy --noconfirm python
```

### Databases
#### SQLite install & setup
*See [SQLite official site](https://www.sqlite.org/)*

1. Install SQLite

| **L1** :$

```console
sudo pacman -Syy --noconfirm sqlite 
```

2. Install a handy-dandy browser tool written in Qt

| **L2** :$

```console
sudo pacman -S --noconfirm sqlitebrowser
```

- Run the browser:
  - From terminal with `sqlitebrowser &`
  - Search "**sqlitebrowser**" in desktop apps

##### SQLite reference
*SQLite stores databases in files; **naming a database names the file and its location***

- Open the terminal

```console
sqlite3
```

- Create and use a databse file:

```console
sqlite3 /path/to/newdatabase
```

- Create and use a databse file in the `PWD`:

```console
sqlite3 newdatabase
```

- Exit the terminal: (or <kbd>Ctrl</kbd> + <kbd>D</kbd>)

```console
.quit
```

- Help in the terminal:

```console
.help
```

- Drop a database: *delete the actual database file*


#### MySQL/MariaDB install & setup
*See [MariaDB official site](https://mariadb.org/)*

1. Install MariaDB

| **M1** :$

```console
sudo pacman -Syy --noconfirm mariadb 
```

2. MariaDB setup *before starting the service*

| **M2** :$

```console
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
```

3. Access MySQL as root user with

| **M3** :$

```console
sudo mariadb
```

4. Create a database admin user in MySQL with: (user: `admin` password: `adminpassword`)

| **M4** :>

```console
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;
```

| **M5** :>

```console
FLUSH PRIVILEGES;
```

5. Exit MySQL

| **M6** :>

```console
QUIT;
```

#### PostgreSQL install & setup
*See [PostgreSQL official site](https://www.postgresql.org/)*

1. Install Postgres

| **P1** :$

```console
sudo pacman -Syy --noconfirm postgresql 
```

2. Postgres setup *before starting the service*

| **P2** :$

```console
sudo su postgres -c "initdb --locale=C.UTF-8 --encoding=UTF8 -D /var/lib/postgres/data --data-checksums"
```

##### PostgreSQL reference

- Start the service so we can use the `psql` tool

```console
sudo systemctl start postgresql
```

- Access the `postgres` user
  - *Most PostgreSQL commands are run from the `postgres` system user*

```console
sudo su postgres
```

- **Commands below are for use by the Linux sudoer, not the `postgres` user**
  - *Most PostgreSQL commands will not use these, but the `postgres` user*
  - *Commands below are for SysAdmin reference, such as creating PostgreSQL credentials to be used with a database*

- Create a database and user: (must be run as two separate commands)

```console
psql -U postgres -c "CREATE DATABASE somedb;"
psql -U postgres -c "CREATE ROLE someuser WITH PASSWORD 'somepassword'; GRANT ALL PRIVILEGES ON DATABASE somedb TO someuser;"
```

- Access Postgres with that database as a root Postgres user:

```console
sudo su postgres -c "psql -d somedb"
```

- Create a PostgreSQL admin user: (user: `admin` password: `adminpassword`)
  - *You cannot login without specifying a database, but any database may be used with this user*

```console
psql -U postgres -c "CREATE ROLE admin WITH PASSWORD 'adminpassword'; GRANT ALL PRIVILEGES ON DATABASE postgres TO admin WITH GRANT OPTION;"
```

#### MongoDB install & setup
*See [MongoDB official site](https://www.mongodb.com/)*

1. Install MongoDB from the AUR (choose one)

| **J1u** :$ use the Ubuntu-compiled binary (compile options unknown)

```console
yay -Syy --noconfirm mongodb-bin
```

| **J1c** :$ compiled on your machine (may take a long time or have issues)

```console
yay -Syy --noconfirm mongodb
```

2. Enable the MongoDB service

| **J2** :$

```console
sudo systemctl enable mongodb
```

3. Install the MongoDB shell (`mongosh` tool)

| **J3** :$

```console
yay -Syy --noconfirm mongosh-bin
```

4. Install MongoDB Compass, a handy-dandy GUI

| **J4** :$

```console
yay -Syy --noconfirm mongodb-compass
```

5. Configure MongoDB

| **J5** :$

```console
sudo vim /etc/mongodb.conf
```

Ensure it reflects the following:

| **`mongodb.conf`** : (using `localhost` & port `27017`)

```
systemLog:
  destination: file
  logAppend: true
  path: "/var/log/mongodb/mongod.log"
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true
processManagement:
  fork: true
  timeZoneInfo: /usr/share/zoneinfo
net:
  port: 27017
  bindIp: 127.0.0.1
setParameter:
  enableLocalhostAuthBypass: false

# Dev-shell use; may not be suited for a production server
security:
  authorization: "enabled"
```

##### MongoDB reference

- Start the service so we can use the `mongosh` shell tool

```console
sudo systemctl start mongodb
```

- Use the MongoDB shell tool

```console
mongosh
```

- Create an admin user from the shell

```console
use admin
db.createUser(
  {
    user: "myUserAdmin",
    pwd: "abc123",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
  }
)
```

### Code-OSS
#### OPTIONAL: Install [Code OSS](https://code.visualstudio.com/)
*(If you haven't already)*

| **Install** :$

```bash
sudo pacman -Syy code
```

| **Code-OSS settings** :$

```bash
code --install-extension emroussel.atomize-atom-one-dark-theme
code --install-extension opensumi.opensumi-default-themes
code --install-extension PenumbraTheme.penumbra
code --install-extension timonwong.shellcheck
code --enable-proposed-api timonwong.shellcheck
```

- May want to add these to *File > Preferences > Settings > Extensions > ShellCheck > Exclude:*

```console
SC2076,SC2016,SC1090,SC2034,SC2154,SC1091,SC2206,SC2086,SC2153,SC2231
```

#### Code-OSS extensions

*Code-OSS already has native support for **Node.js**, but a few other languages need extensions for the syntax highlighting*

| **Go** :$

```console
code --install-extension ms-vscode.go
```

| **Python** :$

```console
code --install-extension ms-python.python
code --install-extension ms-python.debugpy
```

| **MongoDB** :$

```console
code --install-extension mongodb.mongodb-vscode
```

| **SQLTools** :$ (All SQL languages below need this)

```console
code --install-extension mtxr.sqltools
```

| **MariaDB/MySQL** :$

```console
code --install-extension mtxr.sqltools-driver-mysql
```

| **SQLite** :$

```console
code --install-extension mtxr.sqltools-driver-sqlite
```

| **PostgreSQL** :$

```console
code --install-extension mtxr.sqltools-driver-pg
```
