#!/bin/bash

[[ ! -d "$HOME/Documents/progs" ]] && mkdir "$HOME/Documents/progs"
cd "$HOME/Documents/progs" || exit 1
# early rm
rm -rf vk ramme
# vk
proxychains wget https://desktop.userapi.com/linux64/master/vk.zip
unzip vk.zip -d vk
# ramme
wget https://github.com/terkelg/ramme/releases/download/v3.2.5/Ramme-3.2.5.tar.gz -O Ramme.tar.gz
tar zxvf Ramme.tar.gz
mkdir ramme
mv Ramme-*/* ramme
# itch
wget https://nuts.itch.zone/download -O itch
chmod +x IGdm.AppImage
# igdm
wget https://github.com/ifedapoolarewaju/igdm/releases/download/v2.5.4/IGdm-2.5.4-x86_64.AppImage -O IGdm.AppImage
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
