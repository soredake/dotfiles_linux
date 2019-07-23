#!/bin/bash
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1


systemctl enable zfs.target
systemctl enable zfs-import-cache
systemctl enable zfs-mount
systemctl enable zfs-import.target

systemctl enable --now libvirtd ratbagd docker NetworkManager-wait-online
systemctl enable --now bluetooth thrash-protect snapd.socket bluetooth.service radeon-profile-daemon anbox-container-manager stubby nscd sshd.socket NetworkManager syncthing gamemoded systemd-timesyncd tor
systemctl --user enable --now kbdd anbox-session-manager
systemctl link "$SD/../home_cp/units/veracrypt-unmount.service"
systemctl enable veracrypt-unmount
