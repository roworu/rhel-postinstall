#!/usr/bin/env bash
set -euo pipefail

re='^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])(\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9]))*$'

while true; do
    read -rp "New hostname: " hostname

    if [[ "$hostname" =~ $re ]] && (( ${#hostname} <= 253 )); then
        break
    fi

    echo "Invalid hostname: use only letters, digits, '-' and '.' (e.g. my-server-01)."
done

hostname="${hostname,,}"

if [[ -f /etc/hostname ]]; then
    sudo cp /etc/hostname /etc/hostname.bak
    echo "Backed up /etc/hostname to /etc/hostname.bak"
fi

echo "$hostname" | sudo tee /etc/hostname > /dev/null

echo "Hostname set to: $hostname"
echo
echo "Reboot the machine for it to take effect"
