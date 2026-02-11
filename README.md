# ec-phoebus
A container image for the z IDE


## Quick Start

To try zed in a container, download the launcher and scripts:

```bash
cd $HOME/bin
curl -O https://raw.githubusercontent.com/epics-containers/zed/refs/heads/main/zed

# run zed with:
zed
```

## Troubleshooting

### NVIDIA Container Toolkit (for GPU acceleration)

If you see a black screen and have an NVIDIA GPU, you likely need to install the NVIDIA Container Toolkit to enable GPU access inside the container.

**Installation on Ubuntu/Debian:**

```bash
# Add NVIDIA Container Toolkit repository
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Install toolkit
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Generate CDI spec for podman
sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
```

**For other distributions:** See [NVIDIA Container Toolkit installation guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

### Podman 5.0+ Socket Configuration

If you're using **Podman 5.0 or later** and want to use `podman` inside the container (podman-outside-podman), you must configure the podman socket to remain available. By default, Podman 5.0+ times out the socket after 5 seconds of inactivity, which breaks container access to the host podman daemon.

**Setup:**

```bash
# Run the setup script to configure systemd overrides
./podman-setup
```

This configures the socket to remain available indefinitely. You only need to do this once.

**Note:** Podman 4.x and earlier keep the socket alive automatically, so this step is not necessary for older versions.

## Quick Start

To try zed in a container, download the launcher and scripts:

```bash
cd $HOME/bin
curl -O https://raw.githubusercontent.com/epics-containers/zed/refs/heads/main/zed

# run zed with:
zed
```