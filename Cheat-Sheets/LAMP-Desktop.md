# LAMP Desktop
## PHP/MySQL developer environment directly in Ubuntu
*(rather than WAMPP or XAMPP in Windows)*

***This is for your local desktop developer environment only, not secure for production!***

### Setup LAMP

#### Install

1. Install the LAMP server

| **1** : `sudo apt install mysql-server php lamp-server^`

2. Turn on the PHP-MySQL functionality in your `php.ini` file
  - Uncomment `extension=mysqli` (remove the semicolon `;` at the start of the line)
  - Edit with `gedit`:

    | **2g** : `sudo gedit /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)

    - Search with: Ctrl + F, then type `mysqli` to find the line, Ctrl + S to save

  - Or edit with `vim`:

    | **2v** : `sudo vim /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)

    - Search by typing: `/mysqli`, then Enter to find the line, type `:wq` to save and quit

3. Restart Everything

| **3** : `sudo systemctl restart apache2`

4. Look for the green dot for the All-OK

| **4** : `sudo systemctl status apache2`

  - Type `q` to quit. ;-)

#### Using your local dev server on desktop

- `/var/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

Life is easier with a local "Work" folder symlink

| **5** : `mkdir -p ~/Work/vip`

| **6** : `sudo ln -sfn ~/Work/vip /var/www/html/`

- Now:
  - Your projects go in: `~/Work/vip/SOMETHING`
  - Use the web address: `localhost/vip/SOMETHING`
  - No permissions problems while you do your dev work! You're welcome.
- ***Note: this location won't work with using `<script ... src="files.js">` to include JavaScript. Both the served page and the `src="files.js"` files MUST be physically in `/var/www/html/...` somewhere, not in a symlinked location like this!***

#### Always own web stuff first!

| **7** : `sudo chown -R www-data:www-data /var/www/html/`

#### Make Apache rewrites work

1. Enable the Rewrite mod for Apache

| **8** : `sudo a2enmod rewrite`

| **9** : `sudo systemctl restart apache2`

2. Add some important settings
- Edit with `gedit`:

  | **10g** : `sudo gedit /etc/apache2/sites-available/000-default.conf`

- Or edit with `vim`:

  | **10v** : `sudo vim /etc/apache2/sites-available/000-default.conf`

- After `DocumentRoot /var/www/html` Add these lines:
```
<Directory "/var/www/html">
Options Indexes FollowSymLinks
AllowOverride All
Require all granted
</Directory>
```

3. Reload Apache after any changes to files in `/etc/apache2/sites-available/_____.conf`
| **11** : `sudo systemctl reload apache2`

4. Remember with rewrites...

*Your code must reflect the names of any URLs as you want them rewritten, not as they actually are.*

## MySQL via command line

1. Access MySQL as root user with

  | **12** : `sudo mysql`

2. Create a database admin user in MySQL with: (user: `admin` password: `adminpassword`)

  | **13** :>  `GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;`

  | **14** :> `FLUSH PRIVILEGES;`

3. Exit MySQL

  | **15** :> `QUIT;`

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

## MySQL phpMyAdmin

1. Download [phpMyAdmin](https://www.phpmyadmin.net/downloads/)
2. Extract and rename the folder to: `phpMyAdmin`
3. In the terminal, move it to `/var/www/html/` (so it is at `/var/www/html/phpMyAdmin`)

  | **16** : `sudo mv phpMyAdmin /var/www/html/`

4. Create the config

  | **17** : `cd /var/www/html/phpMyAdmin`

  | **18** : `sudo cp config.sample.inc.php config.inc.php`

5. Set the blowfish salt (32 characters long, random)
  - Edit with `gedit`:

    | **19g** : `sudo gedit /var/www/html/phpMyAdmin/config.inc.php`

  - Or edit with `vim`:

    | **19v** : `sudo vim /var/www/html/phpMyAdmin/config.inc.php`

  - Add the salt here:
    - `$cfg['blowfish_secret'] = '';` ...becomes...
    - `$cfg['blowfish_secret'] = 'SomeRANDOm32characterslongGOhere';`

6. Own everything properly

  | **20** : `sudo chown -R www-data:www-data /var/www/html/phpMyAdmin`

Now, you should be able to access this in your browser at the address:
- `localhost/phpMyAdmin`

Login the first time with the same user you created in "MySQL via command line" above.
