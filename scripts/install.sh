#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/roworu/rhel-postinstall.git"
TASK="${1:?usage: install.sh <task>  (nvidia | plasma | remove_gnome | dnf | hostname)}"

case "$TASK" in
    nvidia|plasma|remove_gnome|dnf|hostname) ;;
    *) echo "Unknown task: $TASK (expected: nvidia | plasma | remove_gnome | dnf | hostname)" >&2; exit 1 ;;
esac

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

git clone --depth 1 "$REPO" "$tmp/repo"
bash "$tmp/repo/scripts/${TASK}.sh"
