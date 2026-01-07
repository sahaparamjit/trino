FROM mcr.microsoft.com/devcontainers/java:21

# Switch to root to install Java 25 manually
USER root

# Download and install Temurin JDK 25 (avoiding apt-get)
RUN mkdir -p /opt/java/openjdk \
    && curl -L https://api.adoptium.net/v3/binary/latest/25/ga/linux/aarch64/jdk/hotspot/normal/eclipse?project=jdk -o /tmp/java25.tar.gz \
    && tar -xzf /tmp/java25.tar.gz -C /opt/java/openjdk --strip-components=1 \
    && rm /tmp/java25.tar.gz

# Set JAVA_HOME for the new JDK
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH=$JAVA_HOME/bin:$PATH

# Ensure the vscode user owns the Java directory (optional but good practice)
RUN chown -R vscode:vscode /opt/java/openjdk

# Switch back to the default devcontainer user
USER vscode
