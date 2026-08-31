
detect_system() {
    # shellcheck disable=SC1091
    . /etc/os-release
    if [[ "${ID:-}" != "rhel" ]]; then
        echo "Error: RHEL is required (detected: ${ID:-unknown})." >&2
        return 1
    fi
    RHEL_VERSION="${VERSION_ID%%.*}"
    ARCH="$(uname -m)"
}
