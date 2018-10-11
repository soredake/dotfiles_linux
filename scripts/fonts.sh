#!/bin/bash
# http://kev009.com/wp/2009/12/getting-beautiful-fonts-in-gentoo-linux/
sudo eselect fontconfig disable {1..101}
#sudo eselect fontconfig enable 10-hinting-slight.conf 11-lcdfilter-light.conf 52-infinality.conf 50-user.conf 10-hinting-slight.conf 10-sub-pixel-rgb.conf 20-unhint-small-dejavu-sans-mono.conf 20-unhint-small-dejavu-sans.conf 20-unhint-small-dejavu-serif.conf 25-unhint-nonlatin.conf 57-dejavu-sans-mono.conf 57-dejavu-sans.conf 57-dejavu-serif.conf
sudo eselect fontconfig enable 52-infinality.conf
sudo eselect infinality set ultimate-free
sudo eselect lcdfilter set ultimate