#!/bin/bash
sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp
sudo add-apt-repository -y ppa:kisak/kisak-mesa
sudo add-apt-repository -y ppa:mymedia/telegram
sudo add-apt-repository -y ppa:kubuntu-ppa/backports
# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# wine
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
# linux-kernel for fsync
# dkms modules need this https://sourceforge.net/projects/xanmod/files/releases/lts/
echo 'deb https://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list && wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key add -
# newer version from ppa until groovy arrives
sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo add-apt-repository -y ppa:openmw/openmw
sudo add-apt-repository -y ppa:alexlarsson/flatpak
# syncthing https://packages.ubuntu.com/groovy/syncthing
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
# vmware https://itsfoss.com/install-vmware-player-ubuntu-1310/
#sudo add-apt-repository -y ppa:ubuntu-toolchain-r/ppa
# rclone with mega backend https://github.com/rclone/rclone/issues/3980
echo "deb https://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
# groovy is supported
sudo add-apt-repository -y ppa:cdemu/ppa
sudo add-apt-repository -y ppa:libretro/stable
sudo add-apt-repository -y ppa:lutris-team/lutris
sudo add-apt-repository -y ppa:jonaski/strawberry # try elisa in 20.10
sudo add-apt-repository -y ppa:maxiberta/kwin-lowlatency
sudo add-apt-repository -y ppa:feignint/dosbox-staging
curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -

sudo apt upgrade -y

cd /tmp || exit 1
# https://www.egregorion.net/ https://store.kde.org/p/1231579/ TODO: try dolphin services in 20.10 
wget --content-disposition https://www.egregorion.net/works/kde/servicemenus/reimage/kde-service-menu-reimage_2.5_all.deb
sudo apt install -y ./kde-service-menu-reimage*.deb
# syncplay
wget --content-disposition https://github.com/Syncplay/syncplay/releases/download/v1.6.5/syncplay_1.6.5.deb
sudo apt install -y ./syncplay*.deb
# vscode # TODO: will vscode ppa be re-enabled after distro upgrade?
wget --content-disposition 'https://go.microsoft.com/fwlink/?LinkID=760868'
sudo apt install -y ./code*.deb
# gb studio
wget --content-disposition 'https://circleci.com/api/v1.1/project/github/chrismaltby/gb-studio/latest/artifacts/0/builds/gb-studio-v2beta-linux_x86_64.deb?branch=v2beta&filter=successful' -O gb.deb
sudo apt install -y ./gb.deb

packages=(
  # optdeps
  network-manager-openvpn
  # TODO: not needed in groovy
  gcc-10
  # partitionmanager
  smartmontools # TODO: https://bugs.kde.org/show_bug.cgi?id=422877 https://www.phoronix.com/scan.php?page=news_item&px=Plasma-5.20-SMART-More
  # dolphin
  dolphin-plugins
  # pulseaudio
  pulseaudio-module-gsettings
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
  linux-xanmod-lts
  lutris
  mpv
  obs-studio
  openmw-launcher
  parallel
  plasma-discover-backend-flatpak
  ppa-purge
  pulseaudio-modules-bt
  python3-{pip,venv}
  qbittorrent
  rclone
  residualvm
  retroarch
  ripgrep
  safeeyes
  scummvm
  shellcheck
  sirikali
  steam
  stow
  strawberry
  syncthing
  telegram-desktop
  translate-shell
  vitetris
  winehq-staging
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

# snaps
sudo snap set system refresh.retain=2
sudo snap set system refresh.timer=fri,9:00~21:00

# i need to manually install this
sudo apt-mark hold linux-libc-dev

# node
yarn set version berry

# flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.jdownloader.JDownloader org.taisei_project.Taisei com.viber.Viber com.github.vladimiry.ElectronMail com.github.ztefn.haguichi com.spotify.Client com.discordapp.Discord com.github.johnfactotum.Foliate com.github.micahflee.torbrowser-launcher com.mojang.Minecraft io.github.antimicrox.antimicrox org.gtk.Gtk3theme.Breeze
flatpak install -y https://flathub.org/beta-repo/appstream/com.google.Chrome.flatpakref
flatpak install -y https://flatpak.citra-emu.org/citra-nightly.flatpakref

# python
sudo pip3 install -U anime-downloader git+https://github.com/simons-public/protonfixes.git protontricks ps_mem vdf

# mpv scripts
cd "$HOME/.config/mpv/scripts" || exit 1
curl -LO https://raw.githubusercontent.com/ElegantMonkey/mpv-webm/master/build/webm.lua

# setup dofiles
../etc_cp/install.sh
../home/install.sh

systemctl enable --now amdgpu
sudo systemctl disable --now cups-browsed cups snapd snapd.socket
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
