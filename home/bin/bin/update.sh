#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo emerge --sync || exit 1
sudo emerge --changed-use --newuse -uDU @world || exit 1
sudo emerge --usepkg=n @preserved-rebuild || exit 1
sudo smart-live-rebuild -- --usepkg=n || exit 1
sudo emerge -v --depclean || exit 1
#sudo env-update
#sudo python-updater
#sudo haskell-updater -c -u
#sudo perl-cleaner --all
glsa-check -l affected
sudo eclean -d -n distfiles
sudo eclean --deep -d packages
