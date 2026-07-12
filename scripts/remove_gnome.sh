#!/usr/bin/env bash
set -euo pipefail

sudo systemctl disable gdm

sudo dnf remove \
    gnome-shell \
    gnome-bluetooth \
    gnome-bluetooth-libs \
    gnome-calculator \
    gnome-text-editor \
    snapshot \
    gnome-color-manager \
    gnome-disk-utility \
    gnome-system-monitor \
    loupe \
    papers-previewer \
    ptyxis \
    baobab \
    gnome-font-viewer \
    gnome-online-accounts \
    gnome-user-docs \
    gnome-remote-desktop \
    yelp-tools \
    yelp-xsl

sudo dnf autoremove

rm -rf ~/.config/gtk-*
rm -rf ~/.config/dconf
rm -rf ~/.cache/*
rm -rf ~/.local/share/gnome-shell
rm -rf ~/.local/share/nautilus
rm -rf ~/.local/state/*
