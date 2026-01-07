#!/bin/bash
set -e

# Check if Java 25 is already installed
if [ -d "/opt/java/openjdk-25" ]; then
    echo "Java 25 already installed."
    exit 0
fi

echo "Installing Java 25..."
sudo mkdir -p /opt/java/openjdk-25

# Download Temurin 25 (using wget which might be more robust, or curl)
# We try curl first, then wget
URL="https://api.adoptium.net/v3/binary/latest/25/ga/linux/aarch64/jdk/hotspot/normal/eclipse?project=jdk"

curl -L $URL -o /tmp/java25.tar.gz || wget -O /tmp/java25.tar.gz $URL

sudo tar -xzf /tmp/java25.tar.gz -C /opt/java/openjdk-25 --strip-components=1
rm /tmp/java25.tar.gz

# Set permissions
sudo chown -R vscode:vscode /opt/java/openjdk-25

# Update JAVA_HOME in bashrc
echo 'export JAVA_HOME=/opt/java/openjdk-25' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

echo "Java 25 installation complete."
