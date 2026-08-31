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

sudo dnf -y install \
    plasma-desktop \
    plasma-login-manager \
    plasma-discover \
    konsole \
    dolphin \
    gwenview \
    kwrite \
    kde-gtk-config \
    kinfocenter \
    kscreen

sudo systemctl enable plasmalogin.service
sudo systemctl set-default graphical.target

sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# FIXME
# kwriteconfig6 --file plasma-org.kde.plasma.desktop-appletsrc --group General --key Image "file:///usr/share/wallpapers/RHEL10_Isometric/"
kwriteconfig6 --file kdeglobals --group KDE --key AutomaticLookAndFeel true
kwriteconfig6 --file kdeglobals --group KDE --key LookAndFeelPackage "org.kde.breeze.desktop"

kwriteconfig6 --file discoverrc --group FlatpakSources --key Sources "flathub"
kwriteconfig6 --file discoverrc --group ResourcesModel --key currentApplicationBackend "flatpak-backend"

echo "Plasma installation complete."
