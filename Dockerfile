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

ENV LANG en_GB.UTF-8
ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket
ENV XCOMPOSEFILE=/dev/null

# full sudo rights inside the container
COPY /sudoers /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

RUN curl -fO https://zed.dev/install.sh
RUN bash ./install.sh

ENTRYPOINT ["/home/ubuntu/.local/bin/zed", "--foreground"]
