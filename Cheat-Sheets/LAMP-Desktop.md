# LAMP Desktop
## PHP/MySQL developer environment directly in Ubuntu
*(rather than WAMPP or XAMPP in Windows)*

***This is for your local desktop developer environment only, not secure for production!***

***This installs Apache!*** *For Nginx, see [LEMP Desktop](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/LEMP-Desktop.md)*

## Arch/Manjaro

### Update

  | **0** :$ `sudo pacman -Syy`

#### Install

1. Install the LAMP server

  | **1** :$ `sudo pacman -S --noconfirm apache php php-apache mariadb`

2. Turn on the PHP-MySQL functionality in your `php.ini` file

  - Edit with `gedit`:

    | **2g** :$ `sudo gedit /etc/php/php.ini`

    - Search with: Ctrl + F, then type `mysqli` to find the line, Ctrl + S to save

  - Or edit with `vim`:

    | **2v** :$ `sudo vim /etc/php/php.ini`

    - Search by typing: `/mysqli`, then Enter to find the line, type `:wq` to save and quit

  - Uncomment `extension=mysqli` (remove the semicolon `;` at the start of the line)

3. Get MariaDB working

  | **3** :$ `sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql`

4. Get Apache working

- Edit with `gedit`:

  | **4g** :$ `sudo gedit /etc/httpd/conf/httpd.conf`

  - Search with: Ctrl + F, Ctrl + S to save

- Or edit with `vim`:

  | **4v** :$ `sudo vim /etc/httpd/conf/httpd.conf`

  - Search by typing: `/`..., type `:wq` to save and quit


  - Reverse the commenting so these lines to look like this:

  ```
  #LoadModule mpm_event_module modules/mod_mpm_event.so
  LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
  ...
  LoadModule http2_module modules/mod_http2.so
  ```

  - Add these lines:

  ```
  LoadModule php_module modules/libphp.so
  AddHandler php-script .php
  Include conf/extra/php_module.conf
  Protocols h2 http/1.1
  ```

5. Web user to `www`

- Edit with `gedit`:

  | **5g** :$ `sudo gedit /etc/httpd/conf/httpd.conf`

  - Search with: Ctrl + F, Ctrl + S to save

- Or edit with `vim`:

  | **5v** :$ `sudo vim /etc/httpd/conf/httpd.conf`

  - Search by typing: `/`..., type `:wq` to save and quit

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

  - After `DocumentRoot "/srv/http"` replace `<Directory...` contents with these lines:
    ```
    <Directory "/srv/http">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    </Directory>
    ```

  ...or for expanded options...

  ```
  <Directory "/srv/http">
  Options Indexes FollowSymLinks MultiViews
  AllowOverride All
  Require all granted
  Order allow,deny
  allow from all
  </Directory>
  ```

6. Web user and folder

  | **6** :$ `sudo groupadd www`

  | **7** :$ `sudo useradd -g www www`

  | **8** :$ `sudo chmod u+w /srv/http`

  | **9** :$ `sudo chown -R www:www /srv/http`


7. Enable & restart

  | **10** :$ `sudo systemctl enable mariadb`

  | **11** :$ `sudo systemctl start mariadb`

  | **12** :$ `sudo systemctl restart httpd`

#### Using your local dev server on desktop

- `/var/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

Life is easier with a local "Work" folder symlink

  | **13** :$ `mkdir -p ~/Work/vip`

  | **14** :$ `sudo ln -sfn ~/Work/vip /srv/http/`

- Now:
  - Your projects go in: `~/Work/vip/SOMETHING`
  - Use the web address: `localhost/vip/SOMETHING`

- ***Bug: Currently files in this home directory are not working, will fix in future***

#### Always own web stuff first!

  | **15** :$ `sudo chown -R www:www /srv/http/`


### MySQL phpMyAdmin

1. Install this as an Arch package

  | **16** :$ `sudo pacman -S phpmyadmin --noconfirm`

2. Link it to the web directory

  | **17** :$ `sudo ln -sfn /usr/share/webapps/phpMyAdmin /srv/http/`

Now, you should be able to access this in your browser at the address:
- `localhost/phpMyAdmin`

## Debian/Ubuntu

### Update

  | **0** :$ `sudo apt update`

### Setup LAMP

#### Install

1. Install the LAMP server

  | **1** :$ `sudo apt install mysql-server php lamp-server^`

2. Turn on the PHP-MySQL functionality in your `php.ini` file
  - Uncomment `extension=mysqli` (remove the semicolon `;` at the start of the line)
  - Edit with `gedit`:

    | **2g** :$ `sudo gedit /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)

    - Search with: Ctrl + F, then type `mysqli` to find the line, Ctrl + S to save

  - Or edit with `vim`:

    | **2v** :$ `sudo vim /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)

    - Search by typing: `/mysqli`, then Enter to find the line, type `:wq` to save and quit

3. Restart Everything

  | **3** :$ `sudo systemctl restart apache2`

4. Look for the green dot as the All-OK

  | **4** :$ `sudo systemctl status apache2`

    - Type `q` to quit. ;-)

#### Using your local dev server on desktop

- `/var/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

Life is easier with a local "Work" folder symlink

  | **5** :$ `mkdir -p ~/Work/vip`

  | **6** :$ `sudo ln -sfn ~/Work/vip /var/www/html/`

- Now:
  - Your projects go in: `~/Work/vip/SOMETHING`
  - Use the web address: `localhost/vip/SOMETHING`
  - No permissions problems while you do your dev work! You're welcome.
- ***Note: this location won't work with using `<script ... src="files.js">` to include JavaScript nor is the directory writable. Both the served page and the `src="files.js"` files MUST be physically in `/var/www/html/...` somewhere, not in a symlinked location like this!***

#### Always own web stuff first!

| **7** :$ `sudo chown -R www-data:www-data /var/www/html/`

#### Make Apache rewrites work

1. Enable the Rewrite mod for Apache

  | **8** :$ `sudo a2enmod rewrite`

  | **9** :$ `sudo systemctl restart apache2`

2. Add some important settings
  - Edit with `gedit`:

    | **10g** :$ `sudo gedit /etc/apache2/sites-available/000-default.conf`

  - Or edit with `vim`:

    | **10v** :$ `sudo vim /etc/apache2/sites-available/000-default.conf`

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

  | **11** :$ `sudo systemctl reload apache2`

4. Remember with rewrites...

*Your code must reflect the names of any URLs as you want them rewritten, not as they actually are.*

### MySQL phpMyAdmin

1. Download [phpMyAdmin](https://www.phpmyadmin.net/downloads/)
2. Extract and rename the folder to: `phpMyAdmin`
3. In the terminal, move it to `/var/www/html/` (so it is at `/var/www/html/phpMyAdmin`)

  | **12** :$ `sudo mv phpMyAdmin /var/www/html/`

4. Create the config

  | **13** :$ `cd /var/www/html/phpMyAdmin`

  | **14** :$ `sudo cp config.sample.inc.php config.inc.php`

5. Set the blowfish salt (32 characters long, random)
  - Edit with `gedit`:

    | **15g** :$ `sudo gedit /var/www/html/phpMyAdmin/config.inc.php`

  - Or edit with `vim`:

    | **16v** :$ `sudo vim /var/www/html/phpMyAdmin/config.inc.php`

  - Add the salt here:
    - `$cfg['blowfish_secret'] = '';` ...becomes...
    - `$cfg['blowfish_secret'] = 'SomeRANDOm32characterslongGOhere';`

6. Own everything properly

  | **17** :$ `sudo chown -R www-data:www-data /var/www/html/phpMyAdmin`

Now, you should be able to access this in your browser at the address:
- `localhost/phpMyAdmin`

Login the first time with the same user you created in "MySQL via command line" above

## MySQL via Command Line

1. Access MySQL as root user with

  | **M1** :$ `sudo mysql`

2. Create a database admin user in MySQL with: (user: `admin` password: `adminpassword`)

  | **M2** :>  `GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;`

  | **M3** :> `FLUSH PRIVILEGES;`

3. Exit MySQL

  | **M4** :> `QUIT;`

Access any MySQL user you created later with
- `mysql -u USERNAME -p` (then enter the password)

***If*** you ever need to wipe MySQL clean and completely start over:

```sh
sudo apt-get clean
sudo apt-get purge mysql*
sudo apt-get update
sudo apt-get install -f
sudo apt-get install mysql-server
```


## Debian/Ubuntu: Change the web user to `www`
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

1. Change the setting to `www` with `sed`

  | **W1** :$ `sudo sed -i "s/export APACHE_RUN_USER=.*/export APACHE_RUN_USER=www/" /etc/apache2/envvars`

  | **W2** :$ `sudo sed -i "s/export APACHE_RUN_GROUP=.*/export APACHE_RUN_GROUP=www/" /etc/apache2/envvars`

2. Create the group & user

  | **W3** :$ `sudo groupadd www`

  | **W4** :$ `sudo useradd -g www www`

3. Restart the Apache server

  | **W5** :$ `sudo systemctl restart apache2`

4. Always own the web directory (now with `www:www` instead of `www-data:www-data`)

  | **W6** :$ `sudo chown -R www:www /var/www/html/phpMyAdmin`

...This is how you will own the web directory from now on and in VIP Linux lessons

## Nginx on Debian/Ubuntu (irregular)

VIP Linux not use Nginx on an Ubuntu server, but this will make VIP Linux lessons compatible with your system if you do

If you are using Nginx, the `www:www` settings would go in these files...

| **/etc/nginx/nginx.conf** :

```
user www www;
```

- Edit with `gedit`:

  | **N1g** :$ `sudo gedit /etc/nginx/nginx.conf`

- Or edit with `vim`:

  | **N1v** :$ `sudo vim /etc/nginx/nginx.conf`

*...the `user` setting should be on the first line, add it if it isn't*

| **/etc/php/7.2/fpm/pool.d/www.conf** : (maybe '7.2' is a different number)

```
[www]
user=www
group=www
listen.owner = www
listen.group = www
```

- Edit with `gedit`:

  | **N2g** :$ `sudo gedit /etc/php/7.2/fpm/pool.d/www.conf`

- Or edit with `vim`:

  | **N2v** :$ `sudo vim /etc/php/7.2/fpm/pool.d/www.conf`

*...`user=` & `group=` settings may appear elsewhere, but these must be in the lines right after `[www]`, add them if they aren't*

For VIP Linux rewrites...

| **/etc/nginx/nginx.conf** :

```
location / {
  ...
  include /srv/www/rewrite;
}
```

- Edit with `gedit`:

  | **N3g** :$ `sudo gedit /etc/nginx/nginx.conf`

- Or edit with `vim`:

  | **N3v** :$ `sudo vim /etc/nginx/nginx.conf`

*...add that one line under `location /`, and make sure the file exists...*

  | **N4** :$ `sudo touch /srv/www/rewrite`

  | **N5** :$ `sudo chown -R www:www /srv/www`

  | **N6** :$ `sudo systemctl reload nginx`


## Make PHP More Secure

  | **P1** :$ `sudo mkdir -p /var/www/tmp`

  | **P2** :$ `sudo chmod -R 777 /var/www/tmp`

  | **P3** :$ `sudo chmod 644 /etc/php/7.2/apache2/php.ini` (maybe '7.2' is a different number)

Open php.ini and make these settings:

  | **P4** :$ `sudo vim /etc/php/7.2/apache2/php.ini` (maybe '7.2' is a different number)

```
open_basedir = /var/www

sys_temp_dir = /var/www/tmp

upload_tmp_dir = /var/www/tmp

upload_max_filesize = 2M

file_uploads = On
```

Now you can use PHP to upload, but php is limited to the www directory and 2MB per file
