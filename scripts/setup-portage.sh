#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

sudo rm -rf /var/lib/portage/world /etc/portage/*
sudo stow -v 2 -d "$SD"/../etc -t /etc portage
sudo stow -v 2 -d "$SD"/../root -t / world
sudo ln -sfv /usr/portage/profiles/default/linux/amd64/17.0/desktop/systemd /etc/portage/make.profile
