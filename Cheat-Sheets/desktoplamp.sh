#!/bin/bash

# This installs LAMP to an Arch/Manjaro Desktop with a www web user

# Update
/usr/bin/pacman -Syyu --needed --noconfirm

# Tools
/usr/bin/pacman -S --needed --noconfirm pwgen zip htop which vim curl wget make cronie

# Setup LAMP
/usr/bin/pacman -S --needed --noconfirm apache php php-apache php-fpm mariadb

# Web user & folder
/usr/bin/groupadd www
/usr/bin/useradd -g www www
/usr/bin/usermod -a -G www http
/usr/bin/mkdir -p /srv/www/html
/usr/bin/chmod u+w /srv/www
/usr/bin/chmod u+w /srv/www/html
/usr/bin/chown -R www:www /srv/www

# Update server to www user
/usr/bin/sed -i "s/^User.*/User www/" /etc/httpd/conf/httpd.conf
/usr/bin/sed -i "s/^Group.*/Group www/" /etc/httpd/conf/httpd.conf
/usr/bin/sed -i "s/^user =.*/user = www/" /etc/php/php-fpm.d/www.conf
/usr/bin/sed -i "s/^group =.*/group = www/" /etc/php/php-fpm.d/www.conf
/usr/bin/sed -i "s/^listen.owner =.*/listen.owner = www/" /etc/php/php-fpm.d/www.conf
/usr/bin/sed -i "s/^listen.group =.*/listen.group = www/" /etc/php/php-fpm.d/www.conf

# Local link in Work folder (for each desktop user)
/usr/bin/mkdir -p /srv/www/html/vip
/usr/bin/chmod u+w /srv/www/html/vip
/usr/bin/chown -R www:www /srv/www
for deskuser in /home/*; do
  deskuser=$(/usr/bin/basename $deskuser)
  if [ -d "/home/$deskuser/.config" ] && [ -d "/home/$deskuser/.local" ]; then
    mkdir -p /home/$deskuser/Work/dev
    ln -sfn /srv/www/html/vip /home/$deskuser/Work/
    chown -R $deskuser:$deskuser /home/$deskuser/Work
  fi
done

# PHP Settings
/usr/bin/sed -i 's/;extension=mysqli/extension=mysqli/' /etc/php/php.ini
/usr/bin/sed -i 's/;extension=pdo_mysql/extension=pdo_mysql/' /etc/php/php.ini
/usr/bin/sed -i 's/;extension=iconv/extension=iconv/' /etc/php/php.ini
/usr/bin/sed -i 's/^upload_max_filesize.*/upload_max_filesize = 50M/' /etc/php/php.ini
/usr/bin/sed -i 's/^file_uploads.*/file_uploads = On/' /etc/php/php.ini

# Apache Settings
/usr/bin/sed -i "s?^LoadModule mpm_event_module modules/mod_mpm_event.so?#LoadModule mpm_event_module modules/mod_mpm_event.so?" /etc/httpd/conf/httpd.conf
/usr/bin/sed -i "s?^#LoadModule mpm_prefork_module modules/mod_mpm_prefork.so?LoadModule mpm_prefork_module modules/mod_mpm_prefork.so?" /etc/httpd/conf/httpd.conf
/usr/bin/sed -i "s?^#LoadModule http2_module modules/mod_http2.so?LoadModule http2_module modules/mod_http2.so?" /etc/httpd/conf/httpd.conf
/usr/bin/sed -i "s?^#LoadModule rewrite_module modules/mod_rewrite.so?LoadModule rewrite_module modules/mod_rewrite.so?" /etc/httpd/conf/httpd.conf
/usr/bin/sed -i 's?DocumentRoot "/srv/http"?DocumentRoot "/srv/www/html"?' /etc/httpd/conf/httpd.conf
/usr/bin/cat <<EOF >> /etc/httpd/conf/httpd.conf
LoadModule php_module modules/libphp.so
AddHandler php-script .php
Include conf/extra/php_module.conf
Protocols h2 http/1.1

<Directory "/srv/www/html">
  Options Indexes FollowSymLinks MultiViews
  AllowOverride All
  Require all granted
  Order allow,deny
  allow from all
</Directory>
EOF

## PHP-FPM
/usr/bin/cat <<'EOF' > /etc/nginx/php_fastcgi.conf
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
EOF

## Security extensions
/usr/bin/echo 'security.limit_extensions = .php .html .htm .shtml' >> /etc/php/php-fpm.d/www.conf
## Only start PHP-FPM service after file system target
/usr/bin/mkdir -p /etc/systemd/system/php-fpm.service.d
/usr/bin/echo '[Unit]' > /etc/systemd/system/php-fpm.service.d/mount.conf

### MySQL via Command Line
/usr/bin/mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
#### Start MariaDB so we can interact with it
/usr/bin/systemctl start mariadb
/usr/bin/mariadb -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;"

# Start Other Services
/usr/bin/systemctl start httpd
/usr/bin/systemctl start php-fpm

# - Check for specific errors in Apache server configs
# apachectl -t

# - Check for Apache users and Settings
# apachectl -S

# Remove unneeded packages
/usr/bin/pacman -Rsc --noconfirm
/usr/bin/pacman -Scc --noconfirm

# Finish message
echo "
LEMP is set up!

Start with:
  systemctl start mariadb httpd

MySQL
  user: admin password: adminpassword

Work in: ~/Work/dev/
Browse in: localhost/vip
Copy working files with:
  cp -r ~/Work/dev/* ~/Work/vip/ && chown -R www:www ~/Work/vip
"