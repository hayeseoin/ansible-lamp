#!/bin/bash

# Set variables if not set ant env level
# export JDK_VERSION="jdk-11.0.27+6"
# export OPENJDK_DOWNLOAD_URL="https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.27%2B6/OpenJDK11U-jdk_x64_linux_hotspot_11.0.27_6.tar.gz
# export JAVA_INSTALL_DIR=/usr/lib/jvm
# export OPT_JAVA=/opt/java
# export JAVA_ARCHIVE="OpenJDK11U-jdk_x64_linux_hotspot_11.0.27_6.tar.gz"
# 
# If script is not already being intiaisted from 
# a directory with Java, download it
# wget -N $OPENJDK_DOWNLOAD_URL

mkdir -p $JAVA_INSTALL_DIR
tar -xf $JAVA_ARCHIVE  -C $JAVA_INSTALL_DIR/ 
rm -rf $OPT_JAVA 
ln -s $JAVA_INSTALL_DIR/$JDK_VERSION $OPT_JAVA 
echo "export JAVA_HOME=$OPT_JAVA" > /etc/profile.d/java.sh
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile.d/java.sh


