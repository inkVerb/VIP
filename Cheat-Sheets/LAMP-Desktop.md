# LAMP Desktop
## *This is not secure, not for a production server!*
*This is for your local desktop developer environment only!*

1. `sudo apt install mysql-server php lamp-server^`
2. Turn on the PHP-MySQL functionality
  - `sudo vim /etc/php/7.2/apache2/php.ini` (maybe `7.2` is a different number)
  - Uncomment `extension=mysqli`
    - Type: `/mysqli` to find the line, then Enter
    - Move the cursor to `;` then press `x`
    - Save & quit: `:wq`
4. Restart Everything
  - `sudo systemctl restart apache2`
5. Look for the green dot for the All-OK
  `sudo systemctl status apache2`

Now, everything at
- `/var/www/html/SOMETHING/`

can be accessed in your browser at
- `localhost/SOMETHING/`

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

**Don't have a "root user" password?**
- `sudo passwd`
- Now you can login to the MySQL as `root` or the terminal with `su`
- ***But this can be dangerous, be careful!***
