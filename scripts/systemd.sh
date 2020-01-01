#!/bin/bash
# speed
# https://linux-faq.ru/page/uskorenie-processa-zagruzki-distributiva-linux
# https://forum.manjaro.org/t/removing-lvm-support-during-boot-time/56850
# https://bbs.archlinux.org/viewtopic.php?id=233016
systemctl mask --now lvm2-monitor fwupd
systemctl --user mask xdg-user-dirs-update

systemctl enable --now disable-c6 NetworkManager-wait-online reflector.timer fstrim.timer linux-modules-cleanup bluetooth thrash-protect radeon-profile-daemon dnscrypt-proxy nscd sshd NetworkManager gamemoded systemd-timesyncd tor cdemu-daemon
systemctl --user enable --now syncthing mpd.socket