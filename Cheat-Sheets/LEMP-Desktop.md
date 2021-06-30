# LAMP Desktop
## PHP/MySQL developer environment directly in Arch/Manjaro
*(rather than WAMPP or XAMPP in Windows)*

***This is for your local desktop developer environment only, not secure for production!***

***This is only for Arch/Manjaro and installs Nginx!*** *For Apache on Arch/Manjaro or Debian/Ubuntu, see [LAMP Desktop](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/LAMP-Desktop.md)*

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
  - Uncomment `extension=mysqli` (remove the semicolon `;` at the start of the line)
  - Edit with `gedit`:

    | **2g** :$

```console
sudo gedit /etc/php/php.ini
```

  - Search with: <kbd>Ctrl</kbd> + <kbd>F</kbd>, then type `mysqli` to find the line, <kbd>Ctrl</kbd> + <kbd>S</kbd> to save

  - Or edit with `vim`:

    | **2v** :$

```console
sudo vim /etc/php/php.ini
```

  - Search by typing: `/mysqli`, then Enter to find the line, type `:wq` to save and quit

3. Start Everything

  | **3** :$

```console
sudo systemctl enable nginx
```

  | **4** :$

```console
sudo systemctl start nginx
```

  | **5** :$

```console
sudo systemctl enable mariadb
```

  | **6** :$

```console
sudo systemctl start mariadb
```

  | **7** :$

```console
sudo systemctl enable php-fpm
```

  | **8** :$

```console
sudo systemctl start php-fpm
```

4. Look for the green dot as the All-OK

  | **9** :$

```console
sudo systemctl status nginx
```

  - Press <kbd>Q</kbd> to quit. ;-)

  | **10** :$

```console
sudo systemctl status mariadb
```

  | **11** :$

```console
sudo systemctl status php-fpm
```

#### Using your local dev server on desktop

- `/srv/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

Life is easier with a local "Work" folder symlink

  | **12** :$

```console
mkdir -p ~/Work/vip
```

  | **13** :$

```console
sudo ln -sfn ~/Work/vip /srv/www/html/
```

- Now:
  - Your projects go in: `~/Work/vip/SOMETHING`
  - Use the web address: `localhost/vip/SOMETHING`
  - No permissions problems while you do your dev work! You're welcome.
- ***Note: this location won't work with using `<script ... src="files.js">` to include JavaScript nor is the directory writable. Both the served page and the `src="files.js"` files MUST be physically in `/srv/www/html/...` somewhere, not in a symlinked location like this!***

#### Always own web stuff first!

  | **14** :$

```console
sudo chown -R www:www /srv/www
```

#### Settings

1. Nginx

  - Edit with `gedit`:

    | **15g** :$

```console
sudo gedit /etc/nginx/nginx.conf
```

  - Or edit with `vim`:

    | **15v** :$

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

    | **16** :$

```console
sudo touch /srv/www/rewrite
```

    | **17** :$

```console
sudo chown -R www:www /srv/www
```


2. Add some important settings
  - Edit with `gedit`:

    | **18g** :$

```console
sudo gedit /etc/nginx/php_fastcgi.conf
```

  - Or edit with `vim`:

    | **18v** :$

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

  | **19** :$

```console
sudo systemctl reload nginx
```

  - Check for specific errors in Nginx server configs

  | **20** :$

```console
sudo nginx -t
```

4. Remember with rewrites...

*Your code must reflect the names of any URLs as you want them rewritten, not as they actually are.*

### MySQL via Command Line

1. Access MySQL as root user with

  | **21** :$

```console
sudo mysql
```

2. Create a database admin user in MySQL with: (user: `admin` password: `adminpassword`)

  | **22** :>  `GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;`

  | **23** :> `FLUSH PRIVILEGES;`

3. Exit MySQL

  | **24** :> `QUIT;`

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

### MySQL phpMyAdmin

1. Install this as an Arch package

  | **25** :$

```console
sudo pacman -S phpmyadmin --noconfirm
```

2. Link it to the web directory

  | **26** :$

```console
sudo ln -sfn /usr/share/webapps/phpMyAdmin /srv/www/html/
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
