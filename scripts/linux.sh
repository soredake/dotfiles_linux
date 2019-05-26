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

# limit ccache size
ccache -M 10G

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

# settings for x11/i3
#localectl set-x11-keymap us,ru pc104 qwerty grp:rctrl_toggle
#sudo sed -i -e "\$a exec i3" -e '57,65d' /etc/X11/xinit/xinitrc

# for no reason, when systemd-coredump is disabled, my system instead creates large coredump files EVERYWHERE, so disable them entierly and raise file descriptors limits for wine esync
sudo tee -a /etc/security/limits.conf >/dev/null <<END
# disable coredumps entierly
* hard core 0
# wine esync
bausch soft nofile 1048576
bausch hard nofile 1048576
END

# wine esync
sudo tee -a /etc/systemd/user.conf >/dev/null <<END
DefaultLimitNOFILE=1048576
END
sudo tee -a /etc/systemd/system.conf >/dev/null <<END
DefaultLimitNOFILE=1048576
END

# https://aspiceodyssey.wordpress.com/2017/04/28/fedora25-3d-accelerated-guest/
sudo gpasswd -a qemu video

# lutris: use system libretro cores 
ln -sfv /usr/lib/libretro "$XDG_DATA_HOME/lutris/runners/retroarch/cores"
# lutris: use system winetricks
rm -f "$XDG_DATA_HOME/lutris/runtime/winetricks/winetricks"
ln -sfv /usr/bin/winetricks "$XDG_DATA_HOME/lutris/runtime/winetricks/winetricks"

# for radeon-profile
sudo tee /etc/sudoers.d/00radeon-profile <<< "bausch ALL = NOPASSWD: /usr/bin/radeon-profile"

# emoji for browser/terminal
# https://www.reddit.com/r/linux/comments/ao0mp3/how_to_better_enable_color_emojis/
# or https://github.com/kovidgoyal/kitty/issues/73#issuecomment-465984396
# test here: https://eosrei.github.io/emojione-color-font/full-demo.html
# or https://aur.archlinux.org/packages/ttf-twemoji-color/
# sudo ln -sf ../conf.avail/56-ttf-twemoji-color.conf /etc/fonts/conf.d/56-ttf-twemoji-color.conf

# use main profile, not dev edition dedicated
touch "$HOME/.mozilla/firefox/ignore-dev-edition-profile"

# disable tty motd
touch "$HOME/.hushlogin"

# disk is slow
#balooctl config add excludeFolders /media/disk0

# https://github.com/kakra/wine-proton/blob/rebase/proton_3.16/README.md#hints-to-32-bit-users-applies-also-to-syswow64
sudo tee -a /etc/pulse/daemon.conf <<< "shm-size-bytes=1048576"

# https://docs.docker.com/config/containers/live-restore/#enable-live-restore
sudo tee -a /etc/docker/daemon.json >/dev/null <<END 
{
  "live-restore": true
}
END

# needed for "open with" firefox addon
wget https://github.com/darktrojan/openwith/raw/master/webextension/native/open_with_linux.py
chmod u+x open_with_linux.py
./open_with_linux.py install
rm open_with_linux.py

# fix distorted/crackling/robotized discord audio
# https://askubuntu.com/questions/1102738/crackling-static-in-discord-with-default-audio-output-port-pulseaudio
# https://www.reddit.com/r/discordapp/comments/7si7s3/linux_crackling_sound_in_application/
sudo sed -i "s|load-module module-udev-detect|load-module module-udev-detect tsched=0|g" /etc/pulse/default.pa