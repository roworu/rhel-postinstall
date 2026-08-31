#!/usr/bin/env bash
set -euo pipefail

while true; do
    read -rp "Parallel downloads (1-10, default 5): " parallel
    parallel="${parallel:-5}"
    if [[ "$parallel" =~ ^[1-9]$|^10$ ]]; then
        break
    fi
    echo "Value must be between 1 and 10."
done

while true; do
    read -rp "Set defaultyes? (Yes/No, default No): " defaultyes
    defaultyes="${defaultyes:-No}"
    case "${defaultyes,,}" in
        yes|y) defaultyes="yes"; break ;;
        no|n)  defaultyes="no";  break ;;
        *)     echo "Answer Yes or No." ;;
    esac
done


if [ -f /etc/dnf/dnf.conf ]; then
    sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
    echo "Backed up /etc/dnf/dnf.conf to /etc/dnf/dnf.conf.bak"
fi

sudo dnf config-manager --setopt main.max_parallel_downloads="${parallel}" \
    --setopt main.defaultyes="${defaultyes}" --save
echo "Updated /etc/dnf/dnf.conf: max_parallel_downloads=${parallel}, defaultyes=${defaultyes}"
