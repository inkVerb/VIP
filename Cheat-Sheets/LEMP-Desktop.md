# LEMP Desktop
## PHP/MySQL developer environment directly in Arch/Manjaro
*(rather than WAMPP or XAMPP in Windows)*

***This is for your local desktop developer environment only, not secure for production servers!***

***This is only for Arch/Manjaro and installs Nginx!*** *For Apache on Arch/Manjaro or Debian/Ubuntu, see [LAMP Desktop](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/LAMP-Desktop.md)*

*DEV note: This is in beta and has not been tested; PHP-FPM may not work*

### Update

| **0** :$

```console
sudo pacman -Syy
```

### Setup LEMP

#### Install

1. Install Nginx & MariaDB

| **1** :$

```console
sudo pacman -S --noconfirm nginx mariadb php php-fpm
```

2. Turn on the PHP-MySQL functionality in your `php.ini` file

Edit with `gedit`:

| **2g** :$

```console
sudo gedit /etc/php/php.ini
```

  - Search with: <kbd>Ctrl</kbd> + <kbd>F</kbd>, then type `mysqli` to find the line, <kbd>Ctrl</kbd> + <kbd>S</kbd> to save

Or edit with `vim`:

| **2v** :$

```console
sudo vim /etc/php/php.ini
```

  - Search by typing: `/something_to_search`, then Enter to find the line, type `:wq` to save and quit

In php.ini:

  - Uncomment & set values (remove the semicolon `;` at the start of the line)
    - `extension=mysqli`
    - `extension=pdo_mysql`
    - `extension=iconv`
    - `upload_max_filesize = 50M`
	  - `file_uploads = On`

3. MariaDB setup *before starting the service*

| **3** :$

```console
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
```

4. Start Services

| **4** :$

```console
sudo systemctl start nginx
```

| **5** :$

```console
sudo systemctl start mariadb
```

| **6** :$

```console
sudo systemctl start php-fpm
```

#### Create the web user and directories

*Note (`usermod -a -G www http`) that Nginx requires its own `http` user, so we must add it to the `www` group*

*(Many Nginx servers can get away without adding the Nginx `http` user to the `www` (or other) web user group, but eventually something can break if we don't)*

*Note we also add write (`+w`) permissions and own the web folder (`/srv/www`)*

| **7** :$

```console
sudo useradd -g www www
sudo usermod -a -G www http
sudo mkdir -p /srv/www/html
sudo chmod u+w /srv/www
sudo chmod u+w /srv/www/html
sudo chown -R www:www /srv/www
```

#### Using your local dev server on desktop

- `/srv/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

Life is easier with a local "Work" folder symlink

| **8** :$

```console
mkdir -p ~/Work/dev
sudo mkdir -p /srv/www/html/vip
sudo chmod u+w /srv/www/html/vip
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

#### Always own web stuff first!

| **9** :$

```console
sudo chown -R www:www /srv/www
```

#### Settings

1. Nginx

Edit with `gedit`:

| **10g** :$

```console
sudo gedit /etc/nginx/nginx.conf
```

Or edit with `vim`:

| **10v** :$

```console
sudo vim /etc/nginx/nginx.conf
```

  - Look make sure the two `location` entries look like this, respectively:

  ```
  location / {
    root /srv/www/html;
    index index.htm index.html index.php;
    include /srv/www/rewrite; # Rewrites go here, more convenient
  }

  location ~ [^/]\.(php|html|htm)(/|$) {
    root /srv/www/html;
    include /etc/nginx/php_fastcgi.conf;
  }
  ```

  - Rewrites:
    - For convenience, rewrites will go in an included file for convenient editing
    - Nginx will break if an `include` file doesn't exist
    - So, create the rewrite file, though it's empty

| **11** :$

```console
sudo touch /srv/www/rewrite
```

| **12** :$

```console
sudo chown -R www:www /srv/www
```

| **/etc/php/php-fpm.d/www.conf** :

```
[www]
user=www
group=www
listen.owner = www
listen.group = www
```


2. Add some important settings

Edit with `gedit`:

| **13g** :$

```console
sudo gedit /etc/nginx/php_fastcgi.conf
```

Or edit with `vim`:

| **13v** :$

```console
sudo vim /etc/nginx/php_fastcgi.conf
```

  - Make it look like this:
  ```
  # 404
    try_files $fastcgi_script_name =404;

  # default fastcgi_params
    include fastcgi_params;

  # fastcgi settings
    fastcgi_pass                    unix:/run/php-fpm/php-fpm.sock;
    fastcgi_index                   index.php;
    fastcgi_buffers                 8 16k;
    fastcgi_buffer_size             32k;

  # fastcgi params
    fastcgi_param DOCUMENT_ROOT     $realpath_root;
    fastcgi_param SCRIPT_FILENAME   $realpath_root$fastcgi_script_name;
    #fastcgi_param PHP_ADMIN_VALUE  "open_basedir=$base/:/usr/lib/php/:/tmp/";
  ```

3. Reload Nginx after any changes

| **14** :$

```console
sudo systemctl reload nginx
```

  - Check for specific errors in Nginx server configs

| **15** :$

```console
sudo nginx -t
```

Remember with rewrites...

*Your code must reflect the names of any URLs as you want them rewritten, not as they actually are.*

4. Look for the green dot as the All-OK

| **16** :$

```console
sudo systemctl status nginx
```

  - Press <kbd>Q</kbd> to quit. ;-)

| **17** :$

```console
sudo systemctl status mariadb
```

| **18** :$

```console
sudo systemctl status php-fpm
```

### MySQL via Command Line

1. Access MySQL as root user with

| **19** :$

```console
sudo mariadb
```

2. Create a database admin user in MySQL with: (user: `admin` password: `adminpassword`)

| **20** :>

```console
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;
```

| **21** :>

```console
FLUSH PRIVILEGES;
```

3. Exit MySQL

| **22** :>

```console
QUIT;
```

### MySQL phpMyAdmin

1. Download [phpMyAdmin](https://www.phpmyadmin.net/downloads/)
2. Extract and rename the folder to: `phpMyAdmin`
3. In the terminal, move it to `/srv/www/html/` (so it is at `/srv/www/html/phpMyAdmin`)

| **23** :$

```console
sudo mv phpMyAdmin /srv/www/html/
```

4. Create the config

| **24** :$

```console
cd /srv/www/html/phpMyAdmin
```

| **25** :$

```console
sudo cp config.sample.inc.php config.inc.php
```

5. Set the blowfish salt (32 characters long, random)
  - Edit with `gedit`:

| **26g** :$

```console
sudo gedit /srv/www/html/phpMyAdmin/config.inc.php
```

Or edit with `vim`:

| **286v** :$

```console
sudo vim /srv/www/html/phpMyAdmin/config.inc.php
```

  - Add the salt here:
    - `$cfg['blowfish_secret'] = '';` ...becomes...
    - `$cfg['blowfish_secret'] = 'SomeRANDOm32characterslongGOhere';`

6. Own everything properly

| **27** :$

```console
sudo chown -R www:www /srv/www/html/phpMyAdmin
```

Now, you should be able to access this in your browser at the address:
- `localhost/phpMyAdmin`

Login the first time with the same user you created in "MySQL via command line" above

### Make PHP More Secure

| **P1** :$

```console
sudo mkdir -p /srv/www/tmp
```

| **P2** :$

```console
sudo chmod -R 777 /srv/www/tmp
```

| **P3** :$

```console
sudo chmod 644 /etc/php/php.ini
```

Open php.ini and make these settings:

| **P4** :$

```console
sudo vim /etc/php/php.ini
```

```
open_basedir = /srv/www

sys_temp_dir = /srv/www/tmp

upload_tmp_dir = /srv/www/tmp

upload_max_filesize = 2M

file_uploads = On
```

Now you can use PHP to upload, but php is limited to the www directory and 2MB per file

### Nginx on Debian/Ubuntu (irregular)

VIP Linux not use Nginx on an Ubuntu server, but this will make VIP Linux lessons compatible with your system if you do

If you are using Nginx, the `www:www` settings would go in these files...

| **/etc/nginx/nginx.conf** :

```
user www www;
```

- Edit with `gedit`:

| **N1g** :$

```console
sudo gedit /etc/nginx/nginx.conf
```

- Or edit with `vim`:

| **N1v** :$

```console
sudo vim /etc/nginx/nginx.conf
```

*...the `user` setting should be on the first line, add it if it isn't*

| **/etc/php/7.2/fpm/pool.d/www.conf** : (maybe '7.2' is a different number)

```
[www]
user = www
group = www
listen.owner = www
listen.group = www
```

- Edit with `gedit`:

| **N2g** :$

```console
sudo gedit /etc/php/7.2/fpm/pool.d/www.conf
```

- Or edit with `vim`:

| **N2v** :$

```console
sudo vim /etc/php/7.2/fpm/pool.d/www.conf
```

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

| **N3g** :$

```console
sudo gedit /etc/nginx/nginx.conf
```

- Or edit with `vim`:

| **N3v** :$

```console
sudo vim /etc/nginx/nginx.conf
```

*...add that one line under `location /`, and make sure the file exists...*

| **N4** :$

```console
sudo touch /srv/www/rewrite
```

| **N5** :$

```console
sudo chown -R www:www /srv/www
```

| **N6** :$

```console
sudo systemctl reload nginx
```

  - Check for specific errors in Nginx server configs

| **N7** :$

```console
sudo nginx -t
```
