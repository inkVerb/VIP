#!/bin/bash

# This installs LEMP to an Arch/Manjaro Desktop with a www web user
##DEV Currently does not work with PHP-FPM, only serving static html pages

# Update
pacman -Syyu --needed --noconfirm

# Tools
pacman -S --needed --noconfirm pwgen zip htop which vim curl wget make cronie

# Setup LEMP
pacman -S --needed --noconfirm nginx mariadb php php-fpm

# Web user & folder
groupadd www
useradd -g www www
usermod -a -G www http
mkdir -p /srv/www/html
chmod u+w /srv/www
chmod u+w /srv/www/html
chown -R www:www /srv/www

# Update server settings
### Web user
sed -i "s/^user =.*/user = www/" /etc/php/php-fpm.d/www.conf
sed -i "s/^group =.*/group = www/" /etc/php/php-fpm.d/www.conf
sed -i "s/^listen.owner =.*/listen.owner = www/" /etc/php/php-fpm.d/www.conf
sed -i "s/^listen.group =.*/listen.group = www/" /etc/php/php-fpm.d/www.conf

sed -i "s?user = http?user = www?" /etc/php/php-fpm.d/www.conf
sed -i "s?group = http?group = www?" /etc/php/php-fpm.d/www.conf
sed -i "s?listen.owner = http?listen.owner = www?" /etc/php/php-fpm.d/www.conf
sed -i "s?listen.group = http?listen.group = www?" /etc/php/php-fpm.d/www.conf

# Local link in Work folder (for each desktop user)
mkdir -p /srv/www/html/vip
chmod u+w /srv/www/html/vip
chown -R www:www /srv/www
for deskuser in /home/*; do
  deskuser=$(basename $deskuser)
  if [ -d "/home/$deskuser/.config" ] && [ -d "/home/$deskuser/.local" ]; then
    mkdir -p /home/$deskuser/Work/dev
    ln -sfn /srv/www/html/vip /home/$deskuser/Work/
    chown -R $deskuser:$deskuser /home/$deskuser/Work
  fi
done

# PHP Settings
sed -i 's/;extension=mysqli/extension=mysqli/' /etc/php/php.ini
sed -i 's/;extension=pdo_mysql/extension=pdo_mysql/' /etc/php/php.ini
sed -i 's/;extension=iconv/extension=iconv/' /etc/php/php.ini
sed -i 's/^upload_max_filesize.*/upload_max_filesize = 50M/' /etc/php/php.ini
sed -i 's/^file_uploads.*/file_uploads = On/' /etc/php/php.ini

# Nginx settings
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.vipbak
# # Replaces the cat heredoc below; below is more elaborate
# sed -i 's?#user http;?user www www;?' /etc/nginx/nginx.conf
# sed -i 's?/usr/share/nginx/html;?/srv/www/html;?' /etc/nginx/nginx.conf
# sed -i 's?index.html index.htm;?index.html index.htm index.php;?' /etc/nginx/nginx.conf
# cat heredoc; more elaborate; PHP-FPM (created below) not working, so commented
cat <<EOF > /etc/nginx/nginx.conf
user www www;

worker_processes     1;

events {
  worker_connections 1024;
}

http {
  include            mime.types;
  default_type       application/octet-stream;

  sendfile           on;
  keepalive_timeout  65;

  server {
    listen           80;
    server_name      localhost;

    location / {
      root     /srv/www/html;
      index    index.htm index.html index.php;
      include  /srv/www/rewrite; # Rewrites go here, more convenient
    }
    
    # location ~ [^/]\.(php|html|htm)(/|$) {
    #   root     /srv/www/html;
    #   include  /etc/nginx/php_fastcgi.conf;
    # }
      
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
      root     /srv/www/html;
    }
  }

}
EOF

touch /srv/www/rewrite
chown -R www:www /srv/www

## PHP-FPM
cat <<'EOF' > /etc/nginx/php_fastcgi.conf
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

## MySQL via Command Line
/usr/bin/mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
/usr/bin/mariadb -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;"

# Start Services
systemctl start nginx
systemctl start mariadb
systemctl start php-fpm

# - Check for specific errors in Nginx server configs
# nginx -t

# Remove unneeded packages
pacman -Rsc --noconfirm
pacman -Scc --noconfirm

# Finish message
echo "
LEMP is set up!

Start with:
  systemctl start mariadb nginx php-fpm

MySQL
  user: admin password: adminpassword

Work in: ~/Work/dev/
Browse in: localhost/vip
Copy working files with:
  cp -r ~/Work/dev/* ~/Work/vip/ && chown -R www:www ~/Work/vip
"