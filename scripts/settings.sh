#!/bin/bash
systemctl mask lvm2-monitor.service
systemctl enable --now snapd.socket fstrim.timer linux-modules-cleanup bluetooth dnscrypt-proxy nscd NetworkManager tor sddm systemd-homed earlyoom
systemctl --user enable --now syncthing mpd.socket pulseaudio backup.timer
# TODO: https://github.com/ValveSoftware/steam-runtime/issues/214
# TODO: https://github.com/ValveSoftware/steam-runtime/issues/217
homectl update mannyf --setenv=GTK_USE_PORTAL=1 --setenv=RADV_PERFTEST=aco
# TODO: https://github.com/ValveSoftware/steam-runtime/issues/243
#--setenv=PRESSURE_VESSEL_SHARE_HOME=0 --setenv=STEAM_RUNTIME_CONTAINER_ALWAYS=1

# lutris: use system libretro cores
# https://github.com/lutris/lutris/issues/2444
ln -sfv "$HOME/.config/retroarch/cores" "$HOME/.local/share/lutris/runners/retroarch/cores"
# helper for "open with" firefox addon
a="$HOME/.local/share/open_with_addon/open_with_linux.py"
curl https://github.com/darktrojan/openwith/raw/master/webextension/native/open_with_linux.py --create-dirs -sLo "$a"
python "$a" install