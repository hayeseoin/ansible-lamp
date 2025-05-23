#!/bin/bash

# Set variables if not set ant env level
# JDK_VERSION=
# OPENJDK_DOWNLOAD_URL=
# JAVA_INSTALL_DIR=
# OPT_JAVA=
# 
# If script is not already being intiaisted from 
# a directory with Java, download it
# wget -N $OPENJDK_DOWNLOAD_URL

set -euxo pipefail

wget -N $OPENJDK_DOWNLOAD_URL
mkdir -p $JAVA_INSTALL_DIR
tar -xf OpenJDK11U-jdk_x64_linux_hotspot_11.0.27_6.tar.gz \
    -C $JAVA_INSTALL_DIR/ 
ln -s $JAVA_INSTALL_DIR/$JDK_VERSION $OPT_JAVA 
echo "export JAVA_HOME=$OPT_JAVA" > /etc/profile.d/java.sh
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile.d/java.sh
# chmod +x /etc/profile.d/java.sh



