#!/bin/bash
# shellcheck disable=2016,2162

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

ln -s "$HOME"/{Downloads,Загрузки}
# https://wiki.archlinux.org/index.php/Localization/Russian_(Русский)#Настройка_консоли
sudo tee /etc/vconsole.conf >/dev/null <<END
FONT="ter-v16n"
KEYMAP="ru-utf"
END

# xdg zsh
sudo tee /etc/zsh/zshenv >/dev/null <<< 'ZDOTDIR=$XDG_CONFIG_HOME/zsh'

# add locales
sudo tee /etc/locale.gen >/dev/null <<END
en_US.UTF-8 UTF-8
ja_JP EUC-JP
ja_JP SHIFT_JIS
ja_JP SHIFT_JISX0213
ja_JP.EUC-JP EUC-JP
ja_JP.UTF-8 UTF-8
ru_RU.UTF-8 UTF-8
END

# generate locales
sudo locale-gen -j "$(nproc)"

# settings for x11
#localectl set-x11-keymap us,ru pc104 qwerty grp:rctrl_toggle
#sudo sed -i -e "\$a exec i3" -e '57,65d' /etc/X11/xinit/xinitrc

# for no reason, when systemd-coredump is disabled, my system instead creates large coredump files EVERYWHERE, so disable them entierly
sudo tee -a /etc/security/limits.conf >/dev/null <<END
# disable coredumps entierly
* hard core 0
END

# https://aspiceodyssey.wordpress.com/2017/04/28/fedora25-3d-accelerated-guest/
sudo gpasswd -a qemu video

# lutris: use system libretro cores 
ln -sfv /usr/lib/libretro "$XDG_DATA_HOME/lutris/runners/retroarch/cores"
# lutris: use system winetricks
rm -f  "$XDG_DATA_HOME/lutris/runtime/winetricks/winetricks"
ln -sfv /usr/bin/winetricks "$XDG_DATA_HOME/lutris/runtime/winetricks/winetricks"


# for radeon-profile
sudo tee /etc/sudoers.d/00radeon-profile <<< "bausch ALL = NOPASSWD: /usr/bin/radeon-profile"
