#!/bin/bash

# export TOMCAT_DOWNLOAD_URL="https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.105/bin/apache-tomcat-9.0.105.tar.gz"
# export TOMCAT_ARCHIVE="apache-tomcat-9.0.105.tar.gz"
# export TOMCAT_INSTALL_LOCATION=/usr/share
# export TOMCAT_SYS_HOME=/usr/share/tomcat9
# export TOMCAT_SERVICE_FILE=tomcat9.service

# export TOMCAT_DIR_NAME=$(basename "$TOMCAT_ARCHIVE" .tar.gz)
# export TOMCAT_SERVICE_NAME=$(basename "$TOMCAT_SERVICE_FILE" .service)

# wget $TOMCAT_DOWNLOAD_URL


if ! getent group tomcat > /dev/null; then
  groupadd tomcat
else
  echo 'tomcat group already exists: Skipping.'
fi

if ! id tomcat > /dev/null 2>&1; then
  useradd -g tomcat -s /bin/bash -c "Tomcat user" -d /nonexistent tomcat 
else
  echo 'tomcat user already exists: Skipping.'
fi

tar -zxf $TOMCAT_ARCHIVE -C $TOMCAT_INSTALL_LOCATION/

rm -rf $TOMCAT_SYS_HOME
ln -s $TOMCAT_INSTALL_LOCATION/$TOMCAT_DIR_NAME $TOMCAT_SYS_HOME

chown -R tomcat:tomcat $TOMCAT_SYS_HOME
chown -R tomcat:tomcat $TOMCAT_INSTALL_LOCATION/$TOMCAT_DIR_NAME

# cp $TOMCAT_SERVICE_FILE /usr/lib/systemd/system/
install -m 644 -D $TOMCAT_SERVICE_FILE /usr/lib/systemd/system/$TOMCAT_SERVICE_FILE
systemctl daemon-reload

# systemctl daemon-reload
# systemctl enable $TOMCAT_SERVICE_NAME --now
