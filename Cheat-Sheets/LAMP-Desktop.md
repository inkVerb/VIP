# LAMP Desktop
## PHP/MySQL developer environment directly in Manjaro or Ubuntu
*(rather than WAMPP or XAMPP in Windows)*

***This is for your local desktop developer environment only, not secure for production servers!***

***This installs Apache!*** *For Nginx on Arch/Manjaro, see [LEMP Desktop](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/LEMP-Desktop.md)*

___

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

  - Edit with `gedit`:

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

4. Apache settings

Edit with `gedit`:

| **A4g** :$

```console
sudo gedit /etc/httpd/conf/httpd.conf
```

  - Search with: <kbd>Ctrl</kbd> + <kbd>F</kbd>, <kbd>Ctrl</kbd> + <kbd>S</kbd> to save

Or edit with `vim`:

| **A4v** :$

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

b. Web user to `www`


  - Change these lines:
  ```
  User http
  Group http
  ```

  - To:
  ```
  User www
  Group www
  ```

c. Web directory settings

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

5. Web user and folder

| **A5** :$

```console
sudo groupadd www
```

| **A6** :$

```console
sudo useradd -g www www
```

| **A7** :$

```console
sudo chmod u+w /srv/www
```

| **A8** :$

```console
sudo chown -R www:www /srv/www
```

6. Enable & restart

| **A9** :$

```console
sudo systemctl enable mariadb
```

| **A10** :$

```console
sudo systemctl start mariadb
```

| **A11** :$

```console
sudo systemctl restart httpd
```

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

- Check for specific errors in Apache server configs

| **A12** :$

```console
sudo apachectl -t
```

**Using your local dev server on desktop**

- `/srv/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

Life is easier with a local "Work" folder symlink

| **A13** :$

```console
mkdir -p ~/Work/dev
sudo mkdir -p /srv/www/html/vip
sudo ln -sfn /srv/www/html/vip ~/Work/
```

- Now:
  - Your projects go in: `~/Work/vip/SOMETHING` (owned by www, not you)
  - Use the web address: `localhost/vip/SOMETHING`
- During development:
  - Edit files in: `~/Work/dev`
  - Copy dev files to view in browser on each save with:

```console
sudo cp -r ~/Work/dev/* ~/Work/vip/ && sudo chown -R www:www ~/Work/vip
```

**Always own web stuff first!**

| **A14** :$

```console
sudo chown -R www:www /srv/www
```

**Apache service: always or only when using?**

- Choose 1 or 2:

1. Start Apache only once

*(You will need to run this command each time you start lessons after reboot)*

| **A15e** :$

```console
sudo systemctl start httpd
```

2. Make Apache a service to always run

| **A15s** :$

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

### MySQL phpMyAdmin (Arch/Manjaro)

1. Download [phpMyAdmin](https://www.phpmyadmin.net/downloads/)
2. Extract and rename the folder to: `phpMyAdmin`
3. In the terminal, move it to `/srv/www/html/` (so it is at `/srv/www/html/phpMyAdmin`)

| **A16** :$

```console
sudo mv phpMyAdmin /srv/www/html/
```

4. Create the config

| **A17** :$

```console
cd /srv/www/html/phpMyAdmin
sudo cp config.sample.inc.php config.inc.php
```

5. Set the blowfish salt (32 characters long, random)
  - Edit with `gedit`:

| **A18g** :$

```console
sudo gedit /srv/www/html/phpMyAdmin/config.inc.php
```

Or edit with `vim`:

| **A18v** :$

```console
sudo vim /srv/www/html/phpMyAdmin/config.inc.php
```

  - Add the salt here:
    - `$cfg['blowfish_secret'] = '';` ...becomes...
    - `$cfg['blowfish_secret'] = 'SomeRANDOm32characterslongGOhere';`

6. Own everything properly

| **A19** :$

```console
sudo chown -R www:www /srv/www/html/phpMyAdmin
```

Now, you should be able to access this in your browser at the address:
- `localhost/phpMyAdmin`

Login the first time with the same user you create in "MySQL via command line" (below)

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

*(Optionally, you can turn MySQL off with:)*

| **Disable MySQL** :$

```console
sudo systemctl disable mysql
sudo systemctl stop mysql
```

  - *(But, you will need to run this command each time you start lessons after reboot)*

| **Start MySQL** :$

```console
sudo systemctl start mysql
```

  - *(And, you can re-enable MySQL as a service with:)*

| **Start MySQL** :$

```console
sudo systemctl enable mysql
sudo systemctl start mysql
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

#### Using your local dev server on desktop

- `/var/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

Life is easier with a local "Work" folder symlink

| **D5** :$

```console
mkdir -p ~/Work/vip
```

| **D6** :$

```console
sudo ln -sfn ~/Work/vip /var/www/html/
```

- Now:
  - Your projects go in: `~/Work/vip/SOMETHING`
  - Use the web address: `localhost/vip/SOMETHING`
  - No permissions problems while you do your dev work! You're welcome.
- ***Note: this location won't work with using `<script ... src="files.js">` to include JavaScript nor is the directory writable. Both the served page and the `src="files.js"` files MUST be physically in `/var/www/html/...` somewhere, not in a symlinked location like this!***

#### Always own web stuff first!

| **D7** :$

```console
sudo chown -R www-data:www-data /var/www/html/
```

#### Make Apache rewrites work

1. Enable the Rewrite mod for Apache

| **D8** :$

```console
sudo a2enmod rewrite
```

| **D9** :$

```console
sudo systemctl restart apache2
```

2. Add some important settings
  - Edit with `gedit`:

| **D10g** :$

```console
sudo gedit /etc/apache2/sites-available/000-default.conf
```

Or edit with `vim`:

| **D10v** :$

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

3. Reload Apache after any changes to files in `/etc/apache2/sites-available/_____.conf`

| **D11** :$

```console
sudo systemctl reload apache2
```

  - Check for specific errors in Apache server configs

| **D12** :$

```console
sudo apachectl -t
```

4. Remember with rewrites...

*Your code must reflect the names of any URLs as you want them rewritten, not as they actually are.*

5. (Optional) If you DO NOT want Apache to start automatically

| **Disable Apache** :$

```console
sudo systemctl disable apache2
sudo systemctl stop apache2
```

*(You will need to run this command each time you start lessons after reboot)*

| **Start Apache** :$

```console
sudo systemctl start apache2
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

Always own the web directory (now with `www:www` instead of `www-data:www-data`)

```console
sudo chown -R www:www /var/www/html
```

...This is how you will own the web directory from now on and in VIP Linux lessons

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

  - Edit with `gedit`:

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
  - Near the top, add the lines:
  ```
  extension=mysqli
  extension=pdo.so
  ```

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

a. Enable modules:

  - Add the following lines below `Include conf.modules.d/*.conf`:

  ```
  LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
  LoadModule http2_module modules/mod_http2.so
  LoadModule rewrite_module modules/mod_rewrite.so
  LoadModule php_module modules/libphp.so
  AddHandler php-script .ph
  Protocols h2 http/1.1
  ```

b. Web directory settings

  - Comment both `<Directory /var/www...` entries

  - Find `DocumentRoot "/var/www/html"` replace it to look like this:
    ```
    DocumentRoot "/var/www/html"
    <Directory "/var/www/html">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    </Directory>
    ```

  ...or for expanded options...
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

- Check for specific errors in Apache server configs

| **C13** :$

```console
sudo apachectl -t
```

**Apache service: always or only when using?**

- Choose 1 or 2:

1. Start Apache only once

*(You will need to run this command each time you start lessons after reboot)*

| **C14e** :$

```console
sudo systemctl start httpd
```

2. Make Apache a service to always run

| **C14s** :$

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

### Change the web user to `www` (for VIP Linux lessons)
- The default web user on CentOS & Fedora systems is `apache`
- This is longer text to type every time the web directory needs to be owned
- This makes commands incompatible with Arch/Manjaro servers
- You may or may not want to change the web user to `www`
- VIP Linux lessons assume you are using `www:www`, not `apache:apache`, even on Apache servers or CentOS/Fedora systems

The web user is defined in `/etc/httpd/conf/httpd.conf`, which we previously edited

Change the web user & group to `www`

1. Change the settings to `www` with `sed`

| **CW1** :$

```console
sudo sed -i "s/^User.*/User www/" /etc/httpd/conf/httpd.conf
sudo sed -i "s/^Group.*/Group www/" /etc/httpd/conf/httpd.conf
```

2. Create the group & user

| **CW2** :$

```console
sudo groupadd www
```

| **CW3** :$

```console
sudo useradd -g www www
```

3. Set ownership and permissions

| **CW4** :$

```console
sudo chmod u+w /var/www
```

| **CW5** :$

```console
sudo chown -R www:www /var/www/html
```

4. Restart the Apache server

| **CW6** :$

```console
sudo systemctl restart apache2
```

Always own the web directory (now with `www:www` instead of `www-data:www-data`)

```console
sudo chown -R www:www /var/www/html
```

...This is how you will own the web directory from now on and in VIP Linux lessons

**Using your local dev server on desktop**

- `/var/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

Life is easier with a local "Work" folder symlink

| **CW7** :$

```console
mkdir -p ~/Work/dev
sudo mkdir -p /var/www/html/vip
sudo ln -sfn /var/www/html/vip ~/Work/
```

- Now:
  - Your projects go in: `~/Work/vip/SOMETHING` (owned by www, not you)
  - Use the web address: `localhost/vip/SOMETHING`
- During development:
  - Edit files in: `~/Work/dev`
  - Copy dev files to view in browser on each save with:

```console
sudo cp -r ~/Work/dev/* ~/Work/vip/ && sudo chown -R www:www ~/Work/vip
```

___

## MySQL phpMyAdmin

### MySQL phpMyAdmin (Arch/Manjaro)

1. Download [phpMyAdmin](https://www.phpmyadmin.net/downloads/)

| **PA1** (Change file name)
```console
sha256sum phpMyAdmin-x.x.x-all-languages.zip
```

3. Extract and rename the folder to: `phpMyAdmin`

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
  - Edit with `gedit`:

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

3. Extract and rename the folder to: `phpMyAdmin`

| **PD2** :$ (Change file name)

```console
cd ~/Downloads
unzip phpMyAdmin-x.x.x-all-languages.zip
mv phpMyAdmin-x.x.x-all-languages phpMyAdmin
```

5. In the terminal, move it to `/var/www/html/` (so it is at `/var/www/html/phpMyAdmin`)

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
  - Edit with `gedit`:

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

## Arch, Debian & CentOS

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
