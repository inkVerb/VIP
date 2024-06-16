#!/bin/bash

# This installs LEMP to an Arch/Manjaro Desktop with a www web user

# Check web dependency
if [ ! -d "/srv/www/html/" ] || [ ! -e "/usr/bin/mysql" ]; then
  echo "First set up a LAMP or LEMP serving: /srv/www/html/"
fi

# Instructions
if [ ! -d "phpMyAdmin" ] || [ ! -f "phpMyAdmin/config.sample.inc.php" ] || [ -f "phpMyAdmin/config.inc.php" ]; then
  echo "phpMyAdmin download folder not properly found.
Before proceeding:
  1. Download [phpMyAdmin](https://www.phpmyadmin.net/downloads/)
  2. Extract and rename the folder to the current directory: phpMyAdmin"
fi

# Move and set it up
mv phpMyAdmin /srv/www/html/
cp /srv/www/html/phpMyAdmin/config.sample.inc.php /srv/www/html/phpMyAdmin/config.inc.php
sed -i "s/cfg\['blowfish_secret'\] = '';/cfg\['blowfish_secret'\] = '$(pwgen -c -1 32)';/" /srv/www/html/phpMyAdmin/config.inc.php
chown -R www:www /srv/www/html/phpMyAdmin

# Finish message
echo "
phpMyAdmin set up!

Make sure the SQL and web server are running, then...

Use MySQL credentials to login at:
  localhost/phpMyAdmin
"
