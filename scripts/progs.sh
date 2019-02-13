#!/bin/bash

[[ ! -d "$HOME/Documents/progs" ]] && mkdir "$HOME/Documents/progs"
cd "$HOME/Documents/progs" || exit 1
# itch
wget https://nuts.itch.zone/download -O itch
chmod +x itch
# igdm
wget https://github.com/ifedapoolarewaju/igdm/releases/download/v2.6.1/IGdm-2.6.1-x86_64.AppImage -O IGdm.AppImage
chmod +x IGdm.AppImage
# cleanup
rm -rf vk.zip Ramme* itch.tar.xz itch-*

if [[ ! -d "$HOME/git/i3blocks-contrib" ]]; then
  cd $HOME/git || exit 1
  git clone https://github.com/vivien/i3blocks-contrib
else
  cd "$HOME/git/i3blocks-contrib" || exit 1
  git pull
fi
