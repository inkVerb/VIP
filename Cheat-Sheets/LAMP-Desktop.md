# LAMP Desktop
## PHP/MySQL developer environment directly in Ubuntu
*(rather than WAMPP or XAMPP in Windows)*

***This is for your local desktop developer environment only, not secure for production!***

### Setup LAMP

#### Install

1. Install the LAMP server
- `sudo apt install mysql-server php lamp-server^`
2. Turn on the PHP-MySQL functionality in your `php.ini` file
  - Uncomment `extension=mysqli` (remove the semicolon `;` at the start of the line)
  - Edit with `gedit`:
    - `sudo gedit /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)
    - Search with: `/mysqli` to find the line, then Enter
  - Or edit with `vim`:
    - `sudo vim /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)
    - Search with: Ctrl + F, `mysqli` to find the line
3. Restart Everything
  - `sudo systemctl restart apache2`
4. Look for the green dot for the All-OK
  - `sudo systemctl status apache2`
  - Type "q" to quit. ;-)

#### Using your local dev server on desktop

`/var/www/html/SOMETHING` = WebBrowser: `localhost/SOMETHING`

Life is easier with a local "Work" folder symlink
- `mkdir -p ~/Work/vip`
- `sudo ln -sfn ~/Work/vip /var/www/html/`
- Now:
  - Your projects go in: `~/Work/vip/SOMETHING`
  - Use the web address: `localhost/vip/SOMETHING`
  - No permissions problems while you do your dev work! You're welcome.
- ***Note: this location won't work with using `<script ... src="files.js">` to include JavaScript. Both the served page and the `src="files.js"` files MUST be physically in `/var/www/html/...` somewhere, not in a symlinked location like this!***

#### Always own web stuff first!
- `sudo chown -R www-data:www-data /var/www/html/`

#### Make Apache rewrites work
1. Enable the Rewrite mod for Apache
- `sudo a2enmod rewrite`
- `sudo systemctl restart apache2`
2. Add some important settings
- Edit with `gedit`:
  - `sudo gedit /etc/apache2/sites-available/000-default.conf`
- Or edit with `vim`:
  - `sudo vim /etc/apache2/sites-available/000-default.conf`
- After `DocumentRoot /var/www/html` Add these lines:
```
<Directory "/var/www/html">
Options Indexes FollowSymLinks
AllowOverride All
Require all granted
</Directory>
```
3. Reload Apache after any changes to files in `/etc/apache2/sites-available/_____.conf`
- `sudo systemctl reload apache2`

4. Remember with rewrites...

*Your code must reflect the names of any URLs as you want them rewritten, not as they actually are.*

## MySQL via command line

1. Access MySQL as root user with
  - `sudo mysql`
2. Create a database admin user in MySQL with: (user: `admin` password: `adminpassword`)
  -  `GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;`
  - `FLUSH PRIVILEGES;`

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
  - `sudo mv phpMyAdmin /var/www/html/`
4. Create the config
  - `cd /var/www/html/phpMyAdmin`
  - `sudo cp config.sample.inc.php config.inc.php`
5. Set the blowfish salt
  - Edit with `gedit`:
    - `sudo gedit /var/www/html/phpMyAdmin/config.inc.php`
  - Or edit with `vim`:
    - `sudo vim /var/www/html/phpMyAdmin/config.inc.php`
  - Add the salt here:
    - `$cfg['blowfish_secret'] = '';` ...becomes...
    - `$cfg['blowfish_secret'] = 'SomeRANDOmThing678goeshere';`

6. Own everything properly
  - `sudo chown -R www-data:www-data /var/www/html/phpMyAdmin`

Now, you should be able to access this in your browser at the address:
- `localhost/phpMyAdmin`

Login the first time with the same user you created in "MySQL via command line" above.
