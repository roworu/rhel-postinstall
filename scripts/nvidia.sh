#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_utils.sh"

detect_system

sudo subscription-manager repos \
    --enable "codeready-builder-for-rhel-${RHEL_VERSION}-${ARCH}-rpms"
sudo dnf -y install \
    "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${RHEL_VERSION}.noarch.rpm"
sudo dnf config-manager --add-repo \
    "https://developer.download.nvidia.com/compute/cuda/repos/rhel${RHEL_VERSION}/${ARCH}/cuda-rhel${RHEL_VERSION}.repo"

sudo dnf install nvidia-open
