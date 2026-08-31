#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_utils.sh"

detect_system

sudo mkdir -p /etc/systemd/system-generators
sudo touch /etc/systemd/system-generators/systemd-rc-local-generator

sudo subscription-manager repos \
    --enable "codeready-builder-for-rhel-${RHEL_VERSION}-${ARCH}-rpms"
sudo dnf -y install \
    "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${RHEL_VERSION}.noarch.rpm"

echo "==> Installing KDE Plasma..."
sudo dnf -y install \
    plasma-desktop \
    plasma-login-manager \
    plasma-discover \
    konsole \
    dolphin \
    gwenview \
    kwrite \
    kde-gtk-config

sudo systemctl enable plasmalogin.service
sudo systemctl set-default graphical.target

echo
echo "===================================================="
echo "Plasma installation complete."
echo
echo "Reboot the machine:"
echo
echo "    sudo reboot"
echo "===================================================="

# TODO: also set rhel wallpapers?
