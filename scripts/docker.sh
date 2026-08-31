#!/usr/bin/env bash
set -euo pipefail

# 1) if podman installed, ask to keep it
keep_podman="yes"
if rpm -q podman > /dev/null 2>&1; then
    while true; do
        read -rp "podman is installed. Keep it? (Yes/No, default Yes): " answer
        answer="${answer:-Yes}"
        case "${answer,,}" in
            yes|y) keep_podman="yes"; break ;;
            no|n)  keep_podman="no"; break ;;
            *)     echo "Answer Yes or No." ;;
        esac
    done
fi

# 2) remove old docker packages (and podman if not kept)
remove_pkgs=(
    docker
    docker-client
    docker-client-latest
    docker-common
    docker-latest
    docker-latest-logrotate
    docker-logrotate
    docker-engine
)
if [[ "$keep_podman" == "no" ]]; then
    remove_pkgs+=(podman podman-docker runc)
else
    # podman-docker provides `docker` alias that will conflict docker-ce
    remove_pkgs+=(podman-docker)
fi

sudo dnf remove "${remove_pkgs[@]}"

# 3) add repo
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

# 4) install docker
sudo dnf -y install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# 5) enable service
sudo systemctl enable --now docker

# 6) allow current user to run docker without sudo
user="${SUDO_USER:-${USER:-$(id -un)}}"
if [[ "$user" != "root" ]]; then
    while true; do
        read -rp "Add '$user' to docker group (run docker without sudo)? (Yes/No, default Yes): " answer
        answer="${answer:-Yes}"
        case "${answer,,}" in
            yes|y)
                sudo usermod -aG docker "$user"
                echo "Done. Log out and back in  to take effect."
                break
                ;;
            no|n)  break ;;
            *)     echo "Answer Yes or No." ;;
        esac
    done
fi


echo "Docker installation complete."

