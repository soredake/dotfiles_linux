#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

# remove if non-link
[[ ! -L /etc/makepkg.conf ]] && sudo rm /etc/makepkg.conf
[[ ! -L /etc/mkinitcpio.conf ]] && sudo rm /etc/mkinitcpio.conf
[[ ! -L /etc/nanorc ]] && sudo rm /etc/nanorc
[[ ! -L /etc/pacman.conf ]] && sudo rm /etc/pacman.conf
[[ ! -L /etc/vconsole.conf ]] && sudo rm /etc/vconsole.conf
[[ ! -L /etc/locale.gen ]] && sudo rm /etc/locale.gen
[[ ! -L /etc/locale.nopurge ]] && sudo rm /etc/locale.nopurge
[[ ! -L /etc/tor/torrc ]] && sudo rm /etc/tor/torrc
[[ ! -L /etc/fstab ]] && sudo rm /etc/fstab
[[ ! -L /etc/default/grub ]] && sudo rm /etc/default/grub

for d in $(echo */);
do
  sudo stow $1 -v 2 -d "$SD" -t /etc "$d"
done
