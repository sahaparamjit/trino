FROM eclipse-temurin:25-jdk

# Install git and other tools, working around OCI Docker/apt issues
RUN echo 'APT::Update::Post-Invoke {"true";};' > /etc/apt/apt.conf.d/99-workaround \
    && echo 'DPkg::Post-Invoke {"true";};' >> /etc/apt/apt.conf.d/99-workaround \
    && apt-get update || echo "Update failed, proceeding..." \
    && apt-get install -y --no-install-recommends git curl wget vim sudo \
    && rm -rf /var/lib/apt/lists/*

# Ensure user 1000 exists and has a home directory
RUN if ! getent passwd 1000 > /dev/null; then \
        groupadd --gid 1000 vscode \
        && useradd --uid 1000 --gid 1000 -m -s /bin/bash vscode; \
    else \
        # If user 1000 exists, ensure it has a shell and home setup if needed \
        EXISTING_USER=$(getent passwd 1000 | cut -d: -f1) \
        && usermod -s /bin/bash $EXISTING_USER; \
    fi

# Configure sudo for user 1000 (whoever they are)
RUN echo '%1000 ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/1000-nopasswd \
    && chmod 0440 /etc/sudoers.d/1000-nopasswd

USER 1000
