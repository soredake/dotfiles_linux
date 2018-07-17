#!/bin/bash

[[ ! -d "$HOME/Documents/progs" ]] && mkdir "$HOME/Documents/progs"
cd "$HOME/Documents/progs" || exit 1
# early rm
rm -rf vk ramme itch
# vk
proxychains wget https://desktop.userapi.com/linux64/master/vk.zip
unzip vk.zip -d vk
# ramme
wget https://github.com/terkelg/ramme/releases/download/v3.2.5/Ramme-3.2.5.tar.gz -O Ramme.tar.gz
tar zxvf Ramme.tar.gz
mkdir ramme
mv Ramme/* ramme
# itch
wget https://nuts.itch.zone/download -O itch.tar.xz
tar --xz -xvf itch.tar.xz
mkdir itch
mv itch-*/* itch
# igdm
wget https://github.com/ifedapoolarewaju/igdm/releases/download/v2.5.1/IGdm-2.5.1-x86_64.AppImage -O IGdm.AppImage
chmod +x IGdm.AppImage
# cleanup
rm -rf vk.zip Ramme* itch.tar.xz itch-*
