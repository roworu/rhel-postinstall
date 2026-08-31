#!/usr/bin/env bash
set -euo pipefail

while true; do
    read -rp "Parallel downloads (1-20, default 5): " parallel
    parallel="${parallel:-5}"

    if [[ "$parallel" =~ ^([1-9]|1[0-9]|20)$ ]]; then
        break
    fi

    echo "Value must be between 1 and 20."
done

while true; do
    read -rp "Set defaultyes? (Yes/No, default Yes): " defaultyes
    defaultyes="${defaultyes:-Yes}"

    case "${defaultyes,,}" in
        yes|y) defaultyes="yes"; break ;;
        no|n)  defaultyes="no"; break ;;
        *)     echo "Answer Yes or No." ;;
    esac
done

if [[ -f /etc/dnf/dnf.conf ]]; then
    sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
    echo "Backed up /etc/dnf/dnf.conf to /etc/dnf/dnf.conf.bak"
fi

sudo sed -i \
    -e '/^[[:space:]]*max_parallel_downloads[[:space:]]*=/d' \
    -e '/^[[:space:]]*defaultyes[[:space:]]*=/d' \
    /etc/dnf/dnf.conf

sudo sed -i \
    '/^\[main\]/a max_parallel_downloads='"$parallel"'\ndefaultyes='"$defaultyes" \
    /etc/dnf/dnf.conf

echo "Updated /etc/dnf/dnf.conf:"
grep -E '^(max_parallel_downloads|defaultyes)=' /etc/dnf/dnf.conf