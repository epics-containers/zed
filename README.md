# ec-phoebus
A container image for the z IDE
```

## Prerequisites

### NVIDIA Container Toolkit (for GPU acceleration)

If you have an NVIDIA GPU, you must install the NVIDIA Container Toolkit to enable GPU access inside the container. Without it, Zed will render with software rendering (llvmpipe) which is too slow and may display a black screen.

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

## Quick Start

To try zed in a container, download the launcher and run it:

```bash
cd $HOME/bin
curl -O https://raw.githubusercontent.com/epics-containers/zed/refs/heads/main/zed
chmod +x zed

# run with:
zed
```