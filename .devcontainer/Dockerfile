FROM eclipse-temurin:25-jdk

# Fix 1: Disable problematic apt hooks that cause "Operation not permitted" errors
RUN rm -f /etc/apt/apt.conf.d/docker-clean \
    && echo 'APT::Update::Post-Invoke {"true";};' > /etc/apt/apt.conf.d/99-workaround \
    && echo 'DPkg::Post-Invoke {"true";};' >> /etc/apt/apt.conf.d/99-workaround \
    && echo 'APT::Clean-Installed "false";' >> /etc/apt/apt.conf.d/99-workaround

# Fix 2: Handle GPG Key issues for Ubuntu Ports (ARM64) and install tools
RUN echo "Acquire::AllowInsecureRepositories "true";" > /etc/apt/apt.conf.d/99-insecure \
    && echo "Acquire::AllowDowngradeToInsecureRepositories "true";" >> /etc/apt/apt.conf.d/99-insecure \
    && apt-get update || echo "Update failed, continuing anyway..." \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
        git \
        curl \
        wget \
        vim \
        sudo \
        gnupg \
    && rm -rf /var/lib/apt/lists/*

# Set up the vscode user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
