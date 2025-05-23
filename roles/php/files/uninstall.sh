#!/bin/bash

# Must be run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "This script must be run as root. Exiting."
  exit 1
fi

rm /usr/bin/php
rm /usr/bin/phpize
rm /usr/bin/php-config
rm -rf /usr/local/php-7.4/
if [ -d /etc/httpd/conf.d ]; then
  rm /etc/httpd/conf.d/php.conf
  apachectl graceful
else
  echo "Skipping PHP-Apache integration: httpd not installed."
fi
rm /etc/systemd/system/php-fpm.service
systemctl daemon-reload
# sudo dnf remove -y libicu libxslt oniguruma libedit libuuid
