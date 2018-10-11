#!/bin/bash

# check sudo grep "root=ZFS=/ROOT/gentoo" /boot/grub/grub.cfg
sudo sed -i "s|root=ZFS=/ROOT/gentoo|root=ZFS=rpool/ROOT/gentoo|g" /boot/grub/grub.cfg
