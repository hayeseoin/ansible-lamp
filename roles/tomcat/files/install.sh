#!/bin/bash

# TOMCAT_ARCHIVE=
# TOMCAT_INSTALL_LOCATION=/usr/share
# TOMCAT_SYS_HOME=/usr/share/tomcat9
# TOMCAT_SERVICE_FILE=tomcat9.service

TOMCAT_DIR_NAME=$(basename "$TOMCAT_ARCHIVE" .tar.gz)
TOMCAT_SERVICE_NAME=$(basename "$TOMCAT_SERVICE_FILE" .service)

mkdir -p $TOMCAT_SYS_HOME

if ! getent group tomcat > /dev/null; then
  groupadd tomcat
else
  echo 'tomcat group already exists: Skipping.'
fi

if ! id tomcat > /dev/null 2>&1; then
  useradd -g tomcat -s /bin/bash -c "Tomcat user" -d "$TOMCAT_SYS_HOME" 
else
  echo 'tomcat user already exists: Skipping.'
fi

tar -zxf $TOMCAT_ARCHIVE -C $TOMCAT_INSTALL_LOC
ln -s $TOMCAT_DIR_NAME $TOMCAT_SYS_HOME

chown -R tomcat:tomcat $TOMCAT_SYS_HOME
chown -R tomcat:tomcat $TOMCAT_DIR_NAME

cp $TOMCAT_SERVICE_FILE /etc/systemd/system/

systemctl daemon-reload
systemctl enable $TOMCAT_SERVICE_NAME --now
