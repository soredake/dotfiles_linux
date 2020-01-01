#!/bin/bash
# https://github.com/mpv-player/mpv/wiki/User-Scripts
# https://github.com/TheAMM/mpv_crop_script
# https://github.com/TheAMM/mpv_thumbnail_script
# https://github.com/haasn/gentoo-conf/blob/xor/home/nand/.mpv/input-image.conf

g="https://raw.githubusercontent.com"
cd "$XDG_CONFIG_HOME/mpv/scripts" || exit 1
curl -O $g/ElegantMonkey/mpv-webm/master/build/webm.lua
curl -O https://github.com/TheAMM/mpv_crop_script/releases/download/0.5.0/mpv_crop_script.lua
ln -svf /usr/share/mpv/scripts/{{pause-when-minimize,autodeint,autocrop}.lua,mpris.so} .
