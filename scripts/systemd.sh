#!/bin/bash
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1


systemctl enable zfs.target
systemctl enable zfs-import-cache
systemctl enable zfs-mount
systemctl enable zfs-import.target


systemctl enable --now radeon-profile-daemon anbox-container-manager nscd libvirtd ratbagd sshd.socket docker NetworkManager NetworkManager-wait-online systemd-timesyncd tor
systemctl --user enable --now syncthing kbdd anbox-session-manager
systemctl link "$SD/../home_cp/units/veracrypt-unmount.service"
systemctl enable veracrypt-unmount
