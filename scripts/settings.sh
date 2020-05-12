#!/bin/bash
chsh -s /usr/bin/fish
systemctl enable --now amdgpu
systemctl --user enable --now syncthing mpd.socket backup.timer

# lutris: use system libretro cores
# https://github.com/lutris/lutris/issues/2444
ln -sfv "$HOME/.config/retroarch/cores" "$HOME/.local/share/lutris/runners/retroarch/cores"
# helper for "open with" firefox addon
a="$HOME/.local/share/open_with_addon/open_with_linux.py"
curl https://github.com/darktrojan/openwith/raw/master/webextension/native/open_with_linux.py --create-dirs -sLo "$a"
python "$a" install

# SBC HD
# https://github.com/EHfive/pulseaudio-modules-bt/issues/63#issuecomment-613432583
sudo sed -i 's|load-module module-bluetooth-discover|load-module module-bluetooth-discover a2dp_config="sbc_min_bp=47 sbc_max_bp=47 sbc_freq=44k sbc_cmode=dual sbc_alloc=loudness sbc_sbands=8 sbc_blen=16"|g' /etc/pulse/default.pa