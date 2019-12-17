#!/bin/bash
# shellcheck disable=2016,2162

# limit ccache size
ccache -M 2G

# generate locales
sudo locale-gen

# https://wiki.archlinux.org/index.php/Limits.conf
# https://wiki.archlinux.org/index.php/Core_dump
sudo tee -a /etc/security/limits.conf >/dev/null <<END
# https://wiki.archlinux.org/index.php/Limits.conf#core
* soft    core       0           # Prevent corefiles from being generated by default.
* hard    core       unlimited   # Allow corefiles to be temporarily enabled.
END

# lutris: use system libretro cores
# https://github.com/lutris/lutris/issues/2444
ln -sfv "$XDG_CONFIG_HOME/retroarch/cores" "$XDG_DATA_HOME/lutris/runners/retroarch/cores"
# lutris: use system winetricks
# https://github.com/lutris/lutris/issues/2445
# https://github.com/lutris/lutris/pull/2494
rm -f "$XDG_DATA_HOME/lutris/runtime/winetricks/winetricks"
ln -sfv /usr/bin/winetricks "$XDG_DATA_HOME/lutris/runtime/winetricks/winetricks"
chmod 555 "$XDG_DATA_HOME/lutris/runtime/winetricks"

# use main profile, not dev edition dedicated
touch "$HOME/.mozilla/firefox/ignore-dev-edition-profile"

# disable tty motd
touch "$HOME/.hushlogin"

# https://github.com/kakra/wine-proton/blob/rebase/proton_3.16/README.md#hints-to-32-bit-users-applies-also-to-syswow64
sudo sed -i "s/; shm-size-bytes.*/shm-size-bytes=1048576/" /etc/pulse/daemon.conf

# needed for "open with" firefox addon
mkdir "$XDG_DATA_HOME/open_with_addon"
cd "$XDG_DATA_HOME/open_with_addon" || exit 1
wget https://github.com/darktrojan/openwith/raw/master/webextension/native/open_with_linux.py
chmod u+x open_with_linux.py
./open_with_linux.py install

# fix distorted/crackling/robotized audio in discord and some games
# https://askubuntu.com/questions/1102738/crackling-static-in-discord-with-default-audio-output-port-pulseaudio
# https://www.reddit.com/r/discordapp/comments/7si7s3/linux_crackling_sound_in_application/
sudo sed -i "s|load-module module-udev-detect|load-module module-udev-detect tsched=0|g" /etc/pulse/default.pa

# https://wiki.archlinux.org/index.php/Bluetooth#Auto_power-on_after_boot
sudo sed -i "s|#AutoEnable=false|AutoEnable=true|g" /etc/bluetooth/main.conf

# set java version for multimc https://aur.archlinux.org/packages/multimc5/#pinned-700404
# https://github.com/MultiMC/MultiMC5/wiki/FAQ#not-the-right-java-version
# sudo archlinux-java status
sudo archlinux-java set java-8-openjdk

# install some steam play tools
cd "$XDG_DATA_HOME/Steam/compatibilitytools.d" || exit 1
# https://github.com/dreamer/luxtorpeda
curl -L https://luxtorpeda.gitlab.io/luxtorpeda/master/luxtorpeda.tar.xz | tar xJf -
# https://github.com/dreamer/roberta
curl -L https://github.com/dreamer/roberta/releases/download/v0.1.0/roberta.tar.xz | tar xJf -

# copy vimix theme
[[ ! -d /boot/grub/themes/Vimix ]]; sudo cp -r /usr/share/grub/themes/Vimix /boot/grub/themes/Vimix

sudo tee /etc/sudoers.d/psd <<< "bausch ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper"

# relocate fontconfig cache to global dir until xorg is not run as user
# TODO: https://github.com/sddm/sddm/issues/246
sudo chmod 777 /var/cache/fontconfig
ln -sfv /var/cache/fontconfig "$XDG_CACHE_HOME/fontconfig_11"
ln -sfv /var/cache/fontconfig "$XDG_CACHE_HOME/fontconfig"