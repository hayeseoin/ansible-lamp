#!/bin/bash


# export PHP_DOWNLOAD_LINK="https://github.com/hayeseoin/al2023-php74/raw/refs/heads/main/php-7.4.tar.gz"
# export PHP_NAME="php-7.4.tar.gz"
# wget -N $PHP_DOWNLOAD_LINK

# Must be run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "This script must be run as root. Exiting."
  exit 1
fi

tar -xvf $PHP_ARCHIVE -C /usr/local/

rm /usr/bin/php
rm /usr/bin/phpize
rm /usr/bin/php-config

ln -s /usr/local/php-7.4/bin/php /usr/bin/php
ln -s /usr/local/php-7.4/bin/phpize /usr/bin/phpize
ln -s /usr/local/php-7.4/bin/php-config /usr/bin/php-config

if [ -d /etc/httpd/conf.d ]; then
  cp php74-fpm.conf /etc/httpd/conf.d/php.conf
  apachectl graceful
else
  echo "Skipping PHP-Apache integration: httpd not installed."
fi


cp php74-fpm.service /etc/systemd/system/php-fpm.service
systemctl daemon-reload
systemctl enable php-fpm.service --now