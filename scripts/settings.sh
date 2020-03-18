#!/bin/bash
# shellcheck disable=2016,2162

systemctl enable --now snapd.socket fstrim.timer linux-modules-cleanup bluetooth dnscrypt-proxy nscd NetworkManager tor sddm
systemctl --user enable --now syncthing mpd.socket pulseaudio.socket

# the env vars
# https://github.com/ayekat/dotfiles/issues/7
# https://github.com/grawity/dotfiles/blob/master/.dotfiles.notes
# https://github.com/grawity/dotfiles/blob/master/.environ.notes
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
# TODO: https://github.com/ValveSoftware/steam-runtime/issues/214
# TODO: https://github.com/ValveSoftware/steam-runtime/issues/217
# https://steamcommunity.com/app/221410/discussions/0/1638675549018366706/
# https://wiki.archlinux.org/index.php/AMDGPU#ACO_compiler
# https://wiki.archlinux.org/index.php/Firefox#KDE/GNOME_integration
homectl update mannyf --setenv=GTK_USE_PORTAL=1 --setenv=RADV_PERFTEST=aco
# TODO: https://github.com/ValveSoftware/steam-runtime/issues/243
#--setenv=PRESSURE_VESSEL_SHARE_HOME=0 --setenv=STEAM_RUNTIME_CONTAINER_ALWAYS=1