#!/bin/bash
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1


systemctl enable zfs.target
systemctl enable zfs-import-cache
systemctl enable zfs-mount
systemctl enable zfs-import.target


# speed
# https://linux-faq.ru/page/uskorenie-processa-zagruzki-distributiva-linux
# https://forum.manjaro.org/t/removing-lvm-support-during-boot-time/56850
# https://bbs.archlinux.org/viewtopic.php?id=233016
systemctl mask --now lvm2-monitor fwupd

systemctl enable --now ratbagd NetworkManager-wait-online
systemctl enable --now fstrim.timer bluetooth thrash-protect radeon-profile-daemon dnscrypt-proxy nscd sshd NetworkManager gamemoded systemd-timesyncd tor
systemctl --user enable --now kbdd syncthing mpd.socket
#systemctl link "$SD/../home_cp/units/veracrypt-unmount.service"
#systemctl enable veracrypt-unmount
