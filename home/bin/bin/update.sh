#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo emerge --sync || exit 1
sudo emerge --changed-use --newuse -uDU @world || exit 1
#sudo emerge --changed-use --newuse --ignore-built-slot-operator-deps=y --rebuild-if-new-slot=y --rebuild-if-new-rev=y --rebuild-if-new-ver=y --rebuild-if-unbuilt=y -uDU @world
sudo emerge --usepkg=n @preserved-rebuild || exit 1
sudo smart-live-rebuild -f '!www-client/torbrowser' -f '!app-emulation/wine-vanilla' -f '!app-emulation/wine-any' -f '!games-emulation/retroarch' -f '!x11-misc/xsel' -- --usepkg=n
sudo emerge -v --depclean || exit 1
#sudo env-update
#sudo haskell-updater -c -u -- --usepkg=n
#sudo perl-cleaner --all -- --usepkg=n
glsa-check -l affected
sudo eclean -d -n distfiles
sudo eclean --deep -d packages
