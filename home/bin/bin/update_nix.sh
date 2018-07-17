#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# https://nixos.wiki/wiki/Garbage_Collection

# https://github.com/NixOS/nixpkgs/issues/42831#issuecomment-401594856
sudo nix-channel --update || exit 1
sudo nixos-rebuild switch || exit 1
sudo nixos-rebuild boot # нужно ли это? https://nixos.wiki/wiki/Bootloader#How_do_I_remove_older_generations_from_the_bootloader.3F
# or command that combines this two `sudo nixos-rebuild switch --upgrade`
sudo nix-env --delete-generations old
sudo nix-store --gc
sudo nix-collect-garbage -d # https://github.com/NixOS/nixpkgs/issues/37864#issuecomment-378373007
sudo nix-store --optimise
# https://github.com/NixOS/nixpkgs/issues/39730#issuecomment-385608799
sudo nix verify --all --no-trust
apm update
flatpak --user update
flatpak --user uninstall --unused
yarn global upgrade
yarn autoclean
yarn cache clean
fwupdmgr refresh
fwupdmgr update
