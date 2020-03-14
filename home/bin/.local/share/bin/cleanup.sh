#!/bin/bash

HOMEDIR="/home/mannyf"
XDD="$HOMEDIR/.local/share"
rmlist=(

)
/bin/rm -r "${rmlist[@]}"
/usr/bin/fd -t d -H ".unwanted" /media/disk0/torrents -x rm -r {}
/usr/bin/fd -t f -H -I -e .tar.zst --search-path /home/mannyf/git/PKGBUILDS -x "rm" {}
/usr/bin/yay -Sc
/usr/bin/yay -c
# psd c
#/usr/bin/yay -Scc
ancient-packages
/usr/bin/flatpak --user uninstall --unused
flatpak --user repair