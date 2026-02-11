# Dockerfile for EPICS OPI PHoebus
FROM ubuntu:25.10

ENV DEBIAN_FRONTEND=noninteractive
ENV VERSION=5.0.2

RUN apt-get update && apt-get install -y \
    curl \
    locales \
    sudo \
    git \
    git-lfs \
    libx11-6 \
    libxcb1 \
    libxkbcommon0 \
    libxkbcommon-x11-0 \
    libxrender1 \
    libxrandr2 \
    x11-xkb-utils \
    xkb-data \
    libasound2t64 \
    libvulkan1 \
    vulkan-tools \
    mesa-vulkan-drivers \
    libgl1 \
    libxext6 \
    libxcursor1 \
    dbus \
    libdbus-1-3 \
    build-essential \
    python3 \
    python3-pip \
    nodejs \
    npm \
    ripgrep \
    fd-find \
    rsync

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Install docker cli and docker compose only
RUN curl -LsSf https://download.docker.com/linux/static/stable/x86_64/docker-24.0.2.tgz | tar -xz -C /usr/local/bin --strip-components=1 docker/docker
RUN curl -LsSf https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# Install devcontainer CLI
RUN npm install -g @devcontainers/cli

# Ensure directories exist with proper permissions for devcontainer
RUN mkdir -p /root/.config /root/Documents && chmod 777 /root/.config /root/Documents

# Ensure directories exist with proper permissions for devcontainer
RUN mkdir -p /root/Documents && chmod 755 /root/Documents

# Use C locale to avoid xkbcommon keysym issues
ENV LANG C
ENV LC_ALL C
ENV ZED_ALLOW_EMULATED_GPU=1
ENV ZED_ALLOW_ROOT=true
# X11-only rendering environment
ENV GDK_BACKEND=x11
ENV QT_QPA_PLATFORM=xcb
# Disable hang detection - first frame can be slow
ENV ZED_DISABLE_HANG_DETECTION=1
# Use Vulkan backend (works with NVIDIA GPU passthrough)
ENV WGPU_BACKEND=vulkan
# Suppress xkbcommon warnings
ENV XKB_CONFIG_ROOT=/usr/share/X11/xkb

RUN curl -fO https://zed.dev/install.sh
RUN bash ./install.sh

ENTRYPOINT ["/root/.local/bin/zed", "--foreground"]
