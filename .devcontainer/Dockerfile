FROM eclipse-temurin:25-jdk

# Skip all apt-get installs to avoid Docker runtime errors on OCI
# The base image already contains Java 25 which is the critical requirement

# Create the vscode user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

USER $USERNAME
