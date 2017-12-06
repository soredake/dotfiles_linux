#!/bin/bash
# https://github.com/mpv-player/mpv/wiki/User-Scripts
# https://gist.github.com/7919afd765e308fa91cbe19a64631d0f
# https://github.com/haasn/gentoo-conf/blob/xor/home/nand/.mpv/input-image.conf

g="https://raw.githubusercontent.com"
cd "$XDG_CONFIG_HOME/mpv/scripts" || exit 1
#sed -e "s/l en/l ru/g" -e 's/("s",/("g",/g' <(curl $g/directorscut82/find_subtitles/master/find_subtitles.lua) >find_subtitles.lua
wget $g/Argon-/mpv-stats/master/stats.lua $g/haasn/gentoo-conf/xor/home/nand/.mpv/scripts/avail/{skipchapters,image}.lua
ln -svf /usr/share/mpv/lua/{autodeint,autocrop}.lua .
#$g/mpv-player/mpv/master/TOOLS/lua/{autocrop,autodeint}.lua
