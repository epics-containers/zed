# Dockerfile for EPICS OPI PHoebus
FROM ubuntu:25.10

ENV DEBIAN_FRONTEND=noninteractive
ENV VERSION=5.0.2

RUN apt-get update && apt-get install -y \
    curl \
    locales \
    sudo \
    libx11-6 \
    libxcb1 \
    libxkbcommon0 \
    x11-xkb-utils \
    xkb-data \
    libasound2t64 \
    libvulkan1 \
    mesa-vulkan-drivers \
    libgl1 \
    libxext6 \
    dbus \
    libdbus-1-3

RUN sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_GB.UTF-8

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Install docker cli and docker compose only
RUN curl -LsSf https://download.docker.com/linux/static/stable/x86_64/docker-24.0.2.tgz | tar -xz -C /usr/local/bin --strip-components=1 docker/docker
RUN curl -LsSf https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

ENV LANG en_GB.UTF-8
ENV ZED_ALLOW_EMULATED_GPU=1
ENV ZED_ALLOW_ROOT=true

RUN curl -fO https://zed.dev/install.sh
RUN bash ./install.sh

ENTRYPOINT ["/root/.local/bin/zed", "--foreground"]
