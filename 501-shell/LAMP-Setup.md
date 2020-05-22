# PHP setup

## 1. Install LAMP

### Make PHP secure

`sudo mkdir -p /var/www/tmp`

`sudo chmod -R 777 /var/www/tmp`

`sudo chmod 644 /etc/php/7.2/apache2/php.ini`

Open php.ini and make these settings:

`sudo vim /etc/php/7.2/apache2/php.ini`

```
open_basedir = /var/www

sys_temp_dir = /var/www/tmp

upload_tmp_dir = /var/www/tmp
```

... Now you can use PHP to upload, but php is limited to the www directory
