#!/bin/bash
# shellcheck disable=2016,2162

# https://wiki.archlinux.org/index.php/Bluetooth#Auto_power-on_after_boot
sudo sed -i "s|#AutoEnable=false|AutoEnable=true|g" /etc/bluetooth/main.conf

# speed
# https://linux-faq.ru/page/uskorenie-processa-zagruzki-distributiva-linux
# https://forum.manjaro.org/t/removing-lvm-support-during-boot-time/56850
# https://bbs.archlinux.org/viewtopic.php?id=233016
systemctl mask --now lvm2-monitor

systemctl enable --now snapd.socket fstrim.timer linux-modules-cleanup bluetooth dnscrypt-proxy nscd NetworkManager tor sddm
systemctl --user enable --now syncthing mpd.socket pulseaudio.socket