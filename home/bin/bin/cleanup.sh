#!/bin/bash

HOMEDIR="/home/bausch"
XDD="$HOMEDIR/.local/share"
rmlist=(
  #/var/lib/systemd/coredump/*
  /var/{cache,log}/*
  /var/log/journal
  "$HOMEDIR"/.pulse-cookie
  #$HOMEDIR/.*sh_history
  "$HOMEDIR"/.cache/{ranger,thumbnails,gstreamer-1.0,less,wine,youtube-dl,qt_compose_cache*}
  #"$HOMEDIR/.dbus"
  "$XDD/{xorg,RecentDocuments}"
  "$XDD/*.xbel*"
)
/bin/rm -r "${rmlist[@]}"
/usr/bin/ccache -C
/usr/bin/find "$HOMEDIR"/.{config,cache} ! -path "*/syncthing/*" ! -path "*/zplug/*" -empty -delete
/usr/bin/find "$XDD" ! -path "*/Steam/*" ! -path "*/systemd/*" ! -path "*/lutris/*" -empty -delete
/usr/bin/fd -t f -H -I "^\.[0-9][0-9][0-9][0-9]?[0-9]?$" "$HOMEDIR" -x "rm" {}
/usr/bin/fd -t d -H ".unwanted" /media/disk0/torrents -x rm -r {}
/usr/bin/fd -t f -H -I -e .tar.xz --search-path /home/bausch/git/PKGBUILDS -x "rm" {}
/usr/bin/journalctl --vacuum-time=1d
/usr/bin/youtube-dl --rm-cache-dir
/usr/bin/psd c
/usr/bin/localepurge
/usr/bin/yay -Sc
/usr/bin/flatpak uninstall --all
/usr/bin/flatpak --user uninstall --unused
/usr/bin/yarn autoclean
/usr/bin/yarn cache clean
#https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Removing_unused_packages_(orphans)
/usr/bin/yay -Rns $(/usr/bin/yay -Qtdq)
