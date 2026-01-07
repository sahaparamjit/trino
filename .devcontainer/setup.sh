#!/bin/bash
set -e

echo "Installing Temurin JDK 25..."

# Remove problematic apt configuration that causes permission errors
sudo rm -f /etc/apt/apt.conf.d/*Post-Invoke* /etc/apt/apt.conf.d/*clean* || true

# Install prerequisites
sudo apt-get update -o APT::Update::Post-Invoke::= || sudo apt-get update --allow-releaseinfo-change
sudo apt-get install -y wget apt-transport-https gnupg ca-certificates

# Add Adoptium repository
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg
echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(grep VERSION_CODENAME /etc/os-release | cut -d= -f2) main" | sudo tee /etc/apt/sources.list.d/adoptium.list

# Update and install Temurin 25 JDK
sudo apt-get update -o APT::Update::Post-Invoke::= || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o DPkg::Post-Invoke::= temurin-25-jdk

# Set up Java environment
JAVA_ARCH=$(dpkg --print-architecture)
echo "export JAVA_HOME=/usr/lib/jvm/temurin-25-jdk-${JAVA_ARCH}" >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

# Source for current session
export JAVA_HOME="/usr/lib/jvm/temurin-25-jdk-${JAVA_ARCH}"
export PATH="$JAVA_HOME/bin:$PATH"

# Verify installation
java -version

echo "Temurin JDK 25 installation complete!"
