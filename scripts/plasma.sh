#!/usr/bin/env bash
set -euo pipefail

sudo mkdir -p /etc/systemd/system-generators
sudo touch /etc/systemd/system-generators/systemd-rc-local-generator

sudo subscription-manager repos \
    --enable "codeready-builder-for-rhel-10-$(arch)-rpms"
sudo dnf -y install \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

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
