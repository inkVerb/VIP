# Web-Dev Desktop
## These scripts will install a webstack

- [LAMP Desktop script](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/desktoplamp.sh) (Apache; HTML and PHP)
- [LEMP Desktop script](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/desktoplemp.sh) (Nginx; broken: only HTML, not PHP)
- [phpMyAdmin script](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/desktopsqladmin.sh) (MySQL GUI)

## LAMP/LEMP Install
1. Download the script to the current directory with the same file name
2. `chmod ug+x desktoplamp.sh` (LAMP) or `chmod ug+x desktoplemp.sh` (LEMP)
3. Delete the script when done

## phpMyAdmin Install
1. Follow the above steps with one of the two scripts (or otherwise make sure a web server is serving `/srv/www/html/`)
2. Download [phpMyAdmin](https://www.phpmyadmin.net/downloads/)
3. Extract and rename the folder to the current directory: `phpMyAdmin`

### Install with script
4. Download the **phpMyAdmin** script ([desktopsqladmin.sh](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/desktopsqladmin.sh)) to the current directory with the same file name
5. `chmod ug+x desktopsqladmin.sh`

### Install with these commands (no script)
4. Enter these commands in the same directory as the new `phpMyAdmin` folder :$

```console
sudo mv phpMyAdmin /srv/www/html/
sudo cp /srv/www/html/phpMyAdmin/config.sample.inc.php /srv/www/html/phpMyAdmin/config.inc.php
sudo sed -i "s/cfg\['blowfish_secret'\] = '';/cfg\['blowfish_secret'\] = '$(pwgen -c -1 32)';/" /srv/www/html/phpMyAdmin/config.inc.php
sudo chown -R www:www /srv/www/html/phpMyAdmin
```

## Using (After Installed)
- *Start* the **LAMP** server with:

```console
sudo systemctl start mariadb httpd
```

- *Start* the **LEMP** server with:

```console
sudo systemctl start mariadb nginx php-fpm
```

- Login to MySQL in the terminal with:

```console
mariadb -u admin -padminpassword
```

- Login to phpMyAdmin at: `localhost/phpMyAdmin`
  - User: `admin`
  - Password: `adminpassword`

- Access your `/srv/www/html/` directory in any browser at: `localhost/`

- Work on web files locally, then push to the server to test:
  - Work in: `~/Work/dev/`
  - Browse in: `localhost/vip`
  - Copy working files with:
```console
sudo cp -r ~/Work/dev/* ~/Work/vip/ && sudo chown -R www:www ~/Work/vip
```

## Make the Server a Permanent Service
*These web stacks are installed so that they do not run as permanent services unless you start them each time after booting your machine.*

- If you want to make the **LAMP** server a *permanent service:*

```console
sudo systemctl enable mariadb
sudo systemctl enable httpd
sudo systemctl start mariadb httpd
```

- If you want to make the **LEMP** server a *permanent service:*

```console
sudo systemctl enable mariadb
sudo systemctl enable nginx
sudo systemctl enable php-fpm
sudo systemctl start mariadb nginx php-fpm
```

- If you want to *remove* the **LAMP** server as a *permanent service:*

```console
sudo systemctl disable mariadb
sudo systemctl disable httpd
sudo systemctl stop mariadb httpd
```

- If you want to *remove* the **LEMP** server as a *permanent service:*

```console
sudo systemctl disable mariadb
sudo systemctl disable nginx
sudo systemctl disable php-fpm
sudo systemctl stop mariadb nginx php-fpm
```