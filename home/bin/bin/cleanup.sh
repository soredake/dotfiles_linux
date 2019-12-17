#!/bin/bash

HOMEDIR="/home/bausch"
XDD="$HOMEDIR/.local/share"
rmlist=(
  "$HOMEDIR"/.cache/{ranger,thumbnails,wine}
  # https://wiki.archlinux.org/index.php/default_applications#Default_mimeapps.list_files
  #"$XDG_DATA_HOME/applications/"{mimeapps.list,mimeinfo.cache} "$XDG_CONFIG_HOME/mimeapps.list" "$XDG_DATA_HOME/mime" "$XDG_DATA_HOME/icons"
  # /var/lib/sddm/.cache/
)
/bin/rm -r "${rmlist[@]}"
#/usr/bin/find "$HOMEDIR"/.{config,cache} ! -path "*/syncthing/*" ! -path "*/zplug/*" -empty -delete
#/usr/bin/find "$XDD" ! -path "*/Steam/*" ! -path "*/systemd/*" ! -path "*/lutris/*" -empty -delete
#/usr/bin/fd -t f -H -I "^\.[0-9][0-9][0-9][0-9]?[0-9]?$" "$HOMEDIR" -x "rm" {}
/usr/bin/fd -t d -H ".unwanted" /media/disk0/torrents -x rm -r {}
/usr/bin/fd -t f -H ".\!qB" /media/disk0/torrents -x rm -r {}
/usr/bin/fd -t f -H -I -e .tar.zst --search-path /home/bausch/git/PKGBUILDS -x "rm" {}
# https://wiki.manjaro.org/System_Maintenance#Home_Cache
# https://bugs.kde.org/show_bug.cgi?id=79943
# https://bugs.launchpad.net/ubuntu/+source/kio-extras/+bug/1782613
find ~/.cache/thumbnails -type f -atime +100 -delete
#/usr/lib/systemd/system/shadow.service
sudo /usr/bin/pwck
sudo /usr/bin/grpck
/usr/bin/localepurge
/usr/bin/yay -Sc
/usr/bin/yay -c
# psd c
#/usr/bin/yay -Scc
ancient-packages
#/usr/bin/flatpak uninstall --all
/usr/bin/flatpak --user uninstall --unused
#/usr/bin/yarn autoclean
#/usr/bin/yarn cache clean
# https://wiki.archlinux.org/index.php/System_maintenance#Check_for_orphans_and_dropped_packages
#https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Removing_unused_packages_(orphans)
#/usr/bin/yay -Rns $(/usr/bin/yay -Qtdq)
