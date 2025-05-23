#!/bin/bash

# Must be run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "This script must be run as root. Exiting."
  exit 1
fi

# # Ensure script is run from relative directory
# cd "$(dirname "$0")" || {
#   echo "Failed to change to script directory"
#   exit 1
# }

sudo dnf install -y libicu libxslt oniguruma libedit libuuid
sudo dnf install -y tar 

wget -N $PHP_DOWNLOAD_LINK
tar -xvf php-7.4.tar.gz -C /usr/local/

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