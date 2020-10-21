#!/bin/bash
# yarn, debian/ubuntu package is broken https://bugs.launchpad.net/ubuntu/+source/node-yarnpkg/+bug/1899959
wget -qO - https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# https://wiki.winehq.org/Ubuntu
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
# linux-kernel for fsync
echo 'deb https://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list && wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key add -
# newer version from ppa until groovy arrives
sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo add-apt-repository -y ppa:alexlarsson/flatpak
# rclone with mega backend https://github.com/rclone/rclone/issues/3980
echo "deb https://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
# can be disabled on distro upgrade
sudo add-apt-repository -y ppa:kisak/kisak-mesa
sudo add-apt-repository -y ppa:mymedia/telegram
sudo add-apt-repository -y ppa:tomtomtom/woeusb # https://launchpad.net/~tomtomtom/+archive/ubuntu/woeusb or https://launchpad.net/~nilarimogard/+archive/ubuntu/webupd8
sudo add-apt-repository -y ppa:kubuntu-ppa/backports
# groovy is supported
sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp
sudo add-apt-repository -y ppa:cdemu/ppa
sudo add-apt-repository -y ppa:libretro/stable
sudo add-apt-repository -y ppa:lutris-team/lutris
sudo add-apt-repository -y ppa:maxiberta/kwin-lowlatency
sudo add-apt-repository -y ppa:feignint/dosbox-staging
wget -qO - https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo dpkg-reconfigure code # re-enable repo after upgrade

sudo apt upgrade -y

cd /tmp || exit 1
# https://www.egregorion.net/ https://store.kde.org/p/1231579/
wget --content-disposition https://www.egregorion.net/works/kde/servicemenus/reimage/kde-service-menu-reimage_2.5_all.deb
sudo apt install -y ./kde-service-menu-reimage*.deb
# syncplay
wget --content-disposition https://github.com/Syncplay/syncplay/releases/download/v1.6.5/syncplay_1.6.5.deb
sudo apt install -y ./syncplay*.deb
# vscode
wget --content-disposition 'https://go.microsoft.com/fwlink/?LinkID=760868'
sudo apt install -y ./code*.deb

packages=(
  # optdeps
  network-manager-openvpn
  # partitionmanager
  smartmontools # TODO: https://bugs.kde.org/show_bug.cgi?id=422877 https://www.phoronix.com/scan.php?page=news_item&px=Plasma-5.20-SMART-More replace with https://repology.org/project/plasma-disks/versions
  # dolphin
  dolphin-plugins
  # boxtron
  inotify-tools timidity fluid-soundfont-gm
  # not deps
  adb
  bleachbit
  colobot
  dosbox-staging
  earlyoom
  fd-find
  fish
  gamemode
  gcdemu
  gimp
  git-cola
  htop
  internetarchive
  keepassxc
  kubuntu-restricted-extras
  linux-xanmod
  lutris
  mpv
  obs-studio
  openmw-launcher
  plasma-discover-backend-flatpak
  ppa-purge
  pulseaudio-modules-bt
  python3-{pip,venv}
  qbittorrent
  rclone
  retroarch
  ripgrep
  safeeyes
  shellcheck
  sirikali
  steam
  stow
  syncthing
  telegram-desktop
  translate-shell
  vitetris
  winehq-staging
  woeusb
  xclip
  yarn
  zeal
)
# wine and steam need this
sudo dpkg --add-architecture i386
# Install my packages
sudo apt install --install-recommends -y "${packages[@]}"

# dupeguru https://github.com/arsenetar/dupeguru/issues/484
git clone --depth=1 https://github.com/arsenetar/dupeguru /tmp/dupeguru
cd /tmp/dupeguru || exit 1
bash -c "python3 -m venv --system-site-packages env && source env/bin/activate && pip install -r requirements.txt && python3 build.py --clean && python3 package.py"
cd build || exit 1
sudo apt install ./dupeguru*.deb

# snaps https://snapcraft.io/docs/keeping-snaps-up-to-date
sudo snap set system refresh.retain=2
sudo snap set system refresh.timer=fri,9:00~21:00

# node
yarn set version berry

# vmware https://www.namhuy.net/227/enable-3d-hardware-graphics-acceleration-for-vmware-workstation-on-ubuntu
echo 'mks.gl.allowBlacklistedDrivers = "TRUE"' >> "$HOME/.vmware/preferences"

# flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.jdownloader.JDownloader org.taisei_project.Taisei com.viber.Viber com.github.vladimiry.ElectronMail com.github.ztefn.haguichi com.spotify.Client com.discordapp.Discord com.github.johnfactotum.Foliate com.github.micahflee.torbrowser-launcher com.mojang.Minecraft io.github.antimicrox.antimicrox org.freefilesync.FreeFileSync org.gtk.Gtk3theme.Breeze
flatpak install -y https://flatpak.citra-emu.org/citra-nightly.flatpakref

# python
pip3 install -U git+https://github.com/simons-public/protonfixes.git protontricks vdf

# mpv scripts
cd "$HOME/.config/mpv/scripts" || exit 1
curl -LO https://raw.githubusercontent.com/ElegantMonkey/mpv-webm/master/build/webm.lua

# setup dofiles
../etc_cp/install.sh
../home/install.sh

systemctl enable --now amdgpu
#sudo systemctl disable --now cups-browsed cups snapd snapd.socket
systemctl --user enable --now syncthing
chsh -s /usr/bin/fish

# meh
# https://wiki.archlinux.org/index.php/XDG_Autostart
# https://bugs.kde.org/show_bug.cgi?id=413053#c7
mkdir "$HOME/.config/autostart"
cd "$HOME/.config/autostart" || exit 1
sed -e '$aHidden=True' /etc/xdg/autostart/org.kde.discover.notifier.desktop > org.kde.discover.notifier.desktop
sed -e '$aHidden=True' /etc/xdg/autostart/gcdemu.desktop > gcdemu.desktop

# SBC HD
# https://github.com/EHfive/pulseaudio-modules-bt/issues/63#issuecomment-613432583 https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/227
sudo sed -i 's|load-module module-bluetooth-discover|load-module module-bluetooth-discover a2dp_config="sbc_min_bp=47 sbc_max_bp=47 sbc_freq=44k sbc_cmode=dual sbc_alloc=loudness sbc_sbands=8 sbc_blen=16"|g' /etc/pulse/default.pa
