# Dependencies 

```
sudo apt install apache2 cron ffmpeg flac gosu inotify-tools lame libavcodec-extra libev-libevent-dev libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev libvpx-dev php php-curl php-gd php-json php-ldap php-mysql php-xml php-zip vorbis-tools zip unzip php-intl php-xml mariadb-server
sudo a2enmod rewrite
```

# Install composer as user like this
```
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer
sudo chown -R www-data:www-data /var/www/

sudo vim /etc/php/7.4/apache2/php.ini and change post_max_size = 100M and upload_max_filesize = 100M and memory_limit = 3G
sudo su - www-data -s /bin/bash
git clone -b release5 https://github.com/ampache/ampache.git ampache
rm -rf /var/www/html
ln -s /var/www/ampache/public /var/www/html
# edit composer.json and remove the lines relative to php-soundcloud save and exit
cd ampache
composer install
```
# Install database
```
sudo mysql_secure_installation


systemctl edit mariadb.service

[Service]
MemoryMax=1024M
MemorySwapMax=128M
```

# Restart services
```
systemctl restart mariadb.service
systemctl restart apache2.service
```
Then follow the instruction here: https://github.com/ampache/ampache/wiki/Installation


# Upgrade ampache to a new release

1) install latest version of composer

```
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
```

2) login as www-data and update the git repository and the composer packages
``` sudo su - www-data
cd /var/www/ampache
git pull
composer update
composer install
```


