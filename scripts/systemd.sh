#!/bin/bash
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

systemctl enable --now nscd libvirtd ratbagd sshd.socket docker NetworkManager NetworkManager-wait-online systemd-timesyncd tor
systemctl --user enable --now syncthing kbdd
systemctl link "$SD/../home_cp/units/veracrypt-unmount.service"
systemctl enable veracrypt-unmount
