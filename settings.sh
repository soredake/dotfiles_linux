#!/bin/bash
chsh -s /usr/bin/fish
systemctl enable --now amdgpu
systemctl --user enable --now backup.timer

# lutris: use system libretro cores
# https://github.com/lutris/lutris/issues/2444
ln -sv "$HOME/.config/retroarch/cores" "$HOME/.local/share/lutris/runners/retroarch/cores"

# SBC HD
# https://github.com/EHfive/pulseaudio-modules-bt/issues/63#issuecomment-613432583
sudo sed -i 's|load-module module-bluetooth-discover|load-module module-bluetooth-discover a2dp_config="sbc_min_bp=47 sbc_max_bp=47 sbc_freq=44k sbc_cmode=dual sbc_alloc=loudness sbc_sbands=8 sbc_blen=16"|g' /etc/pulse/default.pa

# one more automation TODO: https://bugs.launchpad.net/ubuntu/+source/software-properties/+bug/1882500
sudo sed -i 's|//Unattended-Upgrade::Remove-Unused-Dependencies.*|Unattended-Upgrade::Remove-Unused-Dependencies "true";|g' /etc/apt/apt.conf.d/50unattended-upgrades