#!/bin/bash
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

systemctl enable --now sshd.socket dnscrypt-proxy docker NetworkManager NetworkManager-wait-online systemd-timesyncd tor
systemctl --user enable --now syncthing rtorrent kbdd gpg-agent-ssh.socket
systemctl link "$SD/../home_cp/units/veracrypt-unmount.service"
systemctl enable veracrypt-unmount
