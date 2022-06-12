# LAMP Desktop
## PHP/MySQL developer environment directly in Manjaro, Ubuntu, or CentOS
*(rather than WAMPP or XAMPP in Windows)*

***This is for your local desktop developer environment only, not secure for production servers!***

***This installs Apache!*** *For Nginx on Arch/Manjaro, see [LEMP Desktop](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/LEMP-Desktop.md)*

___

Web server settings differ on different distros (Arch, CentOS & Ubuntu)

These instructions have an option standardize the web user to `www`

Below are the standard web ownership commands for the three main Linux distros:

- Arch/Manjaro

```console
sudo chown -R http:http /srv/www
```

- Debian/Ubuntu

```console
sudo chown -R www-data:www-data /var/www
```

- CentOS/Fedora

```console
sudo chown -R apache:apache /var/www
```

## Arch/Manjaro

### Update

| **A0** :$

```console
sudo pacman -Syy
```

### Setup LAMP

#### Install

1. Install the LAMP server

| **A1** :$

```console
sudo pacman -S --noconfirm apache php php-apache mariadb
```

2. Turn on the PHP-MySQL functionality in your `php.ini` file

Edit with `gedit`:

| **A2g** :$

```console
sudo gedit /etc/php/php.ini
```

  - Search with: <kbd>Ctrl</kbd> + <kbd>F</kbd>, then type `mysqli` to find the line, <kbd>Ctrl</kbd> + <kbd>S</kbd> to save

Or edit with `vim`:

| **A2v** :$

```console
sudo vim /etc/php/php.ini
```

  - Search by typing: `/something_to_search`, then Enter to find the line, type `:wq` to save and quit

In php.ini:

  - Uncomment & set values (remove the semicolon `;` at the start of the line)
    - `extension=mysqli`
    - `extension=pdo_mysql`
    - `extension=iconv`
    - `upload_max_filesize = 10M`
	- `file_uploads = On`

3. MariaDB setup

| **A3** :$

```console
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
```

4. Enable MySQL (MariaDB)

| **A4** :$

```console
sudo systemctl enable mariadb
```

5. Restart MySQL (MariaDB)

| **A5** :$

```console
sudo systemctl start mariadb
```

6. Apache settings

Edit with `gedit`:

| **A6g** :$

```console
sudo gedit /etc/httpd/conf/httpd.conf
```

  - Search with: <kbd>Ctrl</kbd> + <kbd>F</kbd>, <kbd>Ctrl</kbd> + <kbd>S</kbd> to save

Or edit with `vim`:

| **A6v** :$

```console
sudo vim /etc/httpd/conf/httpd.conf
```

  - Search by typing: `/`..., type `:wq` to save and quit

a. Enable modules:

  - Reverse the commenting so these lines to look like this:

  ```
  #LoadModule mpm_event_module modules/mod_mpm_event.so
  ...
  LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
  LoadModule http2_module modules/mod_http2.so
  LoadModule rewrite_module modules/mod_rewrite.so
  ```

  - Add these lines at the end:

  ```
  LoadModule php_module modules/libphp.so
  AddHandler php-script .php
  Include conf/extra/php_module.conf
  Protocols h2 http/1.1
  ```

b. Web directory settings

  - Find `DocumentRoot "/srv/http"` replace it and `<Directory...` contents to look like this:
    ```
    DocumentRoot "/srv/www/html"
    <Directory "/srv/www/html">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    </Directory>
    ```

  ...or for expanded options...
    ```
    DocumentRoot "/srv/www/html"
    <Directory "/srv/www/html">
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Require all granted
    Order allow,deny
    allow from all
    </Directory>
    ```

7. Restart the Apache server

| **A7** :$

```console
sudo systemctl restart httpd
```

8. Apache service: always or only when using?

- Choose A or B:

A. Start Apache only once

*(You will need to run this command each time you start lessons after reboot)*

| **A8e** :$

```console
sudo systemctl start httpd
```

B. Make Apache a service to always run

| **A8s** :$

```console
sudo systemctl enable httpd
sudo systemctl start httpd
```

*(Later, you can turn this off with:)*

| **Disable Apache service** :$

```console
sudo systemctl disable httpd
sudo systemctl stop httpd
```

*FYI...*

| **Check for specific errors in Apache server configs** :$

```console
sudo apachectl -t
```

| **Check for Apache users and Settings** :$

```console
sudo apachectl -S
```

#### Change the web user & group to `www`

1. Create the `www` user

| **AW1** :$

```console
sudo groupadd www
```

2. Create the `www` group

| **AW2** :$

```console
sudo useradd -g www www
```

3. Set web directory permissions

| **AW3** :$

```console
sudo chmod u+w /srv/www
```

4. Set web folder ownership to `www`

| **AW4** :$

```console
sudo chown -R www:www /srv/www
```

5. Change the Apache user to `www` with `sed`

| **AW5** :$

```console
sudo sed -i "s/^User.*/User www/" /etc/httpd/conf/httpd.conf
sudo sed -i "s/^Group.*/Group www/" /etc/httpd/conf/httpd.conf
```

6. Change the php-fpm user to `www` with `sed`

| **AW6** :$

```console
sudo sed -i "s/^user =.*/user = www/" /etc/php-fpm.d/www.conf
sudo sed -i "s/^group =.*/group = www/" /etc/php-fpm.d/www.conf
```

7. Restart the Apache server

| **AW7** :$

```console
sudo systemctl restart httpd
```

8. Life is easier with a local "Work" folder symlink

| **AW8** :$

```console
mkdir -p ~/Work/dev
sudo mkdir -p /srv/www/html/vip
sudo ln -sfn /srv/www/html/vip ~/Work/
```

- Now:
  - Your projects go in: `~/Work/vip/SOMETHING` (owned by `www`, not you)
  - Use the web address: `localhost/vip/SOMETHING`
- During development:
  - Edit files in: `~/Work/dev`
  - Copy dev files to view in browser on each save with:

```console
sudo cp -r ~/Work/dev/* ~/Work/vip/ && sudo chown -R www:www ~/Work/vip
```

#### Final notes on web folders

Always own the web directory (now with `www:www`, whether on Arch, CentOS, or Ubuntu)

...This is how you will own the web directory from now on and in VIP Linux lessons

**Using your local dev server on desktop**

- `/srv/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

#### Using your desktop LAMP server

*(Optionally, you can turn MySQL off with:)*

| **Disable MySQL** :$

```console
sudo systemctl disable mariadb
sudo systemctl stop mariadb
```

  - *(But, you will need to run this command each time you start lessons after reboot)*

| **Start MySQL once** :$

```console
sudo systemctl start mariadb
```

  - *(And, you can re-enable MySQL as a service with:)*

| **MySQL as service** :$

```console
sudo systemctl enable mariadb
sudo systemctl start mariadb
```

| **Disable MySQL service** :$

```console
sudo systemctl disable mariadb
sudo systemctl stop mariadb
```
___

## Debian/Ubuntu

### Update

| **D0** :$

```console
sudo apt update
```

### Setup LAMP

#### Install

1. Install the LAMP server

| **D1** :$

```console
sudo apt install mysql-server php lamp-server^
```

2. Turn on the PHP-MySQL functionality in your `php.ini` file

| **D2g** :$ (maybe `7.2` is a different number)

```console
sudo gedit /etc/php/7.2/apache2/php.ini
```

  - Search with: <kbd>Ctrl</kbd> + <kbd>F</kbd>, then type `mysqli` to find the line, <kbd>Ctrl</kbd> + <kbd>S</kbd> to save

Or edit with `vim`:

| **D2v** :$ (maybe `7.2` is a different number)

```console
sudo vim /etc/php/7.2/apache2/php.ini
```

  - Search by typing: `/something_to_search`, then Enter to find the line, type `:wq` to save and quit

In php.ini:

    - Uncomment & set values (remove the semicolon `;` at the start of the line)
    - `extension=mysqli`
    - `extension=pdo_mysql`
    - `extension=iconv`
    - `upload_max_filesize = 10M`
	- `file_uploads = On`

3. Restart Everything

| **D3** :$

```console
sudo systemctl restart apache2
```

4. Look for the green dot as the All-OK

| **D4** :$

```console
sudo systemctl status apache2
```

  - Press <kbd>Q</kbd> to quit. ;-)

5. Apache settings

- Enable the Apache rewrite mod

| **D5** :$

```console
sudo a2enmod rewrite
```

| **D6** :$

```console
sudo systemctl restart apache2
```

- Add some web folder settings to the config file

Edit with `gedit`:

| **D7g** :$

```console
sudo gedit /etc/apache2/sites-available/000-default.conf
```

Or edit with `vim`:

| **D7v** :$

```console
sudo vim /etc/apache2/sites-available/000-default.conf
```

  - After `DocumentRoot /var/www/html` Add these lines:
    ```
    <Directory "/var/www/html">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    </Directory>
    ```

  ...or for expanded options...
    ```
    <Directory "/var/www/html">
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Require all granted
    Order allow,deny
    allow from all
    </Directory>
    ```

6. Reload Apache after any changes to files in `/etc/apache2/sites-available/_____.conf`

| **D8** :$

```console
sudo systemctl reload apache2
```

7. Apache service: always or only when using?

- Choose A or B:

A. Start Apache only once

*(You will need to run this command each time you start lessons after reboot)*

| **D9e** :$

```console
sudo systemctl start apache2
```

B. Make Apache a service to always run

| **D9s** :$

```console
sudo systemctl enable apache2
sudo systemctl start apache2
```

*(Later, you can turn this off with:)*

| **Disable Apache service** :$

```console
sudo systemctl disable apache2
sudo systemctl stop apache2
```

*FYI...*

| **Check for specific errors in Apache server configs** :$

```console
sudo apachectl -t
```

| **Check for Apache users and Settings** :$

```console
sudo apachectl -S
```

### Change the web user to `www` (for VIP Linux lessons)
- The default web user on Debian & Ubuntu systems is `www-data`
- This is complex to type every time the web directory needs to be owned
- This makes commands incompatible with Arch/Manjaro servers
- You may or may not want to change the web user to `www`
- VIP Linux lessons assume you are using `www:www`, not `www-data:www-data`, even on Apache servers or Debian/Ubuntu systems

The web user is defined in...

| **/etc/apache2/envvars** : (`www-data`)

```
export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
```

1. Change the settings to `www` with `sed`

| **DW1** :$

```console
sudo sed -i "s/export APACHE_RUN_USER=.*/export APACHE_RUN_USER=www/" /etc/apache2/envvars
sudo sed -i "s/export APACHE_RUN_GROUP=.*/export APACHE_RUN_GROUP=www/" /etc/apache2/envvars
```

2. Create the group & user

| **DW2** :$

```console
sudo groupadd www
```

| **DW3** :$

```console
sudo useradd -g www www
```

3. Own the web directory

| **DW4** :$

```console
sudo chown -R www:www /var/www/html
```

4. Restart the Apache server

| **DW5** :$

```console
sudo systemctl restart apache2
```

5. Life is easier with a local "Work" folder symlink

| **DW5** :$

```console
mkdir -p ~/Work/vip
```

| **DW6** :$

```console
sudo ln -sfn ~/Work/vip /var/www/html/
```

#### Always own web stuff first!

| **DW7** :$

```console
sudo chown -R www-data:www-data /var/www/html/
```

- Now:
  - Your projects go in: `~/Work/vip/SOMETHING`
  - Use the web address: `localhost/vip/SOMETHING`
  - No permissions problems while you do your dev work! You're welcome.
- ***Note: this location won't work with using `<script ... src="files.js">` to include JavaScript nor is the directory writable. Both the served page and the `src="files.js"` files MUST be physically in `/var/www/html/...` somewhere, not in a symlinked location like this!***

```console
sudo cp -r ~/Work/dev/* ~/Work/vip/ && sudo chown -R www:www ~/Work/vip
```

#### Final notes on web folders

Always own the web directory (now with `www:www`, whether on Arch, CentOS, or Ubuntu)

...This is how you will own the web directory from now on and in VIP Linux lessons

**Using your local dev server on desktop**

- `/var/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

#### Using your desktop LAMP server

*(Optionally, you can turn MySQL off with:)*

| **Disable MySQL** :$

```console
sudo systemctl disable mysql
sudo systemctl stop mysql
```

  - *(But, you will need to run this command each time you start lessons after reboot)*

| **Start MySQL once** :$

```console
sudo systemctl start mysql
```

  - *(And, you can re-enable MySQL as a service with:)*

| **MySQL as service** :$

```console
sudo systemctl enable mysql
sudo systemctl start mysql
```

| **Disable MySQL service** :$

```console
sudo systemctl disable mysql
sudo systemctl stop mysql
```

___

## CentOS/Fedora

### Update

| **C0** :$

```console
sudo dnf update -y
```

### Repos for PHP

| **CR1**: EPEL

```console
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
```

| **CR2**: yum

```consol
sudo dnf install -y dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm
```

### Setup LAMP

#### Install

1. Install the LAMP server

| **C1** :$

```console
sudo dnf install -y httpd httpd-tools mariadb-server mariadb
```

2. Enable the Remi module for PHP

| **C2** :$ List modules

```console
sudo dnf module list php
```

Note the biggest `remi-x.x` number in one of the columns

| **C3** :$ Reset modules

```console
sudo dnf -y module reset php
```

| **C4** :$ Enable Remi (for example `remi-8.1`)

```console
sudo dnf -y module enable php:remi-8.1
```

| **C5** :$

```console
sudo dnf install -y php php-opcache php-gd php-curl php-mysqlnd php-pdo
```

4. Turn on the PHP-MySQL functionality in your `php.ini` file

Edit with `gedit`:

| **C6g** :$

```console
sudo gedit /etc/php.ini
```

  - Search with: <kbd>Ctrl</kbd> + <kbd>F</kbd>, then type `mysqli` to find the line, <kbd>Ctrl</kbd> + <kbd>S</kbd> to save

Or edit with `vim`:

| **C6v** :$

```console
sudo vim /etc/php.ini
```

  - Search by typing: `/something_to_search`, then Enter to find the line, type `:wq` to save and quit

In php.ini:

  - Uncomment & set values (remove the semicolon `;` at the start of the line)
    - `upload_max_filesize = 10M`
    - `file_uploads = On`

4. MariaDB setup

| **C7** :$

```console
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
```

5. Apache settings

Edit with `gedit`:

| **C8g** :$

```console
sudo gedit /etc/httpd/conf/httpd.conf
```

  - Search with: <kbd>Ctrl</kbd> + <kbd>F</kbd>, <kbd>Ctrl</kbd> + <kbd>S</kbd> to save

Or edit with `vim`:

| **C8v** :$

```console
sudo vim /etc/httpd/conf/httpd.conf
```

  - Search by typing: `/`..., type `:wq` to save and quit

Update web directory settings

  - Comment both `<Directory /var/www...` entries

  - Find `DocumentRoot "/var/www/html"` replace it to look like this:
    ```
    DocumentRoot "/var/www/html"
    <Directory "/var/www/html">
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Require all granted
    Order allow,deny
    allow from all
    </Directory>
    ```

Disable the MPM event module, which conflicts with the MPM prefork module installed with the package *(don't ask why it was installed with a configuration that doesn't conflicts with itself)*

| **C9** :$

```consol
sudo sed -i "s/LoadModule mpm_event_module/#LoadModule mpm_event_module/" /etc/httpd/conf.modules.d/00-mpm.conf
```

7. Enable & restart

| **C10** :$

```console
sudo systemctl enable mariadb
```

| **C11** :$

```console
sudo systemctl start mariadb
```

| **C12** :$

```console
sudo systemctl restart httpd
```

8. Apache service: always or only when using?

- Choose A or B:

A. Start Apache only once

*(You will need to run this command each time you start lessons after reboot)*

| **CS13e** :$

```console
sudo systemctl start httpd
```

B. Make Apache a service to always run

| **CS13s** :$

```console
sudo systemctl enable httpd
sudo systemctl start httpd
```

*(Later, you can turn this off with:)*

| **Disable Apache** :$

```console
sudo systemctl disable httpd
sudo systemctl stop httpd
```

9. SELinux cautions

- SELinux will think your LAMP Desktop work is from a hacker and many things just won't work
- SELinux errors might look like these:

| **`journalctl -r`** :

```
... SELinux is preventing httpd from read access on the file ...
```

| **/var/log/httpd-error_log** :

```
... PHP Warning:  Unknown: Failed to open stream: Permission denied in Unknown on line 0 ...
... PHP Fatal error:  Failed opening required '/var/www/...
```

- Make sure SELinux is *not* enforcing

| **CS14** :$

```console
sudo setenforce 0
sudo sed -i "s/SELINUX=.*/SELINUX=disabled/" /etc/selinux/config
```

*CentOS uses SE Linux, which is annoyingly, overly secure*

These are only for reference, but they could prove useful one day:

| **Temporarily set `enforce` on** :$

```console
getenforce
sudo setenforce 1
getenforce
```

| **Temporarily set `enforce` to "permissive"** :$

```console
getenforce
sudo setenforce 0
getenforce
```

About Apache and PHP users...

| **Check the web user running php-fpm** :$

```console
ps aux | grep php-fpm | awk '{print $1}'
```

- The Apache web user is defined in `/etc/httpd/conf/httpd.conf`, which we previously edited
- The php-fpm user, from the PHP Apache extension, is defined in `/etc/php-fpm.d/www.conf`, but we removed php-fpm, so this doesn't matter

| **Check for specific errors in Apache server configs** :$

```console
sudo apachectl -t
```

| **Check for Apache users and Settings** :$

```console
sudo apachectl -S
```

### Change the web user to `www` (for VIP Linux lessons)
- The default web user on CentOS & Fedora systems is `apache`
- This is longer text to type every time the web directory needs to be owned
- This makes commands incompatible with Arch/Manjaro servers
- You may or may not want to change the web user to `www`
- VIP Linux lessons assume you are using `www:www`, not `apache:apache`, even on Apache servers or CentOS/Fedora systems

#### Change the web user & group to `www`

1. Create the `www` user

| **CW1** :$

```console
sudo groupadd www
```

2. Create the `www` group

| **CW2** :$

```console
sudo useradd -g www www
```

3. Set web directory permissions

| **CW3** :$

```console
sudo chmod u+w /var/www
```

4. Set web folder ownership to `www` (and a few other folders)

| **CW4** :$

```console
sudo chown -R www:www /var/www
sudo chown -R root:www /var/lib/php/opcache
sudo chown -R root:www /var/lib/php/session
sudo chown -R root:www /var/lib/php/wsdlcache
```

5. Change the Apache user to `www` with `sed`

| **CW5** :$

```console
sudo sed -i "s/^User.*/User www/" /etc/httpd/conf/httpd.conf
sudo sed -i "s/^Group.*/Group www/" /etc/httpd/conf/httpd.conf
```

6. Remove php-fpm and load prefork modules instead

| **CW6** :$

```console
sudo dnf erase php-fpm
sudo sed -i "s:^LoadModule mpm_event_module modules/mod_mpm_event.so:#LoadModule mpm_event_module modules/mod_mpm_event.so:" /etc/httpd/conf.modules.d/00-mpm.conf
sudo sed -i "s:^#LoadModule mpm_prefork_module modules/mod_mpm_prefork.so:LoadModule mpm_prefork_module modules/mod_mpm_prefork.so:" /etc/httpd/conf.modules.d/00-mpm.conf
sudo sed -i "s:^LoadModule http2_module modules/mod_http2.so:#LoadModule http2_module modules/mod_http2.so:" /etc/httpd/conf.modules.d/10-h2.conf
```

<!-- `https://serverfault.com/questions/962533/how-to-remove-php-fpm-for-mod-php` -->
<!-- Not using this because we removed it
6. Change the php-fpm user to `www` with `sed`

| **CW6** :$
```console
sudo sed -i "s/^user =.*/user = www/" /etc/php-fpm.d/www.conf
sudo sed -i "s/^group =.*/group = www/" /etc/php-fpm.d/www.conf
sudo sed -i "s/listen.acl_users = apache,nginx/listen.acl_users = www,nginx/" /etc/php-fpm.d/www.conf
```
-->

7. Restart the Apache server

| **CW7** :$

```console
sudo systemctl restart httpd
```

8. Life is easier with a local "Work" folder symlink

| **CW8** :$

```console
mkdir -p ~/Work/dev
sudo mkdir -p /var/www/html/vip
sudo ln -sfn /var/www/html/vip ~/Work/
```

- Now:
  - Your projects go in: `~/Work/vip/SOMETHING` (owned by `www`, not you)
  - Use the web address: `localhost/vip/SOMETHING`
- During development:
  - Edit files in: `~/Work/dev`
  - Copy dev files to view in browser on each save with:

```console
sudo cp -r ~/Work/dev/* ~/Work/vip/ && sudo chown -R www:www ~/Work/vip
```

#### Final notes on web folders

Always own the web directory (now with `www:www`, whether on Arch, CentOS, or Ubuntu)

...This is how you will own the web directory from now on and in VIP Linux lessons

**Using your local dev server on desktop**

- `/var/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

#### Using your desktop LAMP server

*(Optionally, you can turn MySQL off with:)*

| **Disable MySQL** :$

```console
sudo systemctl disable mariadb
sudo systemctl stop mariadb
```

  - *(But, you will need to run this command each time you start lessons after reboot)*

| **Start MySQL** :$

```console
sudo systemctl start mariadb
```

  - *(And, you can re-enable MySQL as a service with:)*

| **Start MySQL** :$

```console
sudo systemctl enable mariadb
sudo systemctl start mariadb
```


___

## MySQL phpMyAdmin

### MySQL phpMyAdmin (Arch/Manjaro)

1. Download [phpMyAdmin](https://www.phpmyadmin.net/downloads/)

| **PA1** (Change file name)
```console
sha256sum phpMyAdmin-x.x.x-all-languages.zip
```

2. Extract and rename the folder to: `phpMyAdmin`

| **PA2** :$ (Change file name)

```console
cd ~/Downloads
unzip phpMyAdmin-x.x.x-all-languages.zip
mv phpMyAdmin-x.x.x-all-languages phpMyAdmin
```

3. In the terminal, move it to `/srv/www/html/` (so it is at `/srv/www/html/phpMyAdmin`)

| **PA3** :$

```console
sudo mv phpMyAdmin /var/www/html/
```

4. Create the config

| **PA4** :$

```console
cd /var/www/html/phpMyAdmin
sudo cp config.sample.inc.php config.inc.php
```

5. Set the blowfish salt (32 characters long, random)

Edit with `gedit`:

| **PA5g** :$

```console
sudo gedit /srv/www/html/phpMyAdmin/config.inc.php
```

Or edit with `vim`:

| **PA5v** :$

```console
sudo vim /var/www/html/phpMyAdmin/config.inc.php
```

  - Add the salt here:
    - `$cfg['blowfish_secret'] = '';` ...becomes...
    - `$cfg['blowfish_secret'] = 'SomeRANDOm32characterslongGOhere';`

6. Own everything properly

| **PA6** :$

```console
sudo chown -R www:www /var/www/html/phpMyAdmin
```

Now, you should be able to access this in your browser at the address:
- `localhost/phpMyAdmin`

Login the first time with the same user you create in "MySQL via command line" (below)

### MySQL phpMyAdmin (Debian/Ubuntu & CentOS/Fedora)

1. Download [phpMyAdmin](https://www.phpmyadmin.net/downloads/)

| **PD1** (Change file name)
```console
sha256sum phpMyAdmin-x.x.x-all-languages.zip
```

*The hash should match that of the download website*

2. Extract and rename the folder to: `phpMyAdmin`

| **PD2** :$ (Change file name)

```console
cd ~/Downloads
unzip phpMyAdmin-x.x.x-all-languages.zip
mv phpMyAdmin-x.x.x-all-languages phpMyAdmin
```

3. In the terminal, move it to `/var/www/html/` (so it is at `/var/www/html/phpMyAdmin`)

| **PD3** :$

```console
sudo mv phpMyAdmin /var/www/html/
```

4. Create the config

| **PD4** :$

```console
cd /var/www/html/phpMyAdmin
```

| **PD5** :$

```console
sudo cp config.sample.inc.php config.inc.php
```

5. Set the blowfish salt (32 characters long, random)

Edit with `gedit`:

| **PD6g** :$

```console
sudo gedit /var/www/html/phpMyAdmin/config.inc.php
```

Or edit with `vim`:

| **PD6v** :$

```console
sudo vim /var/www/html/phpMyAdmin/config.inc.php
```

  - Add the salt here:
    - `$cfg['blowfish_secret'] = '';` ...becomes...
    - `$cfg['blowfish_secret'] = 'SomeRANDOm32characterslongGOhere';`

6. Own everything properly

| **PD7** :$

```console
sudo chown -R www:www /var/www/html/phpMyAdmin
```

Now, you should be able to access this in your browser at the address:
- `localhost/phpMyAdmin`

Login the first time with the same user you create in "MySQL via command line" (below)

___

## Arch, CentOS & Debian

### MySQL via Command Line

1. Access MySQL as root user with

| **M1** :$

```console
sudo mysql
```

2. Create a database admin user in MySQL with: (user: `admin` password: `adminpassword`)

| **M2** :>

```console
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;
```

| **M3** :>

```console
FLUSH PRIVILEGES;
```

3. Exit MySQL

| **M4** :>

```console
QUIT;
```

Access any MySQL user you created later with
- `mysql -u USERNAME -p` (then enter the password)

***If*** in Debian/Ubuntu and you ever need to wipe MySQL clean and completely start over:

```sh
sudo apt-get clean
sudo apt-get purge mysql*
sudo apt-get update
sudo apt-get install -f
sudo apt-get install mysql-server
```
___

## Make PHP More Secure

This is not necessary for VIP Linux lessons, but may be helpful in some situations

### Arch/Manjaro

| **SA1** :$

```console
sudo mkdir -p /srv/www/tmp
```

| **SA2** :$

```console
sudo chmod -R 777 /srv/www/tmp
```

| **SA3** :$

```console
sudo chmod 644 /etc/php/php.ini
```

Open php.ini and make these settings:

| **SA4** :$

```console
sudo vim /etc/php/php.ini
```

```
open_basedir = /srv/www

sys_temp_dir = /srv/www/tmp

upload_tmp_dir = /srv/www/tmp
```

Now you can use PHP to upload, but php is limited to the www directory

### Debian/Ubuntu

| **SD1** :$

```console
sudo mkdir -p /var/www/tmp
```

| **SD2** :$

```console
sudo chmod -R 777 /var/www/tmp
```

| **SD3** :$ (maybe '7.2' is a different number)

```console
sudo chmod 644 /etc/php/7.2/apache2/php.ini
```

Open php.ini and make these settings:

| **SD4** :$ (maybe '7.2' is a different number)

```console
sudo vim /etc/php/7.2/apache2/php.ini
```

```
open_basedir = /var/www

sys_temp_dir = /var/www/tmp

```
Now you can use PHP to upload, but php is limited to the www directory

### CentOS/Fedora

| **SC1** :$

```console
sudo mkdir -p /var/www/tmp
```

| **SC2** :$

```console
sudo chmod -R 777 /var/www/tmp
```

| **SC3** :$

```console
sudo chmod 644 /etc/php.ini
```

Open php.ini and make these settings:

| **SC4** :$

```console
sudo vim /etc/php.ini
```

```
open_basedir = /var/www

sys_temp_dir = /var/www/tmp

upload_tmp_dir = /var/www/tmp
```

Now you can use PHP to upload, but php is limited to the www directory
