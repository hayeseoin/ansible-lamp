#!/bin/bash

NEW_PASSWORD="YourSecurePassword123!"
TEMP_PASSWORD=$(sudo grep 'temporary password' /var/log/mysqld.log | tail -1 | awk '{print $NF}')

if [[ -z "$TEMP_PASSWORD" ]]; then
  echo "Could not find a temporary MySQL password in /var/log/mysqld.log"
  exit 1
fi

echo "Temporary password found. Attempting to update root password..."

mysql --connect-expired-password -u root -p"$TEMP_PASSWORD" <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${NEW_PASSWORD}';
EOF

# Check if the password change was successful
if [[ $? -ne 0 ]]; then
  echo "Failed to change MySQL root password."
  exit 1
fi

# Write credentials to /root/.my.cnf for passwordless login
cat <<EOF | sudo tee /root/.my.cnf > /dev/null
[client]
user=root
password=${NEW_PASSWORD}
EOF

sudo chmod 600 /root/.my.cnf
