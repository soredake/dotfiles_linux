#!/bin/bash
# speed
# https://linux-faq.ru/page/uskorenie-processa-zagruzki-distributiva-linux
# https://forum.manjaro.org/t/removing-lvm-support-during-boot-time/56850
# https://bbs.archlinux.org/viewtopic.php?id=233016
systemctl mask --now lvm2-monitor 
#fwupd
systemctl --user mask xdg-user-dirs-update

systemctl enable --now snapd.socket reflector.timer fstrim.timer linux-modules-cleanup bluetooth thrash-protect dnscrypt-proxy nscd NetworkManager systemd-timesyncd tor cdemu-daemon sddm
systemctl --user enable --now syncthing mpd.socket gamemoded