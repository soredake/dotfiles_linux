#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

yay -Syu --devel --timeupdate
yay -c
sudo eclean -d -n distfiles
sudo eclean --deep -d packages
apm update
flatpak --user update
flatpak --user uninstall --unused
yarn global upgrade
yarn autoclean
yarn cache clean
fwupdmgr refresh
fwupdmgr update
