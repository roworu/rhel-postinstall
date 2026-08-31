# rhel-postinstall

a set of postinstall scripts i use for my rhel installations.

**please, review each script before using!**

you should use these for minimal installation.
if you already have `workstation` edition installed - you could try to remove gnome related stuff using `remove_gnome.sh` script, and then proceed with plasma installation.

### nvidia

1) enables `codeready-builder-for-rhel`, `epel` and `nvidia` repositories
2) installs `nvidia-open` package

```bash
curl -o- https://raw.githubusercontent.com/roworu/rhel-postinstall/main/scripts/nvidia.sh | bash
```

### kde plasma

1) enables `codeready-builder-for-rhel` and `epel` repositories
2) installs minimal kde set of apps
3) enables `plasmalogin` service for graphical login
4) sets `graphical.target` for systemd

```bash
curl -o- https://raw.githubusercontent.com/roworu/rhel-postinstall/main/scripts/plasma.sh | bash
```

### dnf

1) asks for number of parallel downloads (1-10) and if to set `defaultyes`
2) backs up existing `/etc/dnf/dnf.conf` to `/etc/dnf/dnf.conf.bak`
3) updates `max_parallel_downloads` and `defaultyes` in `/etc/dnf/dnf.conf`

the script is interactive, so download it first:

```bash
curl -o dnf.sh https://raw.githubusercontent.com/roworu/rhel-postinstall/main/scripts/dnf.sh
bash dnf.sh
```
