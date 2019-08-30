#!/bin/bash
# https://github.com/mpv-player/mpv/wiki/User-Scripts
# https://github.com/haasn/gentoo-conf/blob/xor/home/nand/.mpv/input-image.conf

g="https://raw.githubusercontent.com"
cd "$XDG_CONFIG_HOME/mpv/scripts" || exit 1
# skipchapters,
wget $g/haasn/gentoo-conf/xor/home/nand/.mpv/scripts/avail/image.lua
wget https://raw.githubusercontent.com/ElegantMonkey/mpv-webm/master/build/webm.lua
ln -svf /usr/share/mpv/lua/{autodeint,autocrop}.lua .
