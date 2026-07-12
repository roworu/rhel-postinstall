#!/usr/bin/env bash
set -euo pipefail

sudo subscription-manager repos \
    --enable codeready-builder-for-rhel-10-$(arch)-rpms
sudo dnf -y install \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm
sudo dnf config-manager --add-repo \
    https://developer.download.nvidia.com/compute/cuda/repos/rhel10/x86_64/cuda-rhel10.repo

sudo dnf install nvidia-open

# TODO: dynamically determine arch
# TODO: dynamically determine distro version (rhel 8,9,10)