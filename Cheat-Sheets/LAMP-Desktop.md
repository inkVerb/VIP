# LAMP Desktop
## PHP/MySQL developer environment directly in Ubuntu
*(rather than WAMPP or XAMPP in Windows)*

### *This is for your local desktop developer environment only, not secure for production!*

1. `sudo apt install mysql-server php lamp-server^`
2. Turn on the PHP-MySQL functionality in your `php.ini` file
  - Uncomment `extension=mysqli` (remove the semicolon `;` at the start of the line)
  - Edit with `vim`:
    - `sudo vim /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)
    - Search with: `/mysqli` to find the line, then Enter
  - Or edit with `gedit`:
    - `sudo gedit /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)
    - Search with: Ctrl + F, `mysqli` to find the line
4. Restart Everything
  - `sudo systemctl restart apache2`
5. Look for the green dot for the All-OK
  - `sudo systemctl status apache2`

Now...

`/var/www/html/SOMETHING/` = WebBrowser: `localhost/SOMETHING/`

**Always own it first!**
- `sudo chown -R www-data:www-data /var/www/html/`

Life is easier with a local "Work" folder symlink
- `mkdir -p ~/Work/vip`
- `sudo ln -sfn ~/Work/vip /var/www/html/`
- Now:
  - Your projects go in: `~/Work/vip/`
  - Use the web address: `localhost/vip/SOMETHING/`
  - No permissions problems! You're welcome.

## MySQL via command line

Access MySQL as root user with
- `sudo mysql`

Access any MySQL user you created later with
- `mysql -u USERNAME -p` (then enter the password)

## MySQL phpMyAdmin

1. Download [phpMyAdmin](https://www.phpmyadmin.net/downloads/)
2. Extract and renamename the folder to: `phpMyAdmin`
3. In the terminal, move it to `/var/www/html` (so it is at `/var/www/html/phpMyAdmin`)
  - `sudo mv phpMyAdmin /var/www/html/`
4. Create the config
  - `cd /var/www/html/phpMyAdmin`
  - `sudo cp config.sample.inc.php config.inc.php`

5. Own everything properly
  - `sudo chown -R www-data:www-data /var/www/html/phpMyAdmin`

Now, you should be able to access this in your browser at the address:
- `localhost/phpMyAdmin/index.php`

Login the first time with:
- Username: `root`
- Password: Your normal desktop root user password
- Create a new admin or database & user ASAP, use that in the future!

***Don't have a "root user" password?***
- `sudo passwd` (password three times)
- Now you can login to the MySQL as `root` or the terminal with `su`
- ***But this can be dangerous, be careful!***
