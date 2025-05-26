#!/bin/bash

# Tomcat URL
# https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.102/
# bin/apache-tomcat-9.0.102.tar.gz

TOMCAT_VERSIONS=$(curl -s https://archive.apache.org/dist/tomcat/tomcat-9/ \
| grep -oP '(?<=href=")[^"]+' \
| sed 's:/$::' \
| tr -d 'v' \
| grep -P '^\d+\.\d+\.\d+$')

LATEST_VERSION=$(echo "$TOMCAT_VERSIONS" | sort -V | tail -n1)

echo 'tomcat9:' > tomcat9.yml
  echo "  - version: \"latest\"" >> tomcat9.yml 
  echo "  - version_number: \"$LATEST_VERSION\"" >> tomcat9.yml
  echo "    tomcat_name: \"apache-tomcat-$LATEST_VERSION\"" >> tomcat9.yml
  echo "    archive_name: \"apache-tomcat-$LATEST_VERSION.tar.gz\"" >> tomcat9.yml
  echo "    public_download_url: \"https://archive.apache.org/dist/tomcat/tomcat-9/v$LATEST_VERSION/bin/apache-tomcat-$LATEST_VERSION.tar.gz\"" >> tomcat9.yml
for i in $TOMCAT_VERSIONS
do
  echo "  - version: \"$i\"" >> tomcat9.yml
  echo "  - version_number: \"$i\"" >> tomcat9.yml
  echo "    tomcat_name: \"apache-tomcat-$i\"" >> tomcat9.yml
  echo "    archive_name: \"apache-tomcat-$i.tar.gz\"" >> tomcat9.yml
  echo "    public_download_url: \"https://archive.apache.org/dist/tomcat/tomcat-9/v$i/bin/apache-tomcat-$i.tar.gz\"" >> tomcat9.yml
done




