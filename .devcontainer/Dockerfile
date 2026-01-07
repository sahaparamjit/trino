FROM eclipse-temurin:25-jdk

# Create the vscode user only if it doesn't exist
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN if ! getent group $USER_GID > /dev/null 2>&1; then groupadd --gid $USER_GID $USERNAME; fi \
    && if ! getent passwd $USER_UID > /dev/null 2>&1; then useradd --uid $USER_UID --gid $USER_GID -m $USERNAME; fi

# Switch to the user (either existing or new)
USER $USER_UID
