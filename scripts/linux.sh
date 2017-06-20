#!/bin/bash
# shellcheck disable=2016,2162

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

for i in editor visual; do sudo eselect $i set nvim; done
sudo eselect pinentry set pinentry-gnome3
ln -s "$HOME"/{Downloads,Загрузки}
sudo tee /etc/vconsole.conf >/dev/null <<END
FONT="ter-v16v"
KEYMAP="us"
END

# distccd settings
#read -p "Main host ip? " Mhost;
#read -p "Main host threads? " Mthreads;
#read -p "localhost threads? " Lthreads;
#locthrd=${Lthreads:-$(nproc)}
#sudo tee /etc/distcc/hosts >/dev/null <<END
#$Mhost/$Mthreads
#127.0.0.1/$locthrd
#END
#sudo sed -i "s/127.0.0.1/$Mhost/g" /etc/systemd/system/distccd.service.d/00gentoo.conf

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

# restore gnome-terminal config
dconf reset -f /org/gnome/terminal/
dconf load /org/gnome/terminal/ < "$SD"/../home_cp/gnome-terminal/gnome.conf

# ssh and firefox additions, 1) deny root login 2) disable motd 3) no aurora profile
sudo sed -i -e "\$a PermitRootLogin no" -e '/PermitRootLogin/d' /etc/ssh/sshd_config
touch "$HOME/.hushlogin"

# legacy settings for x11
localectl set-x11-keymap us,ru pc104 qwerty grp:rctrl_toggle
sudo sed -i -e "\$a exec i3" -e '57,65d' /etc/X11/xinit/xinitrc
sudo sed -i -e '|\$HOME/.serverauth.\$\$|$XDG_RUNTIME_DIR/.serverauth.$$' /usr/bin/startx
