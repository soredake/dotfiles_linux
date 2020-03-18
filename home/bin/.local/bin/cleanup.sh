#!/bin/bash
HOMEDIR="/home/mannyf"
XDD="$HOMEDIR/.local/share"
#rmlist=()
#/bin/rm -r "${rmlist[@]}"
#/usr/bin/yay -Scc
/usr/bin/fd -t d -H ".unwanted" /media/disk0/torrents -x rm -r {}
/usr/bin/fd -t f -H -I -e .tar.zst --search-path /home/mannyf/git/PKGBUILDS -x "rm" {}
/usr/bin/flatpak --user uninstall --unused
/usr/bin/yay -Sc
/usr/bin/yay -c
/usr/bin/ancient-packages
/usr/bin/flatpak --user repair