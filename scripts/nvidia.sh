#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_utils.sh"

detect_system

sudo subscription-manager repos \
    --enable "codeready-builder-for-rhel-${RHEL_VERSION}-${ARCH}-rpms"
sudo dnf -y install \
    "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${RHEL_VERSION}.noarch.rpm"
sudo dnf -y install \
--nogpgcheck "https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-${RHEL_VERSION}.noarch.rpm" "https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-${RHEL_VERSION}.noarch.rpm"
sudo subscription-manager repos --enable "codeready-builder-for-rhel-${RHEL_VERSION}-${ARCH}-rpms"

sudo dnf config-manager --add-repo \
    "https://developer.download.nvidia.com/compute/cuda/repos/rhel${RHEL_VERSION}/${ARCH}/cuda-rhel${RHEL_VERSION}.repo"

sudo dnf install nvidia-open

# TODO: add module to wait for kernel modules to build.
# now if user will try to reboot until moudles built - it will crash

echo "Nvidia installation complete."
