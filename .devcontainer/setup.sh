#!/bin/bash
set -e

echo "Installing Temurin JDK 25..."

# Install prerequisites
sudo apt-get update
sudo apt-get install -y wget apt-transport-https gnupg

# Add Adoptium repository
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg
echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(grep VERSION_CODENAME /etc/os-release | cut -d= -f2) main" | sudo tee /etc/apt/sources.list.d/adoptium.list

# Update and install Temurin 25 JDK
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y temurin-25-jdk

# Set up Java environment
echo 'export JAVA_HOME=/usr/lib/jvm/temurin-25-jdk-$(dpkg --print-architecture)' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

# Verify installation
java -version

echo "Temurin JDK 25 installation complete!"
