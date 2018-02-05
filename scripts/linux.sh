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

# fill /etc/locale.nopurge
sudo tee /etc/locale.nopurge >/dev/null <<END
MANDELETE
SHOWFREEDSPACE
VERBOSE
en
en_US
en_US.UTF-8
ja
ja_JP
ja_JP.EUC-JP
ja_JP.UTF-8
ru
ru_RU
ru_RU.UTF-8
END

# generate locales
sudo locale-gen -j "$(nproc)"

# clean unneded locales and localized manpages
sudo localepurge

# restore gnome-terminal config
dconf reset -f /org/gnome/terminal/
dconf load /org/gnome/terminal/ < "$SD"/../home_cp/gnome-terminal/gnome.conf

# disable tty motd
touch "$HOME/.hushlogin"

# legacy settings for x11
localectl set-x11-keymap us,ru pc104 qwerty grp:rctrl_toggle
sudo sed -i -e "\$a exec i3" -e '57,65d' /etc/X11/xinit/xinitrc
sudo sed -i -e 's|\$HOME/.serverauth.\$\$|$XDG_RUNTIME_DIR/.serverauth.$$|' /usr/bin/startx

# for no reason, when systemd-coredump is disabled, my system instead creates large coredump files EVERYWHERE, so disable them entierly
sudo tee -a /etc/security/limits.conf >/dev/null <<END
# disable coredumps entierly
* hard core 0
END

# https://aspiceodyssey.wordpress.com/2017/04/28/fedora25-3d-accelerated-guest/
sudo gpasswd -a qemu video
# generating manifests without root
sudo gpasswd -a bausch portage

# fix `warning: failed to load external entity "http://www.gentoo.org/dtd/metadata.dtd"`
# and speedup metadata.xml parsing
# https://github.com/vim-syntastic/syntastic/blob/3.8.0/doc/syntastic-checkers.txt#L2175-L2180
sudo tee /etc/xml/catalog >/dev/null <<< "$(xmlcatalog --add rewriteURI http://www.gentoo.org/dtd/ /usr/portage/metadata/dtd/ /etc/xml/catalog)"

# symlink to fix programs wanting xlocale.h
sudo ln -s /usr/include/xlocale.h locale.h

# notmpfs
sudo mkdir /var/tmp/notmpfs
sudo chown portage:portage /var/tmp/notmpfs
sudo chmod 775 /var/tmp/notmpfs

# snap
#sudo snap install --classic anbox-installer
#/snap/bin/anbox-installer
#cp /snap/anbox-installer/17/installer.sh /tmp
# sed -i /tmp/installer.sh

# see anbox installer for needed kernel modules and installation
#sudo snap install --edge --devmode anbox

sudo tee /etc/subuid >/dev/null <<END
root:100000:65536
root:1000:2
bausch:100000:65536
bausch:1000:2
END

sudo tee /etc/subgid >/dev/null <<END
root:100000:65536
root:1000:2
bausch:100000:65536
bausch:1000:2
END
